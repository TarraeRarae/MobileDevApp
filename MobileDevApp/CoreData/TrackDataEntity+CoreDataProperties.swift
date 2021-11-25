//
//  TrackDataEntity+CoreDataProperties.swift
//  
//
//  Created by TarraeRarae on 25.11.2021.
//
//

import Foundation
import CoreData

extension TrackDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackDataEntity> {
        return NSFetchRequest<TrackDataEntity>(entityName: "TrackDataEntity")
    }

    @NSManaged public var destinationURL: URL?
    @NSManaged public var previewURL: String?
    @NSManaged public var singerName: String?
    @NSManaged public var trackName: String?
    @NSManaged public var imagesURLs: [String]?

}
