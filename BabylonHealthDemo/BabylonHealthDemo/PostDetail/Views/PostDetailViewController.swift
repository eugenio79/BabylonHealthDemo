//
//  PostDetailViewController.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import UIKit

// MARK - Lifecycle
class PostDetailViewController: UIViewController {
  
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var commentsNumberLabel: UILabel!
  @IBOutlet weak var loadingView: PostListLoadingView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
}

// MARK - PostDetailLayout
extension PostDetailViewController: PostDetailLayout {
  
}
