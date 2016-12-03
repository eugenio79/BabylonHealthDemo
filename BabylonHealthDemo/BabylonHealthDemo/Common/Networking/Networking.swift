//
//  Networking.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

struct HttpGetRequest {
  var url: URL
}

//enum HttpGetErrorResponse {
//  case offline
//  case generic
//}

// In a production code, I'd handle different failures/errors
enum HttpGetResponse {
  case failure//(error: HttpGetErrorResponse)
  case success(data: Data)
}

/// Every class that should implement networking capabilities
/// should conform to this protocol
protocol Networking: class {
  
  /// Here's where the setup of the network should come up
  init()
  
  func httpGet(request: HttpGetRequest, completion: @escaping (HttpGetResponse) -> Void)
}
