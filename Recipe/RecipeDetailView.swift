//
//  RecipeDetailView.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/7/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @Environment(\.imageCache) var imageCache
    let frameSize: CGFloat = 300
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Cuisine: \(recipe.cuisine)")
                .font(.headline)
                .foregroundColor(.secondary)
            Group {
                if let urlBig = recipe.photoURLLarge {
                    CachedAsyncImage(url: urlBig, frameSize: frameSize)
                } else {
                    Rectangle()
                        .fill(Color.gray)
                }
            }
            .frame(width: frameSize, height: frameSize)

            HStack(spacing: 16) {
                        // Check if youtubeURL is available, if so, display the button
                if let youtubeURL = recipe.youtubeURL {
                            Button(action: {
                                openURL(youtubeURL)
                            }) {
                                HStack {
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.white)
                                    Text("Youtube")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                            }
                            .frame(maxWidth: .infinity)
                        }

                        // Check if websiteURL is available, if so, display the button
                if let websiteURL = recipe.sourceURL {
                            Button(action: {
                                openURL(websiteURL)
                            }) {
                                HStack {
                                    Image(systemName: "globe")
                                        .foregroundColor(.white)
                                    Text("Website")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(16)
        }
        .padding()
        .navigationTitle(recipe.name)
    }
    
    private func openURL(_ url: URL) {
          if UIApplication.shared.canOpenURL(url) {
              UIApplication.shared.open(url)
          }
      }
}

// Preview for RecipeRow
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe:
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

