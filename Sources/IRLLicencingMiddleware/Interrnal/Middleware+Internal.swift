//
//  Middleware+Internal.swift
//
//  Created by Denis Martin-Bruillot on 03/03/2023.
//
//  Copyright (c) 2023 Denis Martin-Bruillot.
//  All rights reserved. This code is licensed under the MIT License, which can be found in the LICENSE file.
//

import Vapor
import Foundation
import IRLLicence

internal extension LicencingMiddleware {
    private static func generate(_ status: HTTPStatus, _ req: Request) async throws -> LicenceContext {
        LicenceContext(status: status.code.description)
    }
    
    static func build(ignoredPathroot: [String]) throws -> LicenceMiddleware<LicenceContext> {
        allowedPath = ignoredPathroot
        try Request.validate()
        return LicenceMiddleware(contextGenerator: generate)
    }
}

internal struct LicenceContext: Encodable {
    public let status: String?
}

private var allowedPath = [String]()

/// Captures request and validate Licence.
internal final class LicenceMiddleware<T: Encodable>: AsyncMiddleware {
    let contextGenerator: (HTTPStatus, Request) async throws -> T
    
    /// Accepts an optional mapping of error statuses to template names for more granular error page templates
    init(contextGenerator: @escaping ((HTTPStatus, Request) async throws -> T)) {
        self.contextGenerator = contextGenerator
    }
    
    /// See `Middleware.respond`
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        // We will only apply the middleware for valid request, bad request, we don't care
        let res = try await next.respond(to: request)
        if res.status.code < HTTPResponseStatus.badRequest.code, request.isAllowed {
            try request.licencing()
        }
        return try await res.encodeResponse(for: request)
    }
}

private extension HTTPResponseStatus {
    var representsError: Bool {
        return (HTTPResponseStatus.badRequest.code ... HTTPResponseStatus.networkAuthenticationRequired.code) ~= code
    }
}

private extension Request {
    static func validate() throws {
        let isValid = IRLLicenceValidation.validation
        guard isValid.authorized else {
            throw Abort(.serviceUnavailable, reason: isValid.reason)
        }
    }
    
    @discardableResult
    func licencing() throws -> Self {
        try Self.validate()
        guard let host = headers.first(name: .host) else {
            throw Abort(.serviceUnavailable, reason: "Unauthorized. Your request is originating from an invalid Server.")
        }
        guard host == IRLLicenceValidation.licenceAssociatedID else {
            throw Abort(.serviceUnavailable, reason:
                """
                Unauthorized. This Software has been licence to run
                on http://\(IRLLicenceValidation.licenceAssociatedID)
                you are using: \(host)
                """
            )
        }
        return self
    }
    
    var isAllowed: Bool {
        !["assets"].contains(url.path.split(separator: "/").first ?? "")
    }
}
