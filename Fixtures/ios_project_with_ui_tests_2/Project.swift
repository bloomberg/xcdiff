import ProjectDescription

let project = Project(
    name: "Project",
    targets: [
        Target(
            name: "MyApp",
            platform: .iOS,
            product: .app,
            bundleId: "net.testing.trials.MyApp",
            infoPlist: .file(path: "MyApp/Info.plist"),
            sources: [
                "MyApp/**"
            ]
        ),
        Target(
            name: "MyAppUITests",
            platform: .iOS,
            product: .uiTests,
            bundleId: "net.testing.trials.MyAppUITests",
            infoPlist: .file(path: "MyAppUITests/Info.plist"),
            sources: [
                "MyAppUITests/**"
            ],
            dependencies: [
                .target(name: "MyApp")
            ]
        ),
    ]
)
