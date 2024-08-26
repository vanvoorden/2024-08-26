// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "Benchmarks",
  platforms: [
    .macOS(.v14)
  ],
  dependencies: [
    .package(
      url: "https://github.com/ordo-one/package-benchmark",
      branch: "main"
    ),
  ],
  targets: [
    .executableTarget(
      name: "Benchmarks",
      dependencies: [
        .product(
          name: "Benchmark",
          package: "package-benchmark"
        ),
      ],
      path: "Benchmarks/Benchmarks",
      linkerSettings: [
        .unsafeFlags([
          "-Xlinker", "-sectcreate",
          "-Xlinker", "__TEXT",
          "-Xlinker", "__info_plist",
          "-Xlinker", "./Resources/Info.plist",
        ])
      ],
      plugins: [
        .plugin(
          name: "BenchmarkPlugin",
          package: "package-benchmark"
        ),
      ]
    ),
  ]
)
