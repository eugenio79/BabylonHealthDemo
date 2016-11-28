//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Giuseppe Morana on 26/11/2016.
//

import Foundation
import CoreData

enum CoreDataStoreType {
  case sqlite
  case inMemory
}

class CoreDataStack {
  
  private let modelName: String
  
  init(modelName: String, storeType: CoreDataStoreType) {
    self.modelName = modelName
    
    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = storeDescriptionType(for: storeType)
  }
  
  private func storeDescriptionType(for storeType: CoreDataStoreType) -> String {
    switch storeType {
    case .sqlite:
      return NSSQLiteStoreType
    case .inMemory:
      return NSInMemoryStoreType
    }
  }
  
  lazy var storeContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: self.modelName)
    container.loadPersistentStores {
      (storeDescription, error) in
      if let error = error as NSError? {
        print("Error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  func saveContext() {
    guard managedContext.hasChanges else { return }
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Error saving context: \(error), \(error.userInfo)")
    }
  }
  
  
}
