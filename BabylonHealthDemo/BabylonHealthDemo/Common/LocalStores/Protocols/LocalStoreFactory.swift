//
//  LocalStoreFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

protocol LocalStoreFactory {
  
  func makeLocalStores() -> LocalStores
}
