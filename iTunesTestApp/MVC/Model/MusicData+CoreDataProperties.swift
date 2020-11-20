//
//  MusicData+CoreDataProperties.swift
//  iTunesTestApp
//
//  Created by admin on 18.11.2020.
//
//

import Foundation
import CoreData


extension MusicData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicData> {
        return NSFetchRequest<MusicData>(entityName: "MusicData")
    }

    @NSManaged public var trackName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var albumImageURL: String?
    @NSManaged public var trackId: Int32
    @NSManaged public var albumImage: Data?

}

extension MusicData : Identifiable {

}
