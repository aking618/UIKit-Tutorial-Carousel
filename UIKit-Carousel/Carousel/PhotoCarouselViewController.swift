//
//  PhotoCarouselViewController.swift
//  UIKit-Carousel
//
//  Created by Ayren King on 8/3/24.
//

import Foundation
import UIKit

protocol PhotoCarouselViewControllerDelegate: AnyObject {
    func photoCarouselViewController(_ viewController: PhotoCarouselViewController, didDisplayPhotoAt index: Int)
}

class PhotoCarouselViewController: UIPageViewController {
    weak var carouselDelegate: PhotoCarouselViewControllerDelegate?
    
    private var photos: [PhotoItem]
    private var currentIndex: Int = 0

    init(photos: [PhotoItem]) {
        self.photos = photos
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        if let initialPhotoViewController = photoViewController(at: currentIndex) {
            let viewControllers = [initialPhotoViewController]
            setViewControllers(viewControllers, direction: .forward, animated: false)
        }
    }

    /// Helper method to create a `PhotoViewController` for a given index
    private func photoViewController(at index: Int) -> PhotoViewController? {
        // Ensure the index is within the bounds of the photos array
        guard (0 ..< photos.count).contains(index) else { return nil }
        return PhotoViewController(photoItem: photos[index])
    }
}

// MARK: UIPageViewControllerDataSource
extension PhotoCarouselViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // If there is only one photo, we don't need to page back.
        guard photos.count > 1 else { return nil }

        currentIndex = currentIndex == 0
                        ? photos.count - 1 // Wrap around to the last photo
                        : (currentIndex - 1) % photos.count // Move to the previous photo

        return photoViewController(at: currentIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // If there is only one photo, we don't need to page forward.
        guard photos.count > 1 else { return nil }

        currentIndex = (currentIndex + 1) % photos.count
        return photoViewController(at: currentIndex)
    }
}

// MARK: UIPageViewControllerDelegate
extension PhotoCarouselViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard
            let viewControllers = pageViewController.viewControllers as? [PhotoViewController],
            let index = photos.firstIndex(of: viewControllers[0].photoItem)
        else {
            return
        }
        // Update the current index
        currentIndex = index
        carouselDelegate?.photoCarouselViewController(self, didDisplayPhotoAt: index)
    }

    func pageViewControllerSupportedInterfaceOrientations(_ pageViewController: UIPageViewController) -> UIInterfaceOrientationMask {
        .portrait
    }

    func pageViewControllerPreferredInterfaceOrientationForPresentation(_ pageViewController: UIPageViewController) -> UIInterfaceOrientation {
        .portrait
    }
}

