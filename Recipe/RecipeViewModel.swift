//
//  RecipeViewModel.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//
import Foundation
import SwiftUI

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
    
    func loadImage(from imageURL: URL) async -> UIImage? {
        let url = imageURL.absoluteString
        // Check the cache first
        if let cachedImage = await imageCache.getImage(for: url) {
            return cachedImage
        }
                
        // Download the image if it's not cached
        guard let (data, _) = try? await URLSession.shared.data(from: imageURL),
              let image = UIImage(data: data) else {
            return nil
        }
        
        // Save the image to the cache
        await imageCache.saveImage(image, for: url)
        return image
    }
}
