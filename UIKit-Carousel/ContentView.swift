//
//  ContentView.swift
//  UIKit-Carousel
//
//  Created by Ayren King on 8/3/24.
//

import SwiftUI

struct ContentView: View {
    let photos: [PhotoItem] = [
        PhotoItem(
            imageURL: URL(string: "https://picsum.photos/500")!,
            placeholderImage: UIImage(systemName: "exclamationmark.triangle")!
        ),
        PhotoItem(
            imageURL: URL(string: "https://picsum.photos/501")!,
            placeholderImage: UIImage(systemName: "exclamationmark.triangle")!
        ),
        PhotoItem(
            imageURL: URL(string: "https://picsum.photos/502")!,
            placeholderImage: UIImage(systemName: "exclamationmark.triangle")!
        )
    ]
    
    var body: some View {
        VStack {
            PhotoCarousel(photos: photos)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

