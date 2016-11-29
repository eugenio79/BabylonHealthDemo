//
//  RestToCDCommentSync.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Fetches from rest web service, saves to CoreData
class RestToCDCommentSync: CommentSyncing {
  
  /// Used to execute sequentially async tasks
  fileprivate let dispatchGroup = DispatchGroup()
  
  fileprivate var remoteService: CommentRemoteService!
  fileprivate var commentLocalStore: CommentLocalStore!
  fileprivate var postLocalStore: PostLocalStore!
  
  required init?(remoteService: CommentRemoteService,
                 commentLocalStore: CommentLocalStore,
                 postLocalStore: PostLocalStore) {
    
    guard let restRemoteService = remoteService as? RestCommentRemoteService else { return nil }
    guard let cdCommentLocalStore = commentLocalStore as? CDCommentLocalStore else { return nil }
    guard let cdPostLocalStore = postLocalStore as? CDPostLocalStore else { return nil }
    
    self.remoteService = restRemoteService
    self.commentLocalStore = cdCommentLocalStore
    self.postLocalStore = cdPostLocalStore
  }
  
  func sync(completion: @escaping (CommentSyncResult) -> Void) {
    
    guard let posts = fetchPosts() else {
      completion(.failure)
      return
    }
    guard let comments = fetchComments() else {
      completion(.failure)
      return
    }
    
    let postCommentLinker = RestPostCommentLinker(posts: posts, comments: comments)!
    
    let added = addComments(postCommentLinker: postCommentLinker)
    
    added ? completion(.success) : completion(.failure)
  }
  
  /// @return true if successful
  func addComments(postCommentLinker: PostCommentLinker) -> Bool {
    
    let postMap = postCommentLinker.postMap()
    let postCommentMap = postCommentLinker.postCommentMap()
    
    for (postId, comments) in postCommentMap {
      
      dispatchGroup.enter()
      guard let post = postMap[postId] else { return false }
      
      postLocalStore.addComments(comments: comments, to: post) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        // Note: in this example I won't take into consideration failure cases in this block
        // in a production environment I'd take care of them
        
        strongSelf.dispatchGroup.leave()
      }
    }
    return true
  }
}

// MARK: - Private methods
fileprivate extension RestToCDCommentSync {
  
  func fetchPosts() -> [Post]? {
    
    dispatchGroup.enter()
    var postsToReturn: [Post]?
    
    postLocalStore.fetch { [weak self] result in
      
      guard let strongSelf = self else {
        return
      }
      switch result {
      case .success(let fetchedPosts):
        postsToReturn = fetchedPosts
      case .failure:
        postsToReturn = nil
      }
      
      strongSelf.dispatchGroup.leave()
    }
    
    dispatchGroup.wait()
    
    return postsToReturn
  }
  
  func fetchComments() -> [Comment]? {
    
    dispatchGroup.enter()
    var commentsToReturn: [Comment]?
    
    remoteService.fetch { [weak self] result in
      
      guard let strongSelf = self else {
        return
      }
      switch result {
      case .success(let fetchedComments):
        commentsToReturn = fetchedComments
      case .failure:
        commentsToReturn = nil
      }
      strongSelf.dispatchGroup.leave()
    }
    
    dispatchGroup.wait()
    
    return commentsToReturn
  }
}
