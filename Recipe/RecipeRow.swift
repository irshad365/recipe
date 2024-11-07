//
//  RecipeRow.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    @Environment(\.imageCache) var imageCache
    let frameSize: CGFloat = 80

    var body: some View {
        HStack {
            if let urlSmall = recipe.photoURLSmall {
                CachedAsyncImage(url: urlSmall, frameSize: frameSize)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: frameSize, height: frameSize)
            }

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
            }
            .padding(.leading, 10)
        }
    }
}

// Preview for RecipeRow
struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipe:
                    Recipe(cuisine: "Malaysian",
                           name: "Apam Balik",
                           photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                           photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
                           id: UUID(),
                           sourceURL: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"),
                           youtubeURL: URL(string: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
                          )
        )
        .environment(\.imageCache, ImageCache())
    }
}
