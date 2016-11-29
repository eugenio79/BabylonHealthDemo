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

  /// In a production code I'd do this operation in background
  func insert(posts: [Post], completion: @escaping (PostLocalStoreInsertCompletion) -> Void) {
    
    for post in posts {
      self.insert(post: post, context: self.coreDataStack.managedContext)
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
  func addComments(comments: [Comment], to post: Post,
                   completion: @escaping (PostLocalStoreAddCommentsResult) -> Void) {
    
    let fetchedPost = self.fetchPost(post: post, context: self.coreDataStack.managedContext)
    
    guard let cdPost = fetchedPost else {
      // post not found
      completion(.failure)
      return
    }
    
    let commentsInserted = self.insertCommentList(comments: comments, context: self.coreDataStack.managedContext)
    cdPost.addToCdComments(commentsInserted)
    
    do {
      try self.coreDataStack.managedContext.save()
      completion(.success)
    } catch let error as NSError {
      print("Could not save \(error), \(error.userInfo)")
      completion(.failure)
    }
  }
  
  /// In a production code I'd do this operation in background
  func fetch(completion: @escaping (PostLocalStoreFetchCompletion) -> Void) {
    
    do {
      let request = NSFetchRequest<CDPost>(entityName: "CDPost")
      let posts = try self.coreDataStack.managedContext.fetch(request)
      completion(.success(posts: posts))
    } catch let error as NSError {
      print("Fetching error: \(error), \(error.userInfo)")
      completion(.failure)
    }
  }
  
  func count() -> Int {
    do {
      let request = NSFetchRequest<CDPost>(entityName: "CDPost")
      return try coreDataStack.managedContext.count(for: request)
    } catch let error as NSError {
      print("Count error: \(error), \(error.userInfo)")
      return 0  // for the purpose of this demo, I think it's enough
    }
  }
}

// MARK: - private methods
fileprivate extension CDPostLocalStore {
  
  func fetchPost(post: Post, context: NSManagedObjectContext) -> CDPost? {
    
    var fetchedPost: CDPost? = nil
    
    let fetch: NSFetchRequest<CDPost> = CDPost.fetchRequest()
    fetch.predicate = NSPredicate(format: "%K == %d", #keyPath(CDPost.id), post.id)
    
    do {
      let results = try context.fetch(fetch)
      if results.count > 0 {
        fetchedPost = results.first
      }
    } catch let error as NSError {
      print("Fetching error: \(error), \(error.userInfo)")
    }
    
    return fetchedPost
  }
  
  func insertCommentList(comments: [Comment], context: NSManagedObjectContext) -> NSSet {
    let commentSetToReturn = NSMutableSet()
    
    for comment in comments {
      let commentInserted = insertComment(comment: comment, context: context)
      commentSetToReturn.add(commentInserted)
    }
    
    return commentSetToReturn
  }
  
  func insertComment(comment: Comment, context: NSManagedObjectContext) -> CDComment {
    
    let cdComment = CDComment(context: context)
    
    cdComment.id = comment.id
    cdComment.name = comment.name
    cdComment.email = comment.email
    cdComment.body = comment.body
    
    return cdComment
  }
  
  func insert(post: Post, context: NSManagedObjectContext) {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDPost", in: context)!
    let cdPost = CDPost(entity: entity, insertInto: context)
    
    cdPost.id = post.id
    cdPost.title = post.title
    cdPost.body = post.body
  }
}
