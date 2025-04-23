import Foundation

/// Central configuration access point for the application
/// Loads values from environment variables, .env file, or falls back to defaults
enum Configuration {
  // MARK: - App Information
  static let appName: String = Configuration.environmentVariable(named: "APP_NAME") ?? "SwiftUIViperApp"
  static let bundleIdPrefix: String = Configuration.environmentVariable(named: "BUNDLE_ID_PREFIX") ?? "com.example"
  static let appGroupId: String = Configuration.environmentVariable(named: "APP_GROUP_ID") ?? "group.com.example.swiftuiviperapp"
  static let teamId: String = Configuration.environmentVariable(named: "TEAM_ID") ?? ""
  
  // MARK: - URLs and Endpoints
  static let apiBaseURL: String = Configuration.environmentVariable(named: "API_BASE_URL") ?? "https://api.example.com"
  
  // MARK: - Features
  static let isAnalyticsEnabled: Bool = Configuration.boolEnvironmentVariable(named: "ANALYTICS_ENABLED") ?? true
  static let isCrashReportingEnabled: Bool = Configuration.boolEnvironmentVariable(named: "CRASH_REPORTING_ENABLED") ?? true
  
  // MARK: - Helper Methods
  private static func environmentVariable(named name: String) -> String? {
    // Check for command-line arguments first
    for argument in ProcessInfo.processInfo.arguments {
      let keyValueArray = argument.split(separator: "=")
      if keyValueArray.count == 2 && keyValueArray[0] == name {
        return String(keyValueArray[1])
      }
    }
    
    // Then check environment variables
    guard let value = ProcessInfo.processInfo.environment[name] else {
      // Check for .env file values if needed
      return loadEnvFile()[name]
    }
    
    return value
  }
  
  private static func boolEnvironmentVariable(named name: String) -> Bool? {
    guard let value = environmentVariable(named: name) else { return nil }
    return value.lowercased() == "true" || value == "1"
  }
  
  private static func loadEnvFile() -> [String: String] {
    var variables: [String: String] = [:]
    
    guard let envPath = Bundle.main.path(forResource: ".env", ofType: nil),
          let envContents = try? String(contentsOfFile: envPath, encoding: .utf8) else {
      return variables
    }
    
    let lines = envContents.components(separatedBy: .newlines)
    for line in lines {
      let trimmedLine = line.trimmingCharacters(in: .whitespaces)
      
      // Skip empty lines and comments
      if trimmedLine.isEmpty || trimmedLine.hasPrefix("#") {
        continue
      }
      
      let parts = trimmedLine.split(separator: "=", maxSplits: 1)
      if parts.count == 2 {
        let key = String(parts[0]).trimmingCharacters(in: .whitespaces)
        let value = String(parts[1]).trimmingCharacters(in: .whitespaces)
        variables[key] = value
      }
    }
    
    return variables
  }
}
