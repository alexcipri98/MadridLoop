import ProjectDescription

let project = Project(
    name: "MadridLoop",
    targets: [
        .target(
            name: "MadridLoop",
            destinations: .iOS,
            product: .app,
            bundleId: "com.alexciprian.MadridLoop",
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": "",
                ],
                "NSLocationWhenInUseUsageDescription": "Necesitamos tu ubicación para mostrar contenido local.",
                "NSLocationAlwaysUsageDescription": "Permite a la app acceder a tu ubicación incluso en segundo plano.",
            ]),
            sources: ["MadridLoop/Sources/**"],
            resources: ["MadridLoop/Resources/**",
                       "MadridLoop/Resources/Configuration/GoogleService-Info.plist"],
            dependencies: [
                .external(name: "FirebaseFirestore"),
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
