import SwiftUI
import Inject

@main
struct SwiftUIViperApp: App {
  @ObserveInjection var inject
  
  var body: some Scene {
    WindowGroup {
      HomeRouter.createHomeView()
        .enableInjection()
    }
  }
}
