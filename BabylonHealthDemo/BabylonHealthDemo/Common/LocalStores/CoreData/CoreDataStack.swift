//
//  CoreDataStack.swift
//  Dog Walk
//
//  Created by Giuseppe Morana on 26/11/2016.
//

import Foundation
import CoreData

class CoreDataStack {
  
  private let modelName: String
  
  init(modelName: String) {
    self.modelName = modelName
  }
  
  private lazy var storeContainer: NSPersistentContainer = {
    
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
