import XCTest
@testable import SwiftUIViperApp

final class SwiftUIViperAppTests: XCTestCase {
  func testHomeInteractorFetchItems() async throws {
    // Given
    let interactor = HomeInteractor()
    
    // When
    let items = try await interactor.fetchItems()
    
    // Then
    XCTAssertFalse(items.isEmpty, "Items should not be empty")
    XCTAssertEqual(items.count, 5, "Should return 5 items")
  }
  
  func testHomePresenter() async {
    // Given
    let interactor = MockHomeInteractor()
    let router = HomeRouter()
    let presenter = HomePresenter(interactor: interactor, router: router)
    
    // When
    await presenter.loadItems()
    
    // Then
    XCTAssertEqual(presenter.items.count, 3, "Should have 3 items")
    XCTAssertEqual(presenter.items[0].name, "Test 1", "First item should be Test 1")
  }
}

class MockHomeInteractor: HomeInteractorProtocol {
  func fetchItems() async throws -> [HomeItem] {
    return [
      HomeItem(id: UUID(), name: "Test 1"),
      HomeItem(id: UUID(), name: "Test 2"),
      HomeItem(id: UUID(), name: "Test 3")
    ]
  }
}
