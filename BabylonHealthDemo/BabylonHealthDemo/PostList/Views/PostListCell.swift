//
//  PostListCell.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import UIKit

class PostListCell: UITableViewCell {
  
  // MARK: - Outlets
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
  // MARK: - Properties
  static let reuseIdentifier = "PostListCell"
  
  func update(with post: Post) {
    titleLabel.text = post.title
    contentLabel.text = post.body
  }
}
