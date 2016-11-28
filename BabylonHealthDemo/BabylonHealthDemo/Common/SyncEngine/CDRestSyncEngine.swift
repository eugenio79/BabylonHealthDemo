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
    
    //var userListFetched: [User] = []
//    var postListFetched: [Post] = []
//    var commentListFetched: [Comment] = []
    
//    userRemoteService.fetch { /*[weak self]*/ result in
//      
////      guard let strongSelf = self else { return }
//      
//      switch result {
//      case .success(let userList):
//        // currently do nothing
//        //        userListFetched = userList
//        break
//      case .failure:
//        completion(.failure)
//        return
//      }
//    }
    
    fetchRemoteUsers().then { users in
      //userListFetched = users
      print("not implemented yet")
    }.catch { error in
      print("\(error)")
      completion(.failure)
    }
    
    completion(.success)
  }
}

// MARK: - private methods
fileprivate extension CDRestSyncEngine {
  
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
}
