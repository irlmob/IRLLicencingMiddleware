// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: Name
let name: String = "IRLLicencingMiddleware"
// MARK: Plateforms
let platforms: [SupportedPlatform] = [
    .macOS(.v12)
]

// MARK: Products
var products = [Product]()
var dependencies = [Package.Dependency]()
var targets = [Target]()

products.append(contentsOf: [
    .library(name: "IRLLicencingMiddleware", targets: [ "IRLLicencingMiddleware" ])
])

dependencies.append(contentsOf: [
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    .package(url: "https://github.com/brokenhandsio/leaf-error-middleware.git", from: "4.1.1"),
    .package(url: "https://github.com/irlmob/IRLLicence.git", from: "1.0.2")
])

targets.append(contentsOf: [
    // Vapor Licencing
    .target(name: "IRLLicencingMiddleware", dependencies: [
        .product(name: "Vapor", package: "vapor"),
        .product(name: "IRLLicence", package: "IRLLicence"),
        .product(name: "LeafErrorMiddleware", package: "leaf-error-middleware")
    ])
])

// MARK: Package Definition
let package = Package(
    name: name, defaultLocalization: "en", platforms: platforms, products: products, dependencies: dependencies, targets: targets
)
