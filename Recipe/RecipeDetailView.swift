//
//  RecipeDetailView.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/7/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.largeTitle)
                .padding(.bottom, 10)
            Text("Cuisine: \(recipe.cuisine)")
                .font(.headline)
                .foregroundColor(.secondary)
            
            // Placeholder for recipe photo
            if let imageUrl = recipe.photoURLLarge {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 300)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(recipe.name)
    }
}

