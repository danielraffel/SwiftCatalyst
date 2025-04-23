# SwiftUI-VIPER-HotReload

A modern SwiftUI iOS project template using VIPER architecture with hot reloading support in Cursor IDE.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Setup Process](#setup-process)
  - [Basic Setup](#basic-setup)
  - [Environment Configuration (Optional)](#environment-configuration-optional)
- [Hot Reloading with InjectIII](#hot-reloading-with-injectiii)
- [Project Structure](#project-structure)
- [VIPER Module Structure](#viper-module-structure)
- [Creating a New VIPER Module](#creating-a-new-viper-module)
- [Customizing the Project](#customizing-the-project)
- [Acknowledgments](#acknowledgments)
- [Contributing](#contributing)
- [License](#license)

## Features

- **VIPER Architecture**: Clean, modular, and testable architecture pattern 
- **SwiftUI**: Modern declarative UI framework
- **Hot Reloading**: Live UI updates without rebuilding
- **XcodeGen**: Project generation to avoid merge conflicts
- **SwiftLint**: Enforced code style and conventions
- **Async/Await**: Modern concurrency handling

## Prerequisites

- Xcode 16.0+ (Supporting iOS 18.0)
- [Cursor IDE](https://cursor.so)
- [Sweetpad extension for Cursor](https://sweetpad.hyzyla.dev)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)
- [SwiftLint](https://github.com/realm/SwiftLint) (optional, `brew install swiftlint`)

## Setup Process

There are two ways to set up this project:

1. **Basic Setup**: Quick start using the default configuration
2. **Environment Configuration**: Advanced setup with customizable environment variables

### Basic Setup

1. **Clone the Repository**

```bash
git clone https://github.com/danielraffel/SwiftUI-VIPER-HotReload.git
cd SwiftUI-VIPER-HotReload
```

2. **Open in Cursor IDE**

Open the project folder in Cursor IDE.

3. **Generate Xcode Project**

Run the following command in the terminal:

```bash
xcodegen
```

This will generate the Xcode project based on the `project.yml` configuration.

4. **Configure Build Server (Only if using Sweetpad)**

If you're using Sweetpad for building within Cursor:

1. Press `Cmd+Shift+P` to open the command palette
2. Type "Sweetpad: Generate Build Server Config" and select it
3. This will create a `buildServer.json` file in your project root

> **Note:** This step is only required if you want to build directly within Cursor IDE using Sweetpad. If you're building in Xcode, you can skip this step.

5. **Configure Keyboard Shortcuts (Optional)**

For an Xcode-like experience with Sweetpad, add these to your Cursor keybindings.json:

```json
[
  {
    "key": "cmd+b",
    "command": "sweetpad.build.build"
  },
  {
    "key": "ctrl+cmd+r",
    "command": "sweetpad.build.launch"
  }
]
```

6. **Build and Run**

Either:
- Open the generated .xcodeproj file in Xcode and run
- Or if using Sweetpad: use the Sweetpad sidebar to select your target and simulator

### Environment Configuration (Optional)

For more customization, use the environment configuration system:

1. **Create Environment File**

Create a `.env` file based on the provided `.env.example` template:

```
# App Configuration
APP_NAME=YourAwesomeApp
BUNDLE_ID_PREFIX=com.yourcompany
APP_GROUP_ID=group.com.yourcompany.yourawesomeapp
TEAM_ID=ABCDEF1234
```

2. **Generate Project File**

Run the included script to generate your project.yml from the template:

```bash
chmod +x generate-project.sh
./generate-project.sh
```

3. **Using Configuration in Code**

The `Configuration.swift` file is already included in the template. You can access environment values in your code like this:

```swift
import Foundation

// Example usage
let appName = Configuration.appName
let apiUrl = Configuration.apiBaseURL
```

> **Note:** You don't need to manually import the Configuration file in each of your files. The setup is already done and it's available throughout the project.

## Hot Reloading with InjectIII

Hot reloading is already configured in this template using the [Inject](https://github.com/krzysztofzablocki/Inject) framework (version 1.5.0).

To use hot reloading:

1. Ensure your app is running in the simulator
2. Make changes to any SwiftUI view
3. Save the file
4. The changes will be immediately reflected in the simulator

Each SwiftUI view should:
- Import the Inject framework
- Include `@ObserveInjection var inject` property
- Add `.enableInjection()` to the view body

Example:

```swift
import SwiftUI
import Inject

struct MyView: View {
    @ObserveInjection var inject
    
    var body: some View {
        Text("Hello, World!")
            .enableInjection()
    }
}
```

## Project Structure

This repository contains a template project with all files at the root level. When using this template:

1. Clone or download this repository
2. Rename the root folder to your project name
3. Update the `name` field in `project.yml` to match your project name
4. Run XcodeGen to generate your Xcode project files

```
.
├── .cursor/                 # Cursor IDE specific settings
│   └── swiftrules.md        # Project coding rules
├── .swiftlint.yml           # SwiftLint configuration
├── .env.example             # Environment variables template
├── Sources/                 # Application source code
│   ├── App.swift            # SwiftUI App entry point
│   ├── Configuration/       # Environment configuration
│   │   └── Configuration.swift
│   ├── Info.plist           # App info property list
│   └── Modules/             # VIPER modules
│       └── Home/            # Home module
│           ├── View/        # SwiftUI views
│           ├── Interactor/  # Business logic
│           ├── Presenter/   # Presentation logic
│           ├── Entity/      # Data models (HomeEntity.swift)
│           └── Router/      # Navigation logic
├── Tests/                   # Test source code
│   ├── Info.plist           # Test info property list
│   └── SwiftUIViperAppTests/
├── .gitignore               # Git ignore file
├── generate-project.sh      # Script for generating project file
├── project.yml.template     # XcodeGen configuration template
└── README.md                # Project documentation
```

## VIPER Module Structure

Each module follows the VIPER architecture pattern:

- **View**: SwiftUI view responsible for UI rendering
- **Interactor**: Contains business logic and communicates with data sources
- **Presenter**: Mediates between View and Interactor, prepares data for presentation
- **Entity**: Data models used by the Interactor and Presenter
- **Router**: Handles navigation and module creation

## Creating a New VIPER Module

To create a new module, follow this structure:

1. Create a new folder under `Sources/Modules/`
2. Add the VIPER components (View, Interactor, Presenter, Entity, Router)
3. Implement the module's functionality following the VIPER pattern

## Customizing the Project

To rename the project to match your needs:

1. Create a custom `.env` file based on `.env.example`
2. Run `./generate-project.sh` to generate your project.yml with custom values
3. Or manually change the `name` property in `project.yml`
4. Regenerate the project using XcodeGen
5. Consider renaming the root module from `Home` to something more descriptive for your application

## Acknowledgments

- [Inject](https://github.com/krzysztofzablocki/Inject) - Hot reloading support
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) - Project generation
- [Sweetpad](https://github.com/alexpotter/sweetpad) - Cursor IDE integration

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
