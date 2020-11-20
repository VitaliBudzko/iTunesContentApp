//
//  UIViewController.swift
//  iTunesTestApp
//
//  Created by admin on 10.11.2020.
//

import Foundation
import UIKit
import AVFoundation

extension UIViewController {
    
    static func storyboardInstance<T: UIViewController>() -> T {
        let storyboard = UIStoryboard.init(name: String(describing: self), bundle: nil)
        let instance = storyboard.instantiateInitialViewController() as? T
        if instance != nil {
            return instance!
        } else {
            fatalError("Fail create instance \(String.init(describing: self))")
        }
    }
    
    func addSystemSound(soundID: Int32) {
        let sound = SystemSoundID(soundID)
        AudioServicesPlaySystemSound(sound)
    }
}
