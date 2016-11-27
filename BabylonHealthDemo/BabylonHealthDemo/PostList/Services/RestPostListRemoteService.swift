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
  
  required init(networking: Networking) {
    self.networking = networking
  }
  
  func fetch(completion: @escaping (PostListRemoteFetchResult) -> Void) {
    
    let request = HttpGetRequest(url: URL(string: RestPostListRemoteService.urlString)!)
    networking.httpGet(request: request) { response in
      
      var fetchResult: PostListRemoteFetchResult?
      
      switch response {
      case .failure:
        fetchResult = PostListRemoteFetchResult.failure
        
        // TODO: implement success case
      default:
        break
      }
      
      if let fetchResult = fetchResult {
        completion(fetchResult)
      }
    }
  }
}
