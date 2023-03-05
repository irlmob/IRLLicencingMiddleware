//
//  ProvidedLicence.swift
//
//  Created by Denis Martin-Bruillot on 03/03/2023.
//
//  Copyright (c) 2023 Denis Martin-Bruillot.
//  All rights reserved. This code is licensed under the MIT License, which can be found in the LICENSE file.
//

import Foundation
import Vapor
/**
 A struct that represents a provided license.
 Use this struct to represent a provided license, which includes the public key, email, domain, and license itself.
 
 You can create a new instance of ``LicencingProvidedLicence`` by calling its initializer ``init(publicKey:email:domain:licence:)`` with the necessary information,
 
 or by calling its ``fromEnv(with:)`` method to retrieve the information from environment variables.
 - Note: The email, domain, and license can be retrieved from environment variables named `LICENCE_EMAIL`, `LICENCE_DOMAIN`, and `LICENCE_APP`, respectively.
 */
 public struct LicencingProvidedLicence {
    /// The public key associated with the provided license.
    public let publicKey: String
    /// The email associated with the provided license.
    public let email: String
    /// The domain associated with the provided license.
    public let domain: String
    /// The license itself.
    public let licence: String

    /**
     Initializes a new instance of ``LicencingProvidedLicence``.

     - Parameters:
         - publicKey: The public key associated with the provided license.
         - email: The email associated with the provided license.
         - domain: The domain associated with the provided license.
         - licence: The license itself.
     */
    public init(publicKey: String, email: String, domain: String, licence: String) {
        self.publicKey = publicKey
        self.email = email
        self.domain = domain
        self.licence = licence
    }
    
    /**
     Creates a new instance of ``LicencingProvidedLicence`` by retrieving the necessary information from environment variables.

     - Note: The email, domain, and license can be retrieved from environment variables named `LICENCE_EMAIL`, `LICENCE_DOMAIN`, and `LICENCE_APP`, respectively.

     - Parameters:
         - publicKey: The public key associated with the provided license.
     - Returns: A new instance of ``LicencingProvidedLicence``.
     */
    public static func fromEnv(with publicKey: String) throws -> Self {
        // Get the environment variables
        guard let email = Environment.get("LICENCE_EMAIL"),
              let domain = Environment.get("LICENCE_DOMAIN"),
              let licence = Environment.get("LICENCE_APP") else {
            throw Abort(.serviceUnavailable,
                        reason: "You must set your env variables LICENCE_EMAIL / LICENCE_APP / LICENCE_DOMAIN")
        }
        return .init(publicKey: publicKey, email: email, domain: domain, licence: licence)
    }
 }

