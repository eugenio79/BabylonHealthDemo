//
//  PostListHandler.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// The Controller of the PostListLayout should conform to this protocol
protocol PostListHandler: class {
  
  var view: PostListLayout { get set }
  var router: Router { get set }
  
  init(view: PostListLayout, syncEngine: SyncEngine, postStore: PostLocalStore, postDetailViewModelFactory: PostDetailViewModelFactory, router: Router)
  
  /// Usually invoked by the view to let the controller know when the view is ready
  /// This should be called on UI thread
  func viewDidLoad()
  
  func postCount() -> Int
  
  func post(at index: Int) -> Post?
  
  func showDetail(of post: Post)
  
  /// When the view is about to display another view
  func willShow(navigable: Navigable)
}
