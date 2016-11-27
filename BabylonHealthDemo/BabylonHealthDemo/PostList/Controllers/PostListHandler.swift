//
//  PostListHandler.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// The Controller of the PostListLayout should conform to this protocol
protocol PostListHandler {
  
  var view: PostListLayout { get set }
  var networking: Networking { get set }
  
  init(view: PostListLayout, networking: Networking)
  
  /// Usually invoked by the view to let the controller know when the view is ready
  func viewDidLoad()
}
