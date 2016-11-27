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

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
}

extension PostListViewController: PostListLayout {
  
  func showLoading(_ show: Bool) {
    DispatchQueue.main.async { [weak self] in
      if show {
        self?.loadingView.show()
      } else {
        self?.loadingView.hide()
      }
    }
  }
}

// MARK: - PostListViewController
extension PostListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.reuseIdentifier, for: indexPath) as! PostListCell
    
    cell.titleLabel.text = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
    cell.contentLabel.text = "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    
    return cell
  }
}

