# SwiftUI-VIPER-HotReload

A modern SwiftUI iOS project template using VIPER architecture with hot reloading support in Cursor IDE.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Setup Process](#setup-process)
  - [Environment Configuration (Recommended)](#environment-configuration-recommended)
  - [Basic Setup (Quick Start)](#basic-setup-quick-start)
- [Hot Reloading with InjectIII](#hot-reloading-with-injectiii)
- [Project Structure](#project-structure)
- [VIPER Module Structure](#viper-module-structure)
- [Creating a New VIPER Module](#creating-a-new-viper-module)
- [Customizing the Project](#customizing-the-project)
- [Acknowledgments](#acknowledgments)
- [FAQ](#faq)
- [Contributing](#contributing)
- [License](#license)

## Features

- **VIPER Architecture**: Clean, modular, and testable architecture pattern 
- **SwiftUI**: Modern declarative UI framework
- **Hot Reloading**: Live UI updates without rebuilding
- **XcodeGen**: Project generation to avoid merge conflicts
- **SwiftLint**: Enforced code style and conventions
- **Async/Await**: Modern concurrency handling
- **Environment Configuration**: Customizable project settings through environment variables

## Prerequisites

- Xcode 16.0+ (Supporting iOS 18.0)
- [Cursor IDE](https://cursor.so)
- [Sweetpad extension for Cursor](https://sweetpad.hyzyla.dev)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)
- [SwiftLint](https://github.com/realm/SwiftLint) (optional, `brew install swiftlint`)

## Setup Process

There are two ways to set up this project:

1. **Environment Configuration (Recommended)**: Using environment variables for flexible customization
2. **Basic Setup (Quick Start)**: Fast setup without customization

### Environment Configuration (Recommended)

This is the recommended approach for:
- Creating a real project you plan to use in production
- Customizing project name, bundle IDs, and team ID
- Setting up multiple environments (development, staging, production)
- Team projects with multiple developers

Setup steps:

### 1. **Clone the Repository**

```bash
git clone https://github.com/danielraffel/SwiftUI-VIPER-HotReload.git
cd SwiftUI-VIPER-HotReload
```

### 2. **Open in Cursor IDE**

Open the project folder in Cursor IDE.

### 3. **Create Environment File**

Create a `.env` file based on the provided `.env.example` template:

```
# App Configuration
APP_NAME=YourAwesomeApp
BUNDLE_ID_PREFIX=com.yourcompany
APP_GROUP_ID=group.com.yourcompany.yourawesomeapp
TEAM_ID=ABCDEF1234
```

[See FAQ below](#faq) if unsure about any of the values in this step.

### 4. **Generate Project File**

Run the included script to generate your project.yml from the template:

```bash
chmod +x generate-project.sh
./generate-project.sh
```

This will:
- Generate a `project.yml` file with your custom values
- Run XcodeGen to create the Xcode project
- Inform you of the process with detailed logs

### 5. **Optional: Configure Build Server (Only for Sweetpad Builds)**

> **👋 New to this? Here's the quick takeaway:**  
> If you're happy coding in **Cursor** and building/running your app in **Xcode**, you can **skip this step**.  
>  
> But if you'd rather stay entirely inside Cursor — *code, build, and run all in one place* — then keep reading.

To build and run your app **directly within the Cursor IDE using Sweetpad**, you’ll need to set up a build server configuration:

1. Press `Cmd+Shift+P` to open the command palette  
2. Type **“Sweetpad: Generate Build Server Config”** and select it  
3. This will create a `buildServer.json` file in your project root

#### 🧰 You'll Also Need: `xcode-build-server`

If you go this route, you’ll need [`xcode-build-server`](https://github.com/ChimeHQ/xcode-build-server), a tool that connects Cursor’s Sweetpad with Xcode’s build system using the Build Server Protocol.

To install it:

```bash
brew install chimehq/tap/xcode-build-server
```

#### 💡 Why do this?

- Lets you **build and run your app inside Cursor** without opening Xcode
- Supports a smoother, keyboard-driven, IDE-native workflow
- Ideal if you want a *lightweight, all-in-one dev environment*

> **Again, this step is 100% optional.**  
> You can always build using Xcode and just use Cursor for editing if that’s more comfortable.

### 6. **Build and Run**

Either:
- Open the generated .xcodeproj file in Xcode and run
- Or if using Sweetpad: use the Sweetpad sidebar to select your target and simulator

### Basic Setup (Quick Start)

This approach is useful for:
- Quick evaluation of the template
- Running demo projects
- Prototyping without worrying about configuration details

Be aware that this approach uses default values for project name, bundle IDs, etc., and doesn't fully utilize the configuration system.

#### 1. **Clone the Repository**

```bash
git clone https://github.com/danielraffel/SwiftUI-VIPER-HotReload.git
cd SwiftUI-VIPER-HotReload
```

####2. **Open in Cursor IDE**

Open the project folder in Cursor IDE.

#### 3. **Create Project File and Generate Xcode Project**

Since this template uses a template-based project configuration, you need to create a project.yml file first:

```bash
cp project.yml.template project.yml
xcodegen
```

This will:
- Create a basic project.yml file with default values
- Generate an Xcode project with the name "SwiftUIViperApp"

> **Note:** This approach uses default values and doesn't fully utilize the environment configuration system. For a more customized setup, use the Environment Configuration approach.

#### 4. **Build and Run**

Open the generated .xcodeproj file in Xcode and run.

## Using Configuration in Code

The Configuration.swift file is included in the template and provides access to all environment variables:

```swift
// Example usage
let appName = Configuration.appName
let apiUrl = Configuration.apiBaseURL
```

You don't need to manually import the Configuration file in each of your files - it's available throughout the project.

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

This repository contains a template project with all files at the root level:

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
│   └── SwiftUIViperAppTests.swift
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

To rename the project or customize other aspects:

1. **Using Environment Configuration (Recommended)**
   - Create a custom `.env` file based on `.env.example`
   - Run `./generate-project.sh` to generate your project.yml with custom values
   - This approach allows you to easily configure:
     - Project name
     - Bundle IDs
     - Team ID 
     - App Group ID
     - Other project-wide settings

2. **Manual Customization**
   - Manually change the `name` property in `project.yml` (after creating it from the template)
   - Update `bundleIdPrefix` and other settings as needed
   - Regenerate the project using XcodeGen

Regardless of approach, consider:
- Renaming the root module from `Home` to something more descriptive for your application
- Updating module names to match your application's domain

## Optional Sweetpad Integration

Sweetpad allows you to build and run directly from Cursor IDE:

1. **Configure Keyboard Shortcuts**

For an Xcode-like experience, add these to your Cursor keybindings.json:

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

2. **Using Sweetpad to Build and Run**

- Use the Sweetpad sidebar to select your target and simulator
- Click the "Run" button or use your configured keyboard shortcuts

## Acknowledgments

- [Inject](https://github.com/krzysztofzablocki/Inject) - Hot reloading support
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) - Project generation
- [Sweetpad](https://sweetpad.hyzyla.dev) - Cursor IDE integration

## FAQ

### 📌 Where can I find my `TEAM_ID`, `APP_GROUP_ID`, and other Apple Developer values?

When setting up your `.env` file for the project, you’ll need to supply values like `APP_NAME`, `BUNDLE_ID_PREFIX`, `APP_GROUP_ID`, and `TEAM_ID`.

Here’s where to find each of them in your [Apple Developer account](https://developer.apple.com/account/):

#### `APP_NAME`

This is your app's display name—**define it yourself** in:
- **Xcode**: Target settings > General > Display Name
- **App Store Connect**: "My Apps" > Select app

#### `BUNDLE_ID_PREFIX`

Typically in the form `com.yourcompany`, this is the custom portion of your app’s bundle identifier.

You define it when you create the app's App ID in:
- [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/identifiers/list) > Identifiers

#### `APP_GROUP_ID`

Used for sharing data between app targets. Looks like: `group.com.yourcompany.yourawesomeapp`.

To create:
1. Go to [Identifiers](https://developer.apple.com/account/resources/identifiers/list/applicationGroup)
2. Select your app or create one
3. Enable **App Groups** and register a new one

Then add this group in Xcode under:
- **Signing & Capabilities** > App Groups

#### `TEAM_ID`

Your 10-character Apple Team ID. Find it at:
- [Apple Developer](https://developer.apple.com/account#MembershipDetailsCard)

#### `.env` Example

These values are then placed in your `.env` file like so:

```env
APP_NAME=YourAwesomeApp
BUNDLE_ID_PREFIX=com.yourcompany
APP_GROUP_ID=group.com.yourcompany.yourawesomeapp
TEAM_ID=ABCDEF1234
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
