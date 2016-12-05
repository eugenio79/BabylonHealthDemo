//
//  NavigableConfigurator.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// TODO: move this definition outside?
/// Every screen/page/view handled by Router should conform to this protocol
protocol Navigable {
  
  /// Each screen should have a unique identifier
  func identifier() -> String
}

/// Responsible for creation and configuration of navigable pages/screens/views etc.
protocol NavigableConfigurator {
  
  /// The root navigable page
  func rootNavigable() -> Navigable
  
  func configure(postDetailNavigable: Navigable, viewModel: PostDetailViewModel, router: Router)
}
