# Recipe Project

This project is a collection of recipes.

## Features

* **CachedAsyncImage.swift:** A reusable SwiftUI component that efficiently displays and caches images from URLs. It leverages Swift's concurrency features and integrates with an image cache for optimal performance.

## Usage

### CachedAsyncImage

The `CachedAsyncImage` component simplifies the process of displaying images from URLs while ensuring efficient caching. Here's how you can use it:
swift CachedAsyncImage(url: imageURL, frameSize: 100)
* `url`: The URL of the image to display.
* `frameSize`: The desired width and height of the image.

**Benefits:**

* **Caching:** Images are cached to reduce network requests and improve loading times.
* **Concurrency:**  Utilizes Swift's concurrency features for smooth image loading.
* **Error Handling:** Provides a fallback image in case of loading failures.
* **Customization:** Easily adjust the frame size to fit your layout.

**Example:**

swift import SwiftUI
struct ContentView: View { let imageURL = URL(string: "https://example.com/image.jpg")!

    var body: some View {
        CachedAsyncImage(url: imageURL, frameSize: 200)
    }
}

This will display the image from the specified URL with a frame size of 200x200 pixels. If the image is already cached, it will be displayed immediately. Otherwise, it will be downloaded and cached for future use.


## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.
