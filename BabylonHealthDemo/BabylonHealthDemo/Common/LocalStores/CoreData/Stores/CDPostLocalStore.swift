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
        completion(.failure(error: .generic))
      }
    }
  }
  
  func addComments(comments: [Comment], to post: Post,
                   completion: @escaping (PostLocalStoreAddCommentsResult) -> Void) {
    
    coreDataStack.storeContainer.performBackgroundTask { [unowned self] managedContext in
      
      let fetchedPost = self.fetchPost(post: post, context: managedContext)
      
      guard let cdPost = fetchedPost else {
        // post not found
        completion(.failure)
        return
      }
      
      let commentsInserted = self.insertCommentList(comments: comments, context: managedContext)
      cdPost.addToCdComments(commentsInserted)
      
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
