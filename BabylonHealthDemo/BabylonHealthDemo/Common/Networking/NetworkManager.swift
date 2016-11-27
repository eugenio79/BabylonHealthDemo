//
//  NetworkManager.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import ReachabilitySwift

/// A concrete implementation of networking capabilities
/// It uses native iOS APIs and Reachability.swift
class NetworkManager: Networking {
  
  var reachability: Reachability!
  var session: URLSession!
  
  required init() {
    setupReachability()
    setupSession()
  }
  
  func isOnline() -> Bool {
    return reachability.isReachable
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
  
  func setupReachability() {
    
    reachability = Reachability()!
    
    reachability.whenReachable = { reachability in
      // For this project I only want to know if reachable or not
      // I don't need to know if via WiFi or Cellular
      print("Reachable")
    }
    
    reachability.whenUnreachable = { reachability in
      print("Not reachable")
    }
    
    do {
      try reachability.startNotifier()
    } catch {
      print("Unable to start notifier")
    }
  }
  
  func setupSession() {
    session = URLSession(configuration: .default)
  }
}
