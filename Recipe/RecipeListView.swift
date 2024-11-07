//
//  RecipeListView.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel: RecipeViewModel
    @State private var selectedRecipe: Recipe?
    
    init(dataManager: DataManager) {
        _viewModel = StateObject(wrappedValue: RecipeViewModel(dataManager: dataManager))
    }
    
    var body: some View {
        NavigationSplitView {
            // Master View (List of Recipes)
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    if viewModel.recipes.isEmpty {
                        Text("Error Loading data! Please swipe down to refresh. \(viewModel.errorMessage ?? "")")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    List(viewModel.recipes, id: \.id, selection: $selectedRecipe) { recipe in
                        RecipeRow(recipe: recipe)
                            .onTapGesture {
                                selectedRecipe = recipe
                            }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .padding()
            .navigationTitle("Recipes")
            .task {
                if viewModel.recipes.isEmpty { return }
                await viewModel.fetchRecipes()
            }
            .refreshable {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
        } detail: {
            // Detail View (Selected Recipe)
            if let selectedRecipe = selectedRecipe ?? viewModel.recipes.first {
                RecipeDetailView(recipe: selectedRecipe)
            } else {
                Text("Some friendly message")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }

    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(dataManager: MockNetworkDataManager([Recipe(cuisine: "cuisine", name: "name", photoURLLarge: nil, photoURLSmall: nil, id: UUID(), sourceURL: nil, youtubeURL: nil)]))
    }
}
