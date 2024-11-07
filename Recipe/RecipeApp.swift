//
//  RecipeApp.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import SwiftUI

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView(dataManager: NetworkDataManager())
        }
    }
}

