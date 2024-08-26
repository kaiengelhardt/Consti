// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "Consti",
	platforms: [
		.iOS(.v13),
		.macCatalyst(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.visionOS(.v1),
	],
	products: [
		.library(
			name: "Consti",
			targets: ["Consti"]
		),
	],
	targets: [
		.target(
			name: "Consti",
			swiftSettings: [
				.enableExperimentalFeature("StrictConcurrency"),
			]
		),
	]
)
