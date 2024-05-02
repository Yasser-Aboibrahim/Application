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
            self.perform(onContext: self.backgroundContext) {
                for university in universities {
                    let universityModel = UniversityModel(context: self.backgroundContext)
                    do {
                        let jsonData = try JSONEncoder().encode(university)
                        universityModel.payload = jsonData
                    } catch {
                        print("Error encoding university: \(error.localizedDescription)")
                    }
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

    func deleteAllUniversities() {
        let fetchRequest: NSFetchRequest<UniversityModel> = UniversityModel.fetchRequest()
        
        do {
            let universities = try backgroundContext.fetch(fetchRequest)
            for university in universities {
                backgroundContext.delete(university)
            }
            try backgroundContext.save()
        } catch {
            print("Error deleting all universities: \(error.localizedDescription)")
        }
    }
    
    func getAllUniversities() -> [University] {
            let fetchRequest: NSFetchRequest<UniversityModel> = UniversityModel.fetchRequest()
            do {
                let universityModels = try backgroundContext.fetch(fetchRequest)
                return universityModels.compactMap { universityModel in
                    guard let data = universityModel.payload as Data? else { return nil }
                    do {
                        return try JSONDecoder().decode(University.self, from: data)
                    } catch {
                        print("Error decoding university data: \(error.localizedDescription)")
                        return nil
                    }
                }
            } catch {
                print("Error fetching universities: \(error.localizedDescription)")
                return []
            }
        }
}

