//
//  RecipeRow.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    @EnvironmentObject var viewModel: RecipeViewModel
    @State private var recipeImage: UIImage? = nil
    
    var body: some View {
        HStack {
            if let image = recipeImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
            }
            .padding(.leading, 10)
        }
        .task {
            if let photoURL = recipe.photoURLSmall {
                recipeImage = await viewModel.loadImage(from: photoURL)
            }
        }
    }
}


struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe: Recipe(cuisine: "cuisine", name: "name", photoURLLarge: nil, photoURLSmall: nil, id: UUID(), sourceURL: nil, youtubeURL: nil))
            .environmentObject(RecipeViewModel(dataManager: MockNetworkDataManager([])))
    }
}
