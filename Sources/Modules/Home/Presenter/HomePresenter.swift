import Foundation
import SwiftUI

final class HomePresenter: ObservableObject {
  @Published private(set) var items: [HomeItem] = []
  @Published private(set) var isLoading: Bool = false
  @Published private(set) var errorMessage: String?

  private let interactor: HomeInteractorProtocol
  private let router: HomeRouterProtocol

  init(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }

  @MainActor
  func loadItems() async {
    isLoading = true
    defer { isLoading = false }
    errorMessage = nil
    do {
      items = try await interactor.fetchItems()
    } catch {
      errorMessage = "Failed to load items: \(error.localizedDescription)"
    }
  }

  func makeDetailView(for item: HomeItem) -> some View {
    router.makeDetailView(for: item)
  }
}
