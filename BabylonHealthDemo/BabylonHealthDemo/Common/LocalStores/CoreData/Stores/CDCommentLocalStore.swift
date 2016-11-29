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

  /// In a production code I'd do this operation in background
  func insert(comments: [Comment], completion: @escaping (CommentLocalStoreInsertCompletion) -> Void) {
    
    for comment in comments {
      self.insert(comment: comment, context: self.coreDataStack.managedContext)
    }
    
    do {
      try self.coreDataStack.managedContext.save()
      completion(.success)
    } catch let error as NSError {
      print("Could not save \(error), \(error.userInfo)")
      completion(.failure(error: .generic))
    }
  }
  
  /// In a production code I'd do this operation in background
  func fetch(completion: @escaping (CommentLocalStoreFetchCompletion) -> Void) {
    
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
