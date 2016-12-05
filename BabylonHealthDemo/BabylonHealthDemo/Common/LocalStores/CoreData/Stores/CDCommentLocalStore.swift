//
//  CDCommentLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import CoreData

extension CDComment: Comment {}

class CDCommentLocalStore: CommentLocalStore {
  
  var coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }

  func insert(comments: [Comment], completion: @escaping (CommentLocalStoreInsertCompletion) -> Void) {
    
    /// In a production code I'd do this operation in background but currently I use viewContext
    DispatchQueue.main.async {
      for comment in comments {
        self.insert(comment: comment, context: self.coreDataStack.managedContext)
      }
      self.coreDataStack.saveContext()
      completion(.success)
      
//      do {
//        try self.coreDataStack.managedContext.save()
//        completion(.success)
//      } catch let error as NSError {
//        print("Could not save \(error), \(error.userInfo)")
//        completion(.failure(error: .generic))
//      }
    }
  }
  
  func fetch(completion: @escaping (CommentLocalStoreFetchCompletion) -> Void) {
    
    /// In a production code I'd do this operation in background but currently I use viewContext
    DispatchQueue.main.async {
      do {
        let request = NSFetchRequest<CDComment>(entityName: "CDComment")
        let comments = try self.coreDataStack.managedContext.fetch(request)
        completion(.success(comments: comments))
      } catch let error as NSError {
        print("Fetching error: \(error), \(error.userInfo)")
        completion(.failure)
      }
    }
  }
  
  /// In a production code I'd do this operation in background
  func count() -> Int {
    do {
      let request = NSFetchRequest<CDComment>(entityName: "CDComment")
      return try coreDataStack.managedContext.count(for: request)
    } catch let error as NSError {
      print("Count error: \(error), \(error.userInfo)")
      return 0  // for the purpose of this demo, I think it's enough
    }
  }
}

// MARK: - private methods
fileprivate extension CDCommentLocalStore {
  
  func insert(comment: Comment, context: NSManagedObjectContext) {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDComment", in: context)!
    let cdComment = CDComment(entity: entity, insertInto: context)
    
    cdComment.id = comment.id
    cdComment.name = comment.name
    cdComment.email = comment.email
    cdComment.body = comment.body
  }
}
