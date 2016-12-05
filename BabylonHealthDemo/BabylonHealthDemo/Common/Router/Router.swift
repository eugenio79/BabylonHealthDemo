//
//  Router.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import UIKit

/// Responsible for navigation between the views of the app
protocol Router {
  
  init(navigableConfigurator: NavigableConfigurator)
  
  /// The current visible page
  func visibleNavigable() -> Navigable
  
  func navigate(to navigableId: String)
  
  func prepareToNavigate(to navigable: Navigable, with params: Any?)
}
