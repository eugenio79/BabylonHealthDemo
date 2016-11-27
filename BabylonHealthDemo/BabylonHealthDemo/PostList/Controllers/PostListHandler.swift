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
  var remoteService: PostRemoteService { get set }
  
  init(view: PostListLayout, remoteService: PostRemoteService)
  
  /// Usually invoked by the view to let the controller know when the view is ready
  /// This should be called on UI thread
  func viewDidLoad()
  
  func postCount() -> Int
  
  func post(at index: Int) -> Post?
}
