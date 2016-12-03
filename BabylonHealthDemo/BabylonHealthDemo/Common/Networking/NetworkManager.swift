//
//  NetworkManager.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// A concrete implementation of networking capabilities
class NetworkManager: Networking {
  
  var session: URLSession!
  
  required init() {
    setupSession()
  }
  
  func httpGet(request: HttpGetRequest, completion: @escaping (HttpGetResponse) -> Void) {
    
    let dataTask = session.dataTask(with: request.url) { data, response, error in
      
      var responseToReturn: HttpGetResponse?
      
      if let error = error {
        print("\(error)")
        // -1009 ==> offline
        responseToReturn = .failure
        
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print("ok")
          if let data = data {
            responseToReturn = .success(data: data)
          } else {
            print("but no data")
            responseToReturn = .failure
          }
        } else {
          print("error \(httpResponse.statusCode)")
          responseToReturn = .failure
        }
      }
      
      completion(responseToReturn!)
    }
    dataTask.resume()
  }
}

// MARK: - Private methods
fileprivate extension NetworkManager {
  
  func setupSession() {
    session = URLSession(configuration: .default)
  }
}
