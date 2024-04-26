// swift-tools-version: 5.10

import PackageDescription

let package = Package(
	name: "KEConstraints",
	products: [
		.library(
			name: "KEConstraints",
			targets: ["KEConstraints"]
		),
	],
	targets: [
		.target(
			name: "KEConstraints"
		),
		.testTarget(
			name: "KEConstraintsTests",
			dependencies: ["KEConstraints"]
		),
	]
)
