import Foundation

/// A protocol defining the common interface for fetching data.
protocol DataManager {
    /// Fetches data from a remote URL and decodes it into a given type.
    /// - Parameter T: The type of the object to decode.
    /// - Returns: An object of type `T` that conforms to `Codable`.
    /// - Throws: An error if the data cannot be fetched or decoded.
    func fetchRecipeData<T: Codable>() async throws -> T
}

/// An actor responsible for managing the fetching of data from the network.
actor NetworkDataManager: DataManager {
    
    /// Fetches data from a randomly selected URL and decodes it into the provided type.
    /// - Parameter T: The type of the object to decode.
    /// - Returns: An object of type `T` containing the fetched data.
    /// - Throws: An error if the data cannot be fetched or decoded.
    func fetchRecipeData<T: Codable>() async throws -> T {
        // List of URLs to choose from
        let urls = [
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json",
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json",
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        ]
        
        // Randomly choose one URL
        guard let randomURLString = urls.randomElement(), let url = URL(string: randomURLString) else {
            throw URLError(.badURL)
        }
        
        // Fetch data from the selected URL
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the fetched data into the specified type
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        
        return decodedData
    }
}


/// A mock class that simulates fetching data for testing purposes.
class MockNetworkDataManager: DataManager {
    
    var recipes: [Recipe]
    
    init(_ recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    func fetchRecipeData<T: Codable>() async throws -> T {
        if !recipes.isEmpty {
            return RecipeCollection(recipes: self.recipes) as! T
        }
        
        throw NSError(domain: "MockError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Mock data not available for this type"])
    }
}
