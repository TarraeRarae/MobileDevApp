//
//  CoreDataService.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 20.11.2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataService {

    static let shared = CoreDataService()

    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    private let fetchRequest: NSFetchRequest<TrackDataEntity> = TrackDataEntity.fetchRequest()

    func saveData(data: TrackData) {
        guard let context = context, let entity = NSEntityDescription.entity(forEntityName: "TrackDataEntity", in: context) else { return }
        guard let records = checkCountOfTracks(for: NSPredicate(format: "trackName = %@", data.name)) else { return }
        if records > 0 {
            return
        }
        let object = TrackDataEntity(entity: entity, insertInto: context)
        object.singerName = data.artists[0].name
        object.trackName = data.name
        if let imagesForCoreData = coreDataObjectFromImages(imagesData: data.images) {
            object.images = imagesForCoreData
        }
        appDelegate?.saveContext()
    }

    func clearCoreDataStack() {
        guard let appDelegate = appDelegate, let context = context else { return }
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        appDelegate.saveContext()
    }

    func fetchData() -> [TrackDataEntity]? {
        guard let context = context else { return nil }
        guard let records = checkCountOfTracks(for: NSPredicate(format: "trackName != nil")) else { return nil }
        if records == 0 {
            return nil
        }
        var data: [TrackDataEntity] = []
        do {
            data = try context.fetch(fetchRequest)
        } catch {
            print("error")
        }
        return data
    }

    private func checkCountOfTracks(for predicate: NSPredicate) -> Int? {
        guard let context = context else { return nil }
        fetchRequest.predicate = predicate
        var records = 0
        do {
            records = try context.count(for: fetchRequest)
            return records
        } catch {
            print("error")
            return nil
        }
    }

    private func coreDataObjectFromImages(imagesData: [Data]) -> Data? {
        let dataArray = NSMutableArray()
        var images: [UIImage] = []
        for item in imagesData {
            if let image = UIImage(data: item) {
                images.append(image)
            }
        }
        for item in images {
            if let data = item.pngData() {
                dataArray.add(data)
            }
        }
        return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
    }
}
