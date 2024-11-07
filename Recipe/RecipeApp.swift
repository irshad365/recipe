//
//  RecipeApp.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import SwiftUI

//ImageCache()

private struct ImageCacheKey: EnvironmentKey {
  static let defaultValue = ImageCache()
}

extension EnvironmentValues {
  var imageCache: ImageCache {
    get { self[ImageCacheKey.self] }
    set { self[ImageCacheKey.self] = newValue }
  }
}

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(dataManager: NetworkDataManager())
                .environment(\.imageCache, ImageCache())
        }
    }
}
