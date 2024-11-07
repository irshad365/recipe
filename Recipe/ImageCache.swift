//
//  ImageCache.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/6/24.
//

import SwiftUI

// Sync struct to handle image caching in a thread-safe manner
class ImageCache {
    private var cache: [String: Image] = [:]
    private let queue = DispatchQueue(label: "ImageCache.queue", attributes: .concurrent)
    
    // Retrieve an image from the cache
    func getImage(for url: String) -> Image? {
        return queue.sync {
            cache[url]
        }
    }
    
    // Save an image to the cache
    func saveImage(_ image: Image, for url: String) {
        queue.async(flags: .barrier) {
            self.cache[url] = image
        }
    }
}
