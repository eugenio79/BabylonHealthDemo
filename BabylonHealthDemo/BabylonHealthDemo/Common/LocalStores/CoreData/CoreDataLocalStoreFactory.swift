//
//  CoreDataLocalStoreFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class CoreDataLocalStoreFactory: LocalStoreFactory {
  
  func makeLocalStores() -> LocalStores {
    
    let coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .sqlite)
    
    let userLocalStore = CDUserLocalStore(coreDataStack: coreDataStack)
    let postLocalStore = CDPostLocalStore(coreDataStack: coreDataStack)
    let commentLocalStore = CDCommentLocalStore(coreDataStack: coreDataStack)
    
    return LocalStores(user: userLocalStore, post: postLocalStore, comment: commentLocalStore)
  }
}
