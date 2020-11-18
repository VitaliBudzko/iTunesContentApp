//
//  CoreDataManager.swift
//  iTunesTestApp
//
//  Created by admin on 18.11.2020.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init(){}
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    var musicData: MusicData? = nil
    var storedMusic = [MusicData]()

    func saveMusic(musicToSave: Music, completion: COMPLETION_HANDLER) {
        musicData = MusicData(context: managedContext)
        if let image = musicToSave.albumImage.pngData() {
            musicData?.albumImage = image
        }
        musicData?.albumImageURL = musicToSave.albumImageURL
        musicData?.artistName = musicToSave.artistName
        musicData?.primaryGenreName = musicToSave.primaryGenreName
        musicData?.trackId = Int32(musicToSave.trackId)
        musicData?.trackName = musicToSave.trackName
        do {
            try managedContext.save()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func fetchMusicData(onSuccess:(([MusicData]) -> ())) {
        let request = NSFetchRequest <NSFetchRequestResult>(entityName: "MusicData")
        request.returnsObjectsAsFaults = true
        do {
            let music = try managedContext.fetch(request) as! [MusicData]
            print("fetched music data = \(music)")
            onSuccess(music)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteMusicData(musicToDelete: Int) {
        managedContext.delete(storedMusic[musicToDelete])
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
