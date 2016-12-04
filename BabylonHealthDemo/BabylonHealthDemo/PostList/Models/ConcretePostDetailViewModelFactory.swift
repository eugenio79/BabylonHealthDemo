//
//  ConcretePostDetailViewModelFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Concrete implementation
class ConcretePostDetailViewModelFactory: PostDetailViewModelFactory {
  
  fileprivate let postStore: PostLocalStore
  
  required init(postStore: PostLocalStore) {
    self.postStore = postStore
  }
  
  func makeViewModel(for post: Post) -> PostDetailViewModel? {
    var author = ""
    if let user = postStore.fetchAuthor(of: post) {
      author = user.name ?? ""
    }
    let description = post.body ?? ""
    let commentsCount = postStore.commentCount(for: post)
    
    return PostDetailViewModel(author: author, description: description, commentsCount: commentsCount)
  }
}
