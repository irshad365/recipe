//
//  RecipeViewModelTests.swift
//  RecipeTests
//
//  Created by Mohamed Irshad on 11/6/24.
//

import XCTest
@testable import Recipe

class RecipeViewModelTests: XCTestCase {
    
    // Test successful data fetching with MockNetworkDataManager
    func testFetchRecipesSuccess() async throws {
        // Given
        let mockDataManager = MockNetworkDataManager()
        let viewModel = RecipeViewModel(dataManager: mockDataManager)
        
        // When
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.recipes.first?.name, "Bakewell Tart")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // Test failure scenario when an error occurs while fetching data
    func testFetchRecipesFailure() async throws {
        // Given
        let mockDataManager = MockNetworkDataManager()
        let viewModel = RecipeViewModel(dataManager: mockDataManager)
        
        // When
        await viewModel.fetchRecipes()
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "Failed to load recipes: Mock error")
    }
}
