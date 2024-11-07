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
    
    var body: some View {
        HStack {
            if let urlSmall = recipe.photoURLSmall {
                if let cachedImage = imageCache.getImage(for: urlSmall.absoluteString) {
                    cachedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                } else {
                    AsyncImage(url: urlSmall) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            cacheAndRender(image: image, url: urlSmall.absoluteString)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
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
    }
    
    func cacheAndRender(image: Image, url: String) -> some View {
        imageCache.saveImage(image, for: url)
        return image
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
    }
}

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
