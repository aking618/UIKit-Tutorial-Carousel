//
//  PhotoItem.swift
//  UIKit-Carousel
//
//  Created by Ayren King on 8/3/24.
//

import Foundation
import UIKit

struct PhotoItem: Identifiable, Equatable {
    let id = UUID()
    let imageURL: URL
    let placeholderImage: UIImage
}
