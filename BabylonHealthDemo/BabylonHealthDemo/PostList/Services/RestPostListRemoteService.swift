//
//  RestPostListRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Implement restful services
class RestPostListRemoteService: PostListRemoteService {
  
  // Warning: in order to work with http I had to change ATS settings
  static private let urlString = "http://jsonplaceholder.typicode.com/posts"
  
  var networking: Networking
  var postParser: PostParser
  
  required init(networking: Networking, postParser: PostParser) {
    self.networking = networking
    self.postParser = postParser
  }
  
  func fetch(completion: @escaping (PostListRemoteFetchResult) -> Void) {
    
    let request = HttpGetRequest(url: URL(string: RestPostListRemoteService.urlString)!)
    networking.httpGet(request: request) { [weak self] response in
      
      guard let strongSelf = self else { return }
      
      var fetchResult: PostListRemoteFetchResult?
      
      switch response {
      case .failure:
        fetchResult = PostListRemoteFetchResult.failure
      case .success(let data):
        let posts = strongSelf.postParser.parse(data: data)
        fetchResult = PostListRemoteFetchResult.success(postList: posts)
      }
      
      if let fetchResult = fetchResult {
        completion(fetchResult)
      }
    }
  }
}
