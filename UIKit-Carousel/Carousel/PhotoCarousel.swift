//
//  PhotoCarousel.swift
//  UIKit-Carousel
//
//  Created by Ayren King on 8/3/24.
//

import Foundation
import SwiftUI

struct PhotoCarousel: UIViewControllerRepresentable {
    typealias UIViewControllerType = PhotoCarouselViewController
    
    let photos: [PhotoItem]
    
    init(photos: [PhotoItem]) {
        self.photos = photos
    }
    
    func makeUIViewController(context: Context) -> PhotoCarouselViewController {
        let controller = PhotoCarouselViewController(photos: photos)
        controller.carouselDelegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PhotoCarouselViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

extension PhotoCarousel {
    class Coordinator: PhotoCarouselViewControllerDelegate {
        func photoCarouselViewController(_ viewController: PhotoCarouselViewController, didDisplayPhotoAt index: Int) {
            print(index)
        }
    }
}
