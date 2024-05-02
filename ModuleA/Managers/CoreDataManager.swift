//
//  CoreDataManager.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation
import CoreData
import UtilitiesModule

class CoreDataManager {
    typealias SaveCompletionBlock = (Bool) -> Void

    lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = Bundle.moduleA.url(
            forResource: "UniversityModel", withExtension: "momd"),
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError(CoreDataMessages.coreDataModelSetupError)
        }
        let container = NSPersistentContainer(
            name: CoreDataMessages.resourceName,
            managedObjectModel: managedObjectModel
        )
        if let storeURL = container.persistentStoreDescriptions.first?.url {
            let description = NSPersistentStoreDescription(url: storeURL)
            description.shouldInferMappingModelAutomatically = true
            description.shouldMigrateStoreAutomatically = true
            description.setOption(FileProtectionType.none as NSObject, forKey: NSPersistentStoreFileProtectionKey)
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores {_, error in
            if let err = error {
                fatalError("❌ Loading of store failed: \(err.localizedDescription)")
            }
        }

        return container
    }()

    lazy var backgroundContext: NSManagedObjectContext = {
        let context: NSManagedObjectContext!
        context = self.persistentContainer.newBackgroundContext()
        context?.automaticallyMergesChangesFromParent = true
        context?.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return context
    }()

    required init() {}

    func perform(onContext context: NSManagedObjectContext, handler: (() -> Void), completion: SaveCompletionBlock) {
        context.performAndWait {
            do {
                handler()
                try context.save()
                context.reset()
                completion(true)
            } catch let error {
                print("\(error.localizedDescription)")
                context.rollback()
                completion(false)
            }
        }
    }

    func insert(universities: [University]) {
        deleteAllData()
        self.perform(onContext: self.backgroundContext) {
            for university in universities {
                let universityModel = UniversityModel(context: self.backgroundContext)
                universityModel.payload = try? NSKeyedArchiver.archivedData(withRootObject: university, requiringSecureCoding: false)
            }
            
            // Save changes in the background context
            do {
                try self.backgroundContext.save()
            } catch {
                print("Error saving background context: \(error.localizedDescription)")
            }
        } completion: { isSaved in
            if isSaved {
                print("Data have been saved successfully")
            } else {
                print("Data saving has failed")
            }
        }
    }

    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UniversityModel")

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try backgroundContext.execute(batchDeleteRequest)
            try backgroundContext.save()
        } catch {
            print("Error deleting data: \(error.localizedDescription)")
        }
    }

    func fetchAllData() -> [University]? {
        var fetchedData: [University] = []
        let fetchRequest: NSFetchRequest<UniversityModel> = UniversityModel.fetchRequest()

        do {
            let universities = try backgroundContext.fetch(fetchRequest)
            for universityModel in universities {
                if let universityData = universityModel.payload,
                   let university = try? JSONDecoder().decode([University].self, from: universityData) {
                    fetchedData = university
                }
            }
        } catch {
            print("Error fetching data: \(error.localizedDescription)")
            return nil
        }

        return fetchedData
    }
}
