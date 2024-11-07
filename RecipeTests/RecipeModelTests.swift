//  RecipeTests
//
//  Created by Mohamed Irshad on 11/6/24.
//

import XCTest
@testable import Recipe

class RecipeModelTests: XCTestCase {
    func testRecipeDecoding() throws {
        // Sample JSON for testing
        let json = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                }
            ]
        }
        """.data(using: .utf8)!

        // Parse JSON and check results
        let recipeCollection = try parseRecipeCollection(from: json)
        XCTAssertEqual(recipeCollection.recipes.count, 1)
        let recipe = recipeCollection.recipes.first!
        XCTAssertEqual(recipe.cuisine, "British")
        XCTAssertEqual(recipe.name, "Bakewell Tart")
        XCTAssertEqual(recipe.uuid.uuidString, "eed6005f-f8c8-451f-98d0-4088e2b40eb6")
    }

    func testRecipeDecodingWithNullOptionals() throws {
        // Sample JSON with null optional fields
        let jsonWithNullOptionals = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                }
            ]
        }
        """.data(using: .utf8)!

        // Parse JSON and check results
        let recipeCollection = try parseRecipeCollection(from: jsonWithNullOptionals)
        XCTAssertEqual(recipeCollection.recipes.count, 1)
        let recipe = recipeCollection.recipes.first!
        XCTAssertEqual(recipe.cuisine, "British")
        XCTAssertEqual(recipe.name, "Bakewell Tart")
        XCTAssertEqual(recipe.uuid.uuidString, "eed6005f-f8c8-451f-98d0-4088e2b40eb6")
        XCTAssertNil(recipe.photoURLLarge)
        XCTAssertNil(recipe.photoURLSmall)
        XCTAssertNil(recipe.sourceURL)
        XCTAssertNil(recipe.youtubeURL)
    }

}

// MARK: - Sample JSON Parsing for Unit Tests

/// A sample method to decode JSON data into the `RecipeCollection` model.
/// Useful for testing decoding functionality in unit tests.
func parseRecipeCollection(from jsonData: Data) throws -> RecipeCollection {
    let decoder = JSONDecoder()
    return try decoder.decode(RecipeCollection.self, from: jsonData)
}
