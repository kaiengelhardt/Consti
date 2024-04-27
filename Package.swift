// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "KEConstraints",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.visionOS(.v1),
	],
	products: [
		.library(
			name: "KEConstraints",
			targets: ["KEConstraints"]
		),
	],
	targets: [
		.target(
			name: "KEConstraints",
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency"),
			]
		),
	]
)
