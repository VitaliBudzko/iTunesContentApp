//
//  RequestManager.swift
//  iTunesTestApp
//
//  Created by admin on 10.11.2020.
//

import Foundation
import UIKit

class RequestManager {
    
    static func getDataFromiTunes(searchString: String, onSuccess: @escaping(([Music]) -> ())) {
        var songs = [Music]()
        let validatedString = searchString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlHostAllowed)
        let url = URL(string: "https://itunes.apple.com/search?term=\(validatedString!)&media=music")
        print("request url = \(String(describing: url))")

        let session = URLSession.shared
        session.dataTask(with: url!) { (data, _, _) in
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                if let musicCollection = json["results"] as? [Dictionary<String,Any>] {
                    for item in musicCollection {
                        let song = Music(trackName: item["trackName"] as! String,
                                         artistName: item["artistName"] as! String,
                                         primaryGenreName: item["primaryGenreName"] as! String,
                                         albumImageURL: item["artworkUrl60"] as! String
                        )
                        songs.append(song)
                    }
                }
                onSuccess(songs)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
      
    static func getImageFromiTunes(imageURL: String, onSuccess: @escaping(UIImage)->()) {
        let url = URL(string: imageURL)
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            onSuccess(image ?? UIImage())
        }.resume()
    }
}