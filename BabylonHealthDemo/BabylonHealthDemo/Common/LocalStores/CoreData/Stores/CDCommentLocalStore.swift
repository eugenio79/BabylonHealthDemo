//
//  CDCommentLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class CDCommentLocalStore: CommentLocalStore {
  
  var coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
}
