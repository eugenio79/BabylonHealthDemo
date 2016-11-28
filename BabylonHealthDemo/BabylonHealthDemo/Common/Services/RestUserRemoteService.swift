//
//  RestUserRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Note: yeah, I know they're essentially copy-pasted from RestPostRemoteService
// TODO: refactoring
class RestUserRemoteService: UserRemoteService {
  
  // Warning: in order to work with http I had to change ATS settings
  static private let urlString = "http://jsonplaceholder.typicode.com/users"
  
  var networking: Networking
  var userParser: UserParser
  
  required init(networking: Networking, userParser: UserParser) {
    self.networking = networking
    self.userParser = userParser
  }
  
  func fetch(completion: @escaping (UserRemoteFetchResult) -> Void) {
    
    let request = HttpGetRequest(url: URL(string: RestUserRemoteService.urlString)!)
    networking.httpGet(request: request) { [weak self] response in
      
      guard let strongSelf = self else { return }
      
      var fetchResult: UserRemoteFetchResult?
      
      switch response {
      case .failure:
        fetchResult = UserRemoteFetchResult.failure(error: .generic)
      case .success(let data):
        let posts = strongSelf.userParser.parse(data: data)
        fetchResult = UserRemoteFetchResult.success(userList: posts)
      }
      
      if let fetchResult = fetchResult {
        completion(fetchResult)
      }
    }
  }
}
