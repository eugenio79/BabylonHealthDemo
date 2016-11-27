//
//  RestCommentRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Note: yeah, I know they're essentially copy-pasted from RestPostRemoteService
// TODO: refactoring
class RestCommentRemoteService: CommentRemoteService {
  
  // Warning: in order to work with http I had to change ATS settings
  static private let urlString = "http://jsonplaceholder.typicode.com/comments"
  
  var networking: Networking
  var commentParser: CommentParser
  
  required init(networking: Networking, commentParser: CommentParser) {
    self.networking = networking
    self.commentParser = commentParser
  }
  
  func fetch(completion: @escaping (CommentRemoteFetchResult) -> Void) {
    
    let request = HttpGetRequest(url: URL(string: RestCommentRemoteService.urlString)!)
    networking.httpGet(request: request) { [weak self] response in
      
      guard let strongSelf = self else { return }
      
      var fetchResult: CommentRemoteFetchResult?
      
      switch response {
      case .failure:
        fetchResult = CommentRemoteFetchResult.failure
      case .success(let data):
        let posts = strongSelf.commentParser.parse(data: data)
        fetchResult = CommentRemoteFetchResult.success(commentList: posts)
      }
      
      if let fetchResult = fetchResult {
        completion(fetchResult)
      }
    }
  }
}
