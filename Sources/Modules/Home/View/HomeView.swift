import SwiftUI
import Inject

struct HomeView: View {
  @ObserveInjection var inject
  @ObservedObject var presenter: HomePresenter
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text("Welcome to VIPER Architecture")
          .font(.title)
          .multilineTextAlignment(.center)
          .padding()
        
        Text("Hot Reloading Enabled")
          .font(.headline)
          .foregroundColor(.green)
        
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
        
        Spacer()
      }
      .navigationTitle("Home")
      .padding()
    }
    .enableInjection()
  }
}

#Preview {
  HomeRouter.createHomeView()
}
