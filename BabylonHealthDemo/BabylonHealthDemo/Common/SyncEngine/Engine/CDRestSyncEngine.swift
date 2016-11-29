//
//  CDRestSyncEngine.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import PromiseKit

/// Uses restful web services for remote sources
/// and CoreData for local storage
class CDRestSyncEngine: SyncEngine {
  
  fileprivate let userRemoteService:        UserRemoteService
  fileprivate let postRemoteService:        PostRemoteService
  fileprivate let commentRemoteService:     CommentRemoteService
  fileprivate let userLocalStore:           UserLocalStore
  fileprivate let postLocalStore:           PostLocalStore
  fileprivate let commentLocalStore:        CommentLocalStore
  
  required init(userRemoteService: UserRemoteService,
                postRemoteService: PostRemoteService,
                commentRemoteService: CommentRemoteService,
                userLocalStore: UserLocalStore,
                postLocalStore: PostLocalStore,
                commentLocalStore: CommentLocalStore) {
    
    self.userRemoteService = userRemoteService
    self.postRemoteService = postRemoteService
    self.commentRemoteService = commentRemoteService
    self.userLocalStore = userLocalStore
    self.postLocalStore = postLocalStore
    self.commentLocalStore = commentLocalStore
  }
  
  func sync(completion: @escaping (SyncEngineResult) -> Void) {
    
    var userListFetched: [User] = []
    var postListFetched: [Post] = []
    var commentListFetched: [Comment] = []
    
    fetchRemoteUsers().then { users in
      userListFetched = users
    }.then {
      return self.fetchRemotePosts()
    }.then { posts in
      postListFetched = posts
    }.then {
      return self.fetchRemoteComments()
    }.then { comments in
      commentListFetched = comments
    }.then {
      return self.storeUsers(users: userListFetched)
    }.then { _ in
      return self.storePosts(posts: postListFetched)
    }.then { _ in
      return self.storeComments(comments: commentListFetched)
    }.then { _ in
      completion(.success)
    }.catch { error in
      print("\(error)")
      completion(.failure)
      return
    }
  }
  
}

// MARK: - private methods
fileprivate extension CDRestSyncEngine {
  
  func storeComments(comments: [Comment]) -> Promise<Any?> {
    return Promise { fulfill, reject in
      
      commentLocalStore.insert(comments: comments) { result in
        switch result {
        case .success:
          fulfill(nil)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
  
  func storePosts(posts: [Post]) -> Promise<Any?> {
    return Promise { fulfill, reject in
      
      postLocalStore.insert(posts: posts) { result in
        switch result {
        case .success:
          fulfill(nil)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
  
  func storeUsers(users: [User]) -> Promise<Any?> {
    return Promise { fulfill, reject in
      
      userLocalStore.insert(users: users) { result in
        switch result {
        case .success:
          fulfill(nil)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
  
  func fetchRemoteUsers() -> Promise<[User]> {
    return Promise { fulfill, reject in
      
      userRemoteService.fetch { result in
        switch result {
        case .success(let userList):
          fulfill(userList)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
  
  func fetchRemotePosts() -> Promise<[Post]> {
    return Promise { fulfill, reject in
      
      postRemoteService.fetch { result in
        switch result {
        case .success(let postList):
          fulfill(postList)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
  
  func fetchRemoteComments() -> Promise<[Comment]> {
    return Promise { fulfill, reject in
      
      commentRemoteService.fetch { result in
        switch result {
        case .success(let commentList):
          fulfill(commentList)
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
  
}
