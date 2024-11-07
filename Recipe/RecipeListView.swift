//
//  RecipeListView.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel: RecipeViewModel
    
    init(dataManager: DataManager) {
        _viewModel = StateObject(wrappedValue: RecipeViewModel(dataManager: dataManager))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.recipes) { recipe in
                                RecipeRow(recipe: recipe)
                                    .padding()
                            }
                        }
                    }
                }
                
                Button("Refresh") {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
                .padding()
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.fetchRecipes()
            }
        }
        .environmentObject(viewModel)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(dataManager: MockNetworkDataManager([Recipe(cuisine: "cuisine", name: "name", photoURLLarge: nil, photoURLSmall: nil, id: UUID(), sourceURL: nil, youtubeURL: nil)]))
    }
}
