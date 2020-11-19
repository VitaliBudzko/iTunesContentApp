//
//  UIImage.swift
//  iTunesTestApp
//
//  Created by admin on 19.11.2020.
//

import Foundation
import UIKit

extension UIImage {
    
    func makeGrayScale(imageToUpdate: UIImage) -> UIImage {
        let colorImage = CIImage(image: imageToUpdate)!
        let blackAndWhiteImage = colorImage.applyingFilter("CIColorControls", parameters: ["inputSaturation": 0, "inputContrast": 1])
        let resultImage = UIImage(ciImage: blackAndWhiteImage)
        return resultImage
    }
}
