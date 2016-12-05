//
//  PostListViewController.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 21/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import UIKit

// MARK: - PostListViewController
class PostListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadingView: PostListLoadingView!
  
  // declared here, 'cause I can't declare a store property into PostListLayout extension
  var controller: PostListHandler?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    controller?.viewDidLoad()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    guard segue.identifier == "showDetail" else {
      // unable to handle this segue
      return
    }
    guard let navigable = segue.destination as? Navigable else {
      return
    }
    controller?.willShow(navigable: navigable)
  }
}

// MARK: - PostListLayout
extension PostListViewController: PostListLayout {
  
  func showLoading(_ show: Bool) {
    show ? loadingView.show() : loadingView.hide()
  }
  
  func reload() {
    tableView.reloadData()
  }
  
  func identifier() -> String {
    return "PostList"
  }
}

// MARK: - UITableViewDataSource
extension PostListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return controller?.postCount() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.reuseIdentifier, for: indexPath) as! PostListCell
    cell.selectionStyle = .none
    
    if let post = controller?.post(at: indexPath.row) {
      cell.update(with: post)
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension PostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = controller?.post(at: indexPath.row) else { return }
        controller?.showDetail(of: post)
    }
}
