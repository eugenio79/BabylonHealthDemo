//
//  Company.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// I need the @objc in order to not incure in a linker error (CoreData conformance)
@objc protocol Company {
  var name: String? { get set }
  var catchPhrase: String? { get set }
  var bs: String? { get set }
}
