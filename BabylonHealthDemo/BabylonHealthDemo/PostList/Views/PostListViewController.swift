//
//  PostListViewController.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 21/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadingView: PostListLoadingView!
  
  // declared here, 'cause I can't declare a store property into PostListLayout extension
  var controller: PostListHandler?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    controller?.viewDidLoad()
  }
}

extension PostListViewController: PostListLayout {
  
  func showLoading(_ show: Bool) {
    show ? loadingView.show() : loadingView.hide()
  }
  
  func reload() {
    tableView.reloadData()
  }
}

// MARK: - PostListViewController
extension PostListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return controller?.postCount() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.reuseIdentifier, for: indexPath) as! PostListCell
    
    if let post = controller?.post(at: indexPath.row) {
      cell.update(with: post)
    }
    
    return cell
  }
}

