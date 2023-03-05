//
//  Middleware.swift
//
//  This file contains the middleware used to implement IRLLicencing functionality.
//  The middleware validates the license data provided by the client and ensures that
//  it is associated with the correct App Bundle ID and email.
//
//  Created by Denis Martin-Bruillot on 03/03/2023.
//
//  Copyright (c) 2023 Denis Martin-Bruillot.
//  All rights reserved. This code is licensed under the MIT License, which can be found in the LICENSE file.
//

import Vapor
import IRLLicence
import LeafErrorMiddleware

/**
 A struct that provides licensing details.

 Use this struct to set up license middleware in a Vapor application. Call the ``setup(in:ignoredPathroot:)`` method to add the middleware to the application.
 
 - Parameters:
     - notice: An optional ``LicencingCopyrightNotice`` instance.
     - licence: A ``LicencingProvidedLicence`` instance.
 
 - Warning: You should call pefrom this setup as the very first step during your application configuration.
 
 - Note: A ``LicencingMiddleware`` instance can also include a ``LicencingCopyrightNotice`` instance, which will be printed out to the console when ``setup(in:ignoredPathroot:)`` is called.
 */
 public struct LicencingMiddleware {
    /// A typealias for ``LicencingCopyrightNotice``.
    public typealias Notice = LicencingCopyrightNotice
    /// A typealias for ``LicencingProvidedLicence``.
    public typealias Licencing = LicencingProvidedLicence

    /**
     Initializes a new instance of ``LicencingMiddleware``.

     - Parameters:
         - notice: An optional ``LicencingCopyrightNotice`` instance.
         - licence: A ``LicencingProvidedLicence`` instance.
     */
    @discardableResult
    public init(notice: Notice? = nil, licence: Licencing) {
        self.notice = notice
        self.licence = licence
    }
    
    /// An optional ``LicencingCopyrightNotice`` instance.
    public let notice: Notice?
    
    /// A ``LicencingProvidedLicence`` instance.
    public let licence: Licencing

    /**
     Sets up the license middleware in the given [Vapor application](https://www.vapor.codes).

     - Parameters:
         - app: The [Vapor application](https://www.vapor.codes).
         - ignoredPathroot: (optional)  root path that will be ignored. Default: `[ "assets" ]`
     */
    public func setup(in app: Application, ignoredPathroot: [String] = ["assets"]) async throws {
        // Print our notice
        notice?.printLicence()
        
        // Server Error/404
        app.middleware.use(LeafErrorMiddlewareDefaultGenerator.build())
        try await IRLLicenceValidation.licence(publicKey: licence.publicKey,
                                               email: licence.email,
                                               associatedID: licence.domain,
                                               licence: licence.licence)
        // Licence middleware
        try app.middleware.use(LicencingMiddleware.build(ignoredPathroot: ignoredPathroot))
    }
 }

