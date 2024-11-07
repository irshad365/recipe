//
//  CachedAsyncImage.swift
//  Recipe
//
//  Created by Mohamed Irshad on 11/7/24.
//

import SwiftUI

/// Reusable CachedAsyncImage component
struct CachedAsyncImage: View {
    let url: URL
    let frameSize: CGFloat
    @Environment(\.imageCache) var imageCache

    var body: some View {
        if let cachedImage = imageCache.getImage(for: url.absoluteString) {
            cachedImage
                .resizable()
                .scaledToFit()
                .frame(width: frameSize, height: frameSize)
        } else {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    cacheAndRender(image: image, url: url.absoluteString)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: frameSize, height: frameSize)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }

    private func cacheAndRender(image: Image, url: String) -> some View {
        imageCache.saveImage(image, for: url)
        return image
            .resizable()
            .scaledToFit()
            .frame(width: frameSize, height: frameSize)
    }
}
