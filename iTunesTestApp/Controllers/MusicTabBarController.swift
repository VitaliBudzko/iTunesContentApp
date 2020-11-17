//
//  MusicTabBarController.swift
//  iTunesTestApp
//
//  Created by admin on 17.11.2020.
//

import UIKit

class MusicTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .fullScreen
        setViewControllers()
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidLayoutSubviews() {
        
        setTabBarSettings()
    }
    
    // Add view controllers into container
    func setViewControllers() {
        let musicFromiTunesVC = MusicFromiTunesVC.storyboardInstance()
        musicFromiTunesVC.title = "All Music"
        musicFromiTunesVC.tabBarItem.image = #imageLiteral(resourceName: "Get loan").withRenderingMode(.alwaysOriginal)
        musicFromiTunesVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "Get loan1").withRenderingMode(.alwaysOriginal)
        
        let storedMusicVC = StoredMusicVC.storyboardInstance()
        storedMusicVC.title = "Saved Music"
        storedMusicVC.tabBarItem.image = #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal)
        storedMusicVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "settings1").withRenderingMode(.alwaysOriginal)
        viewControllers = [musicFromiTunesVC, storedMusicVC]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            item.titlePositionAdjustment = .init(horizontal: 0, vertical: -4)
        }
    }
    
    // Change tab bar settings
    func setTabBarSettings() {
        tabBar.tintColor = UIColor.green
        tabBar.clipsToBounds = true
    }
}
