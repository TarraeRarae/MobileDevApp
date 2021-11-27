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

    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = self.persistentContainer.viewContext
    private let fetchRequest: NSFetchRequest<TrackDataEntity> = TrackDataEntity.fetchRequest()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MobileDevApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveData(data: TrackData) {
        guard let entity = NSEntityDescription.entity(forEntityName: MainHelper.StringConstant.entityName.rawValue, in: context) else { return }
        guard let records = checkCountOfTracks(for: NSPredicate(format: "trackName = %@", data.name)) else { return }
        if records > 0 {
            return
        }
        let object = TrackDataEntity(entity: entity, insertInto: context)
        object.singerName = data.artists[0].name
        object.trackName = data.name
        object.previewURL = data.previewURL
        object.duration = data.duration
        if let destinationURL = data.destinationURL {
            object.destinationURL = destinationURL
        }
        object.imagesURLs = data.imagesURLs
        saveContext()
    }

    func clearCoreDataStack() {
        fetchRequest.predicate = nil
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileURL in fileURLs where fileURL.pathExtension == "mp3" {
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch {
            print("error of deleting tracks")
        }
        saveContext()
    }

    func fetchData() -> [TrackDataEntity]? {
        guard let records = checkCountOfTracks(for: NSPredicate(format: "trackName != nil")) else { return nil }
        if records == 0 {
            return nil
        }
        fetchRequest.predicate = nil
        var data: [TrackDataEntity] = []
        do {
            data = try context.fetch(fetchRequest)
        } catch {
            print("error")
        }
        return data
    }

    func isDataSaved(data: TrackData) -> Bool {
        guard let records = checkCountOfTracks(for: NSPredicate(format: "previewURL = %@", data.previewURL)) else { return false }
        if records > 0 {
            return true
        }
        return false
    }

    func deleteObjectFromSavedData(data: TrackData) {
        fetchRequest.predicate = NSPredicate(format: "previewURL = %@", data.previewURL)
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let trackName = String(data.previewURL.split(separator: "/")[3].split(separator: "?")[0])
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileURL in fileURLs {
                if fileURL.pathComponents.contains(trackName + ".mp3") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch {
            print("error of deleting tracks")
        }
        if let objects = try? context.fetch(fetchRequest) as [TrackDataEntity] {
            for object in objects {
                context.delete(object)
            }
        }
    }

    private func checkCountOfTracks(for predicate: NSPredicate) -> Int? {
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

    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
