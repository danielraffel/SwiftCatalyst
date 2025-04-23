import SwiftUI

protocol HomeRouterProtocol {
  func makeDetailView(for item: HomeItem) -> some View
}

final class HomeRouter: HomeRouterProtocol {
  static func createHomeView() -> HomeView {
    let interactor = HomeInteractor()
    let router = HomeRouter()
    let presenter = HomePresenter(interactor: interactor, router: router)
    return HomeView(presenter: presenter)
  }
  
  func makeDetailView(for item: HomeItem) -> some View {
    Text("Detail view for \(item.name)")
      .font(.title)
      .navigationTitle(item.name)
  }
}
