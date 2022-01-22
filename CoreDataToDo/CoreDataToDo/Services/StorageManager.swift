//
//  StorageManager.swift
//  CoreDataToDo
//
//  Created by Pavlentiy on 06.10.2021.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataToDo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Work with DB data
    func fetchTasks() -> [Task] {
        let request = Task.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch let error {
            print("Failed to fetch data", error)
            return []
        }
    }
    
    func saveTask(with taskName: String) -> Task? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return nil }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return nil }
        
        task.title = taskName
        saveContext()
        
        return task
    }
    
    func deleteTask(_ task: Task) {
        context.delete(task)
        saveContext()
    }
    
    private init() {}
}
