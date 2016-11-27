//
//  PostListController.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class PostListController: PostListHandler {
  
  unowned var view: PostListLayout
  var remoteService: PostListRemoteService
  var posts: [Post] = []
  
  required init(view: PostListLayout, remoteService: PostListRemoteService) {
    self.view = view
    self.remoteService = remoteService
  }
  
  func viewDidLoad() {
    
    self.view.showLoading(true)
    
    remoteService.fetch { [weak self] result in
      
      guard let strongSelf = self else { return }
      
      switch result {
      case .failure:
        // TODO: I'd check if I've offline data
        break
      case .success(let postList):
        
        strongSelf.posts = postList
        
        DispatchQueue.main.async {
          strongSelf.view.reload()
        }
      }
      
      // no matter if success or failure, hide the loading
      DispatchQueue.main.async {
        strongSelf.view.showLoading(false)
      }
    }
  }
  
  func postCount() -> Int {
    return posts.count
  }
  
  func post(at index: Int) -> Post? {
    guard posts.indices.contains(index) else { return nil }
    return posts[index]
  }
  
}
