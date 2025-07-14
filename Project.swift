import ProjectDescription

let project = Project(
    name: "MadridLoop",
    targets: [
        .target(
            name: "MadridLoop",
            destinations: .iOS,
            product: .app,
            bundleId: "com.alexciprian.MadridLoop",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["MadridLoop/Sources/**"],
            resources: ["MadridLoop/Resources/**"],
            dependencies: [
                .xcframework(path: "Frameworks/DependencyInjector.xcframework"),
                .xcframework(path: "Frameworks/DataLayer.xcframework"),
                .xcframework(path: "Frameworks/PresentationLayer.xcframework"),
                .xcframework(path: "Frameworks/Navigation.xcframework")
            ]
        ),
        .target(
            name: "MadridLoopTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.alexciprian.MadridLoopTests",
            infoPlist: .default,
            sources: ["MadridLoop/Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "MadridLoop")
            ]
        ),
    ]
)
