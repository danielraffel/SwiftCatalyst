import SwiftUI
import Inject

struct HomeView: View {
  @ObserveInjection private var injected
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text("VIPER Hot Reload Test")
          .font(.title)
          .multilineTextAlignment(.center)
          .padding()

        Button("Load Items") {
          Task {
            await presenter.loadItems()
          }
        }
        .buttonStyle(.borderedProminent)

        if presenter.isLoading {
          ProgressView()
            .padding()
        } else {
          List(presenter.items) { item in
            Text(item.name)
              .padding()
          }
        }

        Text("Hot Reload: \(Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle") != nil ? "Enabled" : "Disabled")")
          .font(.caption)
          .foregroundColor(Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle") != nil ? .green : .red)
          .padding(.top)

        Spacer()
      }
      .navigationTitle("Home")
      .padding()
    }
    .enableInjection()
  }
}

// PreviewProvider for Xcode 16.3 compatibility
struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeRouter.createHomeView()
  }
}
