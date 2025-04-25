# SwiftCatalyst

This project is a modern SwiftUI iOS template designed to make it easy to start building a project quickly using an AI coding tool like Cursor.

It follows the VIPER architecture to keep your code modular and scalable. The template includes built-in support for hot reloading in Cursor so you can see changes in the simulator as you work. It also comes with a set of custom Swift coding rules that guide style and best practices, including a meta-rule that helps you create new Cursor rules.

The project is pre-configured to work with Sweetpad for state previews, XcodeGen for project generation, SwiftLint for code quality enforcement, and InjectionIII for runtime code injection. This setup aims to make it easier to stay consistent, iterate quickly, and extend your codebase with AI assistance.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Setup Process](#setup-process)
  - [Hot Reloading with InjectionIII](#hot-reloading-with-injectioniii)
- [Project Structure](#project-structure)
  - [VIPER Module Structure](#viper-module-structure)
  - [Creating a New VIPER Module](#creating-a-new-viper-module)
  - [Customizing the Project](#customizing-the-project)
- [Acknowledgments](#acknowledgments)
- [FAQ](#faq)
  - [Where can I find my `TEAM_ID`, `APP_GROUP_ID`, and other Apple Developer values?](#-where-can-i-find-my-team_id-app_group_id-and-other-apple-developer-values)
  - [What does the sample app look like](#-what-it-looks-like)
  - [What do the Cursor rule files in this project do?](#-what-do-the-cursor-rule-files-in-this-project-do)
  - [Recommended Project Locations for InjectionIII](#-recommended-project-locations-for-injectioniii)
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

This project depends on several tools and environments. Please ensure the following are installed beforehand:

- Xcode 16.0+ (with support for iOS 18.0)
- [Cursor IDE](https://cursor.so)
- [Sweetpad extension for Cursor](https://sweetpad.hyzyla.dev)
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)
- [SwiftLint](https://github.com/realm/SwiftLint) (`brew install swiftlint`)
- [InjectionIII](https://github.com/johnno1962/InjectionIII/releases/latest) - setup steps included below

---

## Setup Process

This will:
- Create a real project suitable for production use
- Customize project name, bundle IDs, and team ID
- Set up multiple environments (development, staging, production)

Setup steps:

### 1. **Clone the Repository**

```bash
git clone https://github.com/danielraffel/SwiftCatalyst.git
cd SwiftCatalyst
```


### 2. **Open in Cursor IDE**

Open the project folder in Cursor IDE.


### 3. **Create Your `.env` File**

```bash
cp .env.example .env
nano .env
```

Edit the config:
```
# App Configuration
APP_NAME=YourAwesomeApp
BUNDLE_ID_PREFIX=com.yourcompany
APP_GROUP_ID=group.com.yourcompany.yourawesomeapp
TEAM_ID=ABCDEF1234
```

Save and exit nano:
-	Ctrl + O, then Enter to save
-	Ctrl + X to exit

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


### 5. **Install InjectionIII for Hot Reloading**

1. **Download InjectionIII**:
   - Get the latest version from [GitHub Releases](https://github.com/johnno1962/InjectionIII/releases/latest)
   - Download the `InjectionIII.app.zip` file

2. **Install the App**:
   - Unzip the downloaded file
   - Move `InjectionIII.app` to your Applications folder
   - Open the app (right-click and select "Open" if you encounter security warnings)

3. **Start InjectionIII** before running your project for hot reloading to work


### 6. **Build and Run**

You have two options:
- Within Cursor (Recommended): Use the Sweetpad app to choose your target folder, then clean and build to launch the simulator (e.g., `Cmd+Shift+K` to clean and `Cmd+Shift+B` to build).
- Alternatively, in Xcode: Open the generated .xcodeproj file and run the project directly from there.

---

## Hot Reloading with InjectionIII

Hot reloading is already configured in this template using the [Inject](https://github.com/krzysztofzablocki/Inject) framework (version 1.5.0).

### Setting Up Hot Reloading

1. Install InjectionIII from [GitHub Releases](https://github.com/johnno1962/InjectionIII/releases/latest) (download InjectionIII.app.zip)
2. Move InjectionIII.app to your Applications folder
3. Start InjectionIII before running your project

### Using Hot Reloading

To apply changes while the app is running in the simulator:

1. Make changes to any SwiftUI view
2. Save the file
3. The changes will be immediately reflected in the simulator

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

---

## Project Structure

This repository contains a template project with all files at the root level:

```
.
├── .cursor/                              # Cursor IDE specific settings
│   └── rules/                            # Project coding rules
│       ├── cursor-rules-creation.mdc     # Guidelines for project-wide rule authoring
│       ├── git-commits.mdc               # Automating commits to git when succeeded with a requirement
│       └── swift-viper-architecture.mdc  # General Swift project conventions
├── .swiftlint.yml                        # SwiftLint configuration
├── .env.example                          # Environment variables template
├── Sources/                              # Application source code
│   ├── App.swift                         # SwiftUI App entry point
│   ├── Configuration/                    # Environment configuration
│   │   └── Configuration.swift           # Centralized environment variable handler
│   ├── Info.plist                        # App info property list
│   └── Modules/                          # VIPER modules
│       └── Home/                         # Custom module name (eg Home)
│           ├── View/                     # SwiftUI views
│           ├── Interactor/               # Business logic
│           ├── Presenter/                # Presentation logic
│           ├── Entity/                   # Data models (HomeEntity.swift)
│           └── Router/                   # Navigation logic
├── Tests/                                # Source code tests
│   ├── Info.plist                        # Test info property list
│   └── SwiftUIViperAppTests.swift        # Unit tests for Interactor and Presenter logic using XCTest
├── .gitignore                            # Git ignore file
├── generate-project.sh                   # Script for generating project file
├── project.yml.template                  # XcodeGen configuration template
└── README.md                             # Project documentation
```

---

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

---

## Custom Keyboard Shortcuts in Cursor for Sweetpad

For an efficient development workflow in Cursor, configure these keyboard shortcuts to work better with Sweetpad:

1. **Open Cursor Settings**:
   - Press `Cmd+,` (Command + Comma)
   - Select "Keyboard Shortcuts"

2. **Add these shortcuts**:
- `Cmd+Shift+B` → Build & run
- `Cmd+Shift+K` → Clean build
  
![Cursor Sweetpad Shortcuts](https://github.com/user-attachments/assets/b1ac9c74-217e-4dae-9584-8f5128378cc4)

---

## Acknowledgments

- [XcodeGen](https://github.com/yonaskolb/XcodeGen) - Xcode project generation
- [Sweetpad](https://sweetpad.hyzyla.dev) - Cursor IDE integration
- [SwiftLint](https://github.com/realm/SwiftLint) - A tool to enforce Swift style and conventions
- [Inject](https://github.com/krzysztofzablocki/Inject) - Hot reloading support
- [InjectionIII](https://github.com/johnno1962/InjectionIII) - Runtime code injection
- The Cursor Rules system implemented in this project:
  - [cursor-rules-creation.mdc](/.cursor/rules/cursor-rules-creation.mdc) was inspired by [Adithyan](https://www.adithyan.io/blog/writing-cursor-rules-with-a-cursor-rule) and [Geoffrey Huntley](https://ghuntley.com/stdlib/)
  - [git-commits.mdc](/.cursor/rules/git-commits.mdc) was inspired by [Geoffrey Huntley](https://ghuntley.com/stdlib/)
  - [swift-viper-architecture.mdc](/.cursor/rules/swift-viper-architecture.mdc) was inspired by [Swift Cursor Rules](https://www.rayfernando.ai/swift-cursor-rules) by Ray Fernando & Lou Zell.

---

## FAQ

### 📌 Where can I find my `TEAM_ID`, `APP_GROUP_ID`, and other Apple Developer values?

When setting up your `.env` file for the project, you'll need to supply values like `APP_NAME`, `BUNDLE_ID_PREFIX`, `APP_GROUP_ID`, and `TEAM_ID`.

Here's where to find each of them in your [Apple Developer account](https://developer.apple.com/account/):

#### `APP_NAME`

This is your app's display name—**define it yourself** in:
- **Xcode**: Target settings > General > Display Name
- **App Store Connect**: "My Apps" > Select app

#### `BUNDLE_ID_PREFIX`

Typically in the form `com.yourcompany`, this is the custom portion of your app's bundle identifier.

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

---

### 👀 What It Looks Like

After completing setup and running the app, you should see a screen like this:

<img src="https://github.com/user-attachments/assets/2dec6ed0-50ab-4288-ad5f-e6ffa68e292d" alt="Simulator Screenshot" width="20%" />

This shows:
- A **Home** title from the default module
- A welcome message and confirmation of **hot reloading** status
- A **Load Items** button wired to the Presenter and Interactor
- A list of example topics (`Swift`, `UIKit`, etc.) fetched via VIPER flow

You can customize this screen by modifying the Home module or adding new VIPER modules.

---

### 📄 What do the [cursor rule](https://docs.cursor.com/context/rules) files in this project do?
| File | Purpose |
|------|---------|
| [cursor-rules-creation.mdc](/.cursor/rules/cursor-rules-creation.mdc) | A meta-rule that serves as a template/guide for creating new cursor rules specifically formatted for Swift and VIPER architecture. |
| [git-commits.mdc](/.cursor/rules/git-commits.mdc) | Automated rule for creating standardized Git commits in conventional format for Swift projects and all related assets. |
| [swift-viper-architecture.mdc](/.cursor/rules/swift-viper-architecture.mdc) | Contains the project's Swift coding standards and implementation patterns for our VIPER architecture with hot reloading. |

#### Using **`cursor-rules-creation.mdc`** (the meta-rule):
The meta-rule makes creating new rules simple:
1. **Notice a pattern** you want to codify in your codebase
2. **Open a Cursor chat**
3. **Point the AI to your meta-rule** by saying:
   ```
   Using the @cursor-rules-creation.mdc guide...
   ```
4. **Ask it to write a new rule** based on your conversation, for example:
   ```
   Write a rule for our networking layer implementation based on this chat
   ```
5. **Copy the generated rule content** from the chat - Cursor won't save it automatically
6. **Create a new `.mdc` file** in the `.cursor/rules/` directory and paste the content
7. **Commit the new rule** for team sharing

#### When should I create new rules?
Create new rules when:
- Establishing patterns for new features or components
- Setting conventions for specific areas of the codebase (like networking, data models, or UI components)
- Documenting implementation requirements that you find yourself explaining repeatedly
- Adding new architectural patterns or third-party integrations

---

#### Using **`git-commits.mdc`**:
The git commits rule automatically:
1. **Detects file changes** after successful builds or edits
2. **Analyzes the change type** based on file type and description
3. **Determines appropriate scope** based on Swift/VIPER architecture patterns
4. **Formats commit messages** according to conventional commits standard:
   ```
   feat(view): add user profile screen
   fix(networking): resolve API authentication issue
   refactor(presenter): extract presentation logic
   assets(media): add onboarding video
   ```
5. **Groups related files** intelligently based on module structure

---

#### Using **`swift-viper-architecture.mdc`**:
1. **Automatic activation**: These rules are automatically applied when editing matching Swift files.
   
2. **Manual activation**: In a Cursor chat, you can reference this rule with:
   ```
   @swift-viper-architecture.mdc
   ```
   
---

#### Using Configuration in Code

The Configuration.swift file is included in the template and provides access to all environment variables:

```swift
// Example usage
let appName = Configuration.appName
let apiUrl = Configuration.apiBaseURL
```

You don't need to manually import the Configuration file in each of your files - it's available throughout the project.

---

### ✅ Recommended Project Locations for InjectionIII
To avoid permission issues, store your Xcode project outside of:

```
~/Desktop
~/Documents
~/Downloads
Any folder synced with iCloud Drive
```

Instead, use a location like:

```
~/Developer/
~/Projects/
~/Coding/
~/Code/
```
You can create a folder like ~/Developer/MyApp and move your project there.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
