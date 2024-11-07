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
                        Text("Error Loading data! \(viewModel.errorMessage ?? "")")
                            .font(.title2)
                            .foregroundColor(.gray)
                        Button {
                            Task {
                                await viewModel.fetchRecipes()
                            }
                        } label: {
                            Text("Refresh")
                        }
                        
                    }
                    List(viewModel.recipes, id: \.id, selection: $selectedRecipe) { recipe in
                        ZStack {
                            if selectedRecipe == recipe {
                                Color.blue.opacity(0.2)
                                    .cornerRadius(8)
                            } else {
                                Color.clear
                            }
                            
                            HStack {
                                RecipeRow(recipe: recipe)
                                Spacer()
                            }
                            .onTapGesture {
                                selectedRecipe = recipe
                            }
                        }
                        .listRowInsets(EdgeInsets())
                    }
                    .background(Color.white)
                    .listStyle(.inset)
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
            if let selectedRecipe = selectedRecipe {
                RecipeDetailView(recipe: selectedRecipe)
            } else {
                Text("Some friendly message to select a recipe")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe =  Recipe(cuisine: "Malaysian",
                             name: "Apam Balik",
                             photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                             photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
                             id: UUID(),
                             sourceURL: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"),
                             youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
        )
        let array = [recipe, Recipe(cuisine: "cuisine", name: "name", photoURLLarge: nil, photoURLSmall: nil, id: UUID(), sourceURL: nil, youtubeURL: nil)]
        RecipeListView(dataManager: MockNetworkDataManager(array))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
