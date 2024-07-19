//
//  UIImagesView+Extension.swift
//  FoodDelivery
//
//  Created by Mukhlis Akbar on 18/07/24.
//

import Foundation
import UIKit

extension UIImageView {
    /// Load URL for UIImageView
    /// - Parameter url: url to be loaded
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
