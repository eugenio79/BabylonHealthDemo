//
//  PostListLayout.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// The View that will present the list of the posts should conform to this protocol
/// I treat ViewControllers as View
protocol PostListLayout: class, Navigable {
  
  var controller: PostListHandler? { get set }
  
  var title: String? { get set }
  
  /// If param is true, it should display a loading view (false should hide it)
  func showLoading(_ show: Bool)
  
  /// Notify the user about an error
  func displayError(description: String)
  
  /// It'll refresh the UI
  func reload()
}

extension PostListLayout {
  static func identifier() -> String { return "PostListLayout" }
}
