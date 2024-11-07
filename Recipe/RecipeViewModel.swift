//
//  RecipeViewModel.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//
import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    
    private var dataManager: DataManager
    private let imageCache = ImageCache()
    
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil
        do {
            let recipeCollection: RecipeCollection = try await dataManager.fetchRecipeData()
            self.recipes = recipeCollection.recipes
        } catch {
            self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
        }
        isLoading = false
    }

}
