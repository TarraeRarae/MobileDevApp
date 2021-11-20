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
        let object = TrackDataEntity(entity: entity, insertInto: context)
        object.singerName = data.artists[0].name
        object.trackName = data.name
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
        fetchRequest.predicate = NSPredicate(format: "%@")
        var records = 0
        do {
            records = try context.count(for: fetchRequest)
            if records == 0 {
                return nil
            }
        } catch {
            print("error")
        }
        var data: [TrackDataEntity] = []
        do {
            data = try context.fetch(fetchRequest)
        } catch {
            print("error")
        }
        return data
    }
}
