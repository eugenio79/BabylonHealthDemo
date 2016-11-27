//
//  PostListLoadingView.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import UIKit

class PostListLoadingView: UIView {
  
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  
  func show() {
    indicator.startAnimating()
    isHidden = false
  }
  
  func hide() {
    isHidden = true
    indicator.stopAnimating()
  }
}
