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
  
  var controller: PostDetailHandler?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    controller?.viewDidLoad()
  }
}

// MARK - PostDetailLayout
extension PostDetailViewController: PostDetailLayout {
  
  func refresh(viewModel: PostDetailViewModel) {
    authorLabel.text = viewModel.author
    descriptionLabel.text = viewModel.description
    commentsNumberLabel.text = "\(viewModel.commentsCount)" // TODO: the format should be chosen by viewModel!
  }
  
  func identifier() -> String {
    return "PostDetail"
  }
}
