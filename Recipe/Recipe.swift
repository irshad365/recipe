import Foundation

/// A collection of recipes.
struct RecipeCollection: Codable {
    /// List of recipes in the collection.
    let recipes: [Recipe]
}

/// A model representing a recipe with all its details.
struct Recipe: Codable, Identifiable, Hashable {
    /// Enumeration for JSON keys to map properties to the correct keys in JSON data.
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case id = "uuid"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    /// The cuisine of the recipe.
    let cuisine: String
    
    /// The name of the recipe.
    let name: String
    
    /// The URL for the recipe's full-size photo (optional).
    let photoURLLarge: URL?
    
    /// The URL for the recipe's small photo, useful for list views (optional).
    let photoURLSmall: URL?
    
    /// The unique identifier for the recipe, represented as a UUID.
    let id: UUID
    
    /// The URL of the recipe's original source website (optional).
    let sourceURL: URL?
    
    /// The URL of the recipe's YouTube video (optional).
    let youtubeURL: URL?
}
