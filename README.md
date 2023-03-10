# IRLLicencingMiddleware
<p align="left">
    <a href="https://doc-irllicencingmiddleware.irlmobile.com/documentation/">
        <img src="https://github.com/irlmob/IRLLicencingMiddleware/raw/main/documentationicon.png" alt="Documentation">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/Swift-5.7-brightgreen.svg" alt="Language">
    </a>
    <a href="https://github.com/irlmob/IRLLicence/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License">
    </a>
</p>

🛃 Protect your `Vapor application` with a `Middleware` Licencing mechanisms.

## Overview

Use this struct to set up license [Middleware](https://docs.vapor.codes/advanced/middleware/) in a [Vapor application](https://www.vapor.codes). Call the `LicencingMiddleware/setup(in:ignoredPathroot:)` method to add the middleware to the application.

- Note: A `LicencingMiddleware` instance can also include a `LicencingCopyrightNotice` instance, which will be printed out to the console when `LicencingMiddleware/setup(in:ignoredPathroot:)` is called.

- Warning: You should perform this setup as the very first step during your application configuration to protect the usage of the application. It will then validate every `Request` to the application against a valid licence.


## Dependencies
- [IRLLicencing](https://github.com/irlmob/IRLLicencing) (iRLMobile) - Licence validation mechanism.
- [Leaf Error Middleware](https://github.com/brokenhandsio/leaf-error-middleware) (0xTim) -  Custom 404 and server error pages. 

## Getting Started

Getting started with `IRLLicencingMiddleware` is easy. Simply add the code to your project, distribute your Framework or Application as a closed source, and lock your code to be usable only with a valid license and email. Once your client verifies the license, your code will be able to run with confidence, knowing that it is fully licensed and secure.

IRLLicencing primarily uses [SwiftPM](https://swift.org/package-manager/) as its build tool, so we recommend using that as well. If you want to depend on IRLLicencing in your own project, it's as simple as adding a `dependencies` clause to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/irlmob/IRLLicencingMiddleware.git", from: "1.0.1")
]
```

#### Swift 5.7 and newer (swift-tools-version:5.7)
```swift
    dependencies: [ "IRLLicencingMiddleware" ]
```

### Using Xcode Package support

If your project is set up as an Xcode project and you're using Xcode 11+, you can add `IRLLicencingMiddleware` as a dependency to your
Xcode project by clicking File -> Swift Packages -> Add Package Dependency. In the upcoming dialog, please enter
`https://github.com/irlmob/IRLLicencingMiddleware.git` and click Next twice. Finally, select the targets you are planning to use (here `IRLLicencingMiddleware`) and click finish. Now will be able to `import IRLLicencingMiddleware` (as well as all
the other targets you have selected) in your project.

## Usage

- Initialize this struct to set up license middleware in your [Vapor application](https://www.vapor.codes), see `LicencingMiddleware/init(notice:licence:)`
- Call the `LicencingMiddleware/setup(in:ignoredPathroot:)` method to add the middleware to the application.

### Example:

```swift
// configures your application
public func configure(_ app: Application) async throws {
    // Licence
    let publicKey: String =
    """
    -----BEGIN PUBLIC KEY-----
    MM...ABC
    -----END PUBLIC KEY-----
    
    """
    
    // Middleware Injection
    try await LicencingMiddleware(notice:  .init(year: "2023",
                                                 copyright: "Company Inc. Headquarter on the moon",
                                                 copyrighter: "Company Inc.",
                                                 projectName: "Example Project",
                                                 subProjectName: "Frontend App",
                                                 version: "v1.0.0"),
                                   licence: try .fromEnv(with: publicKey))
    .setup(in: app)

    // ... Continue setup ...
   }
```

## MIT License
Copyright (c) 2023 iRLMobile

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
