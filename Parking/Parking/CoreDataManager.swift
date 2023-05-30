//
//  CoreDataManager.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext

    func getParkingPlaces() -> [ParkingPlace] {
        var models: [ParkingPlace] = [ParkingPlace]()
        let request = ParkingPlace.fetchRequest()
        guard let context = context else {
            return models
        }
        do {
            let fetchResult = try context.fetch(request)
            models = fetchResult
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return models
    }

    func saveContext() {
        if let context = context, context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
