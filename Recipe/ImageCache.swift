//
//  ImageCache.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import UIKit

// Actor to handle image caching in a thread-safe manner
actor ImageCache {
    private var cache: [String: UIImage] = [:]

    // Retrieve an image from the cache
    func getImage(for url: String) -> UIImage? {
        return cache[url]
    }

    // Save an image to the cache
    func saveImage(_ image: UIImage, for url: String) {
        cache[url] = image
    }
}
