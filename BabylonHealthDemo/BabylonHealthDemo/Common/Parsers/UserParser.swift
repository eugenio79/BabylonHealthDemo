//
//  UserParser.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

protocol UserParser {
  
  /// If data has an invalid format, it'll return an empty array
  func parse(data: Data) -> [User]
}
