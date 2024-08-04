//
//  PhotoViewController.swift
//  UIKit-Carousel
//
//  Created by Ayren King on 8/3/24.
//

import Foundation
import SDWebImage
import UIKit

class PhotoViewController: UIViewController {
    var scrollView: UIScrollView!
    var imageView: UIImageView!

    let photoItem: PhotoItem

    init(photoItem: PhotoItem) {
        self.photoItem = photoItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // ScrollView
        scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3 // Adjust as needed
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)

        // ImageView
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.sd_setImage(with: photoItem.imageURL, placeholderImage: photoItem.placeholderImage)
        scrollView.addSubview(imageView)

        // Constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
        
        // Double tap gesture recognizer
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Reset scale when swiping away from photo
        scrollView.setZoomScale(1, animated: false)
    }
    
    @objc private func handleDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let scale: CGFloat = scrollView.zoomScale > 1 ? 1 : 3
        scrollView.setZoomScale(scale, animated: true)
    }
}

extension PhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView // Return the image view for zooming
    }
}
