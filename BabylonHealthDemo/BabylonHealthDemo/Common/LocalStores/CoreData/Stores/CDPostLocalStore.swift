//
//  CDPostLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import CoreData

extension CDPost: Post {}

class CDPostLocalStore: PostLocalStore {
  
  var coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }

  func insert(posts: [Post], completion: @escaping (PostLocalStoreInsertCompletion) -> Void) {
    
    coreDataStack.storeContainer.performBackgroundTask { [unowned self] managedContext in
      
      for post in posts {
        self.insert(post: post, context: managedContext)
      }
      
      do {
        try managedContext.save()
        completion(.success)
      } catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")
        completion(.failure)
      }
    }
  }
  
  func fetch(completion: @escaping (PostLocalStoreFetchCompletion) -> Void) {
    
    coreDataStack.storeContainer.performBackgroundTask { managedContext in
      
      do {
        let request = NSFetchRequest<CDPost>(entityName: "CDPost")
        let posts = try managedContext.fetch(request)
        completion(.success(posts: posts))
      } catch let error as NSError {
        print("Fetching error: \(error), \(error.userInfo)")
        completion(.failure)
      }
    }
  }
}

// MARK: - private methods
fileprivate extension CDPostLocalStore {
  
  func insert(post: Post, context: NSManagedObjectContext) {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDPost", in: context)!
    let cdPost = CDPost(entity: entity, insertInto: context)
    
    cdPost.id = post.id
    cdPost.title = post.title
    cdPost.body = post.body
  }
}
