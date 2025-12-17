// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "AutopaySdk",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "AutopaySdk",
                 targets: ["AutopaySdk"]),
        .library(name: "AutopaySdkWithoutOCR",
                 targets: ["AutopaySdkWithoutOCR"])
    ],
    targets: [
        .binaryTarget(
            name: "AutopaySdk",
            path: "Artifacts/AutopaySdk.xcframework"
        ),
        .binaryTarget(
            name: "AutopaySdkWithoutOCR",
            path: "Artifacts/AutopaySdkWithoutOCR.xcframework"
        )
    ]
)
