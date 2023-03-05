//
//  LicencingCopyrightNotice.swift
//
//  Created by Denis Martin-Bruillot on 03/03/2023.
//
//  Copyright (c) 2023 Denis Martin-Bruillot.
//  All rights reserved. This code is licensed under the MIT License, which can be found in the LICENSE file.
//

import Foundation

/**
 A struct that provides details for a copyright notice.

 Use this struct to create a ``LicencingMiddleware`` instance with a copyright notice. The copyright notice will be printed out to the console when ``LicencingMiddleware/setup(in:ignoredPathroot:)`` is called on the ``LicencingMiddleware`` instance.
 
 ## Example
 ```swift
 let copyright =  LicencingMiddleware(year: "2023",
                                      copyright: "Company Inc. Headquarter on the moon",
                                      copyrighter: "Company Inc.",
                                      projectName: "Example Project",
                                      subProjectName: "Frontend App",
                                      version: "v1.0.0")
 print(copyright.notice)
 ```
 ```
 ------------------------------------------------------------------------------------------------
 🔑 Example Project | v1.0.0 | Frontend App

 © 2023 Company Inc. Headquarter on the moon, All rights reserved

 This Software is protected by copyright law and international treaty provisions.
 This Software is subject to the terms and conditions in licenses of
 third parties and Company Inc. will use commercially reasonable efforts
 to pass through licenses for Software sublicensed to Customer in providing
 Company Inc.'s Services.

 Customer has no right to inspect, possess, use, copy, or attempt to discover the source code
 (or any portion thereof) used to create this Software, except to the extent that Customer is
 expressly permitted to decompile the Software under applicable law and Customer notifies
 Company Inc. of the intention to decompile this Software
 and Customer's reason to do so.
 ------------------------------------------------------------------------------------------------
 ```
*/
public struct LicencingCopyrightNotice {
    /**
     Initializes a new instance of ``LicencingCopyrightNotice``.
     - Parameters:
         - year: The year of the copyright notice.
         - copyright: The copyright text.
         - copyrighter: The name of the copyright owner.
         - projectName: The name of the project.
         - subProjectName: The name of the sub-project.
         - version: The version number of the project.
         - releaseNote: An optional release note for the project.
     */
    public init(year: String, copyright: String, copyrighter: String, projectName: String, subProjectName: String, version: String, releaseNote: String = "") {
        self.year = year
        self.copyright = copyright
        self.copyrighter = copyrighter
        self.projectName = projectName
        self.subProjectName = subProjectName
        self.version = version
        self.releaseNote = releaseNote
    }
    
    /// The year of the copyright notice.
    public let year: String
    /// The copyright text.
    public let copyright: String
    /// The name of the copyright owner.
    public let copyrighter: String
    /// The name of the project.
    public let projectName: String
    /// The name of the sub-project.
    public let subProjectName: String
    /// The version number of the project.
    public let version: String
    /// An optional release note for the project.
    public var releaseNote: String = ""
    /// The Formatted copyright notice
    public var notice: String {
        let subproject = subProjectName.isEmpty ? "" : "| \(subProjectName)"
        let notes = releaseNote .isEmpty ? "" :
"""

ℹ️ Release Notes:
\(releaseNote)

------------------------------------------------------------------------------------------------

"""
        return """
------------------------------------------------------------------------------------------------
🔑 \(projectName) | \(version) \(subproject)

© \(year) \(copyrighter), All rights reserved

This Software is protected by copyright law and international treaty provisions.
This Software is subject to the terms and conditions in licenses of
third parties and \(copyrighter) will use commercially reasonable efforts
to pass through licenses for Software sublicensed to Customer in providing
\(copyrighter)'s Services.

Customer has no right to inspect, possess, use, copy, or attempt to discover the source code
(or any portion thereof) used to create this Software, except to the extent that Customer is
expressly permitted to decompile the Software under applicable law and Customer notifies
\(copyrighter) of the intention to decompile this Software
and Customer's reason to do so.
------------------------------------------------------------------------------------------------
\(notes)
"""
    }
    
    /**
     Print the copyright notice to the console.
     */
    func printLicence() {
        print(notice)
    }
}
