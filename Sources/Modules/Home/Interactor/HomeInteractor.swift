import Foundation

protocol HomeInteractorProtocol {
  func fetchItems() async throws -> [HomeItem]
}

final class HomeInteractor: HomeInteractorProtocol {
  func fetchItems() async throws -> [HomeItem] {
    // Simulate network delay
    try await Task.sleep(for: .seconds(1))
    
    // Return mock data
    return [
      HomeItem(id: UUID(), name: "Swift"),
      HomeItem(id: UUID(), name: "UIKit"),
      HomeItem(id: UUID(), name: "SwiftUI"),
      HomeItem(id: UUID(), name: "Combine"),
      HomeItem(id: UUID(), name: "Concurrency")
    ]
  }
}
