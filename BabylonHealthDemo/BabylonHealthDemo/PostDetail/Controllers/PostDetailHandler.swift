//
//  PostDetailHandler.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

protocol PostDetailHandler {
  var view: PostDetailLayout { get set }
  
  init(view: PostDetailLayout, viewModel: PostDetailViewModel)
  
  /// Usually invoked by the view to let the controller know when the view is ready
  /// This should be called on UI thread
  func viewDidLoad()
}
