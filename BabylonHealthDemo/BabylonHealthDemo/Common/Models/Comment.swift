//
//  Comment.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// I need the @objc in order to not incure in a linker error (CoreData conformance)
@objc protocol Comment {
  var id: Int { get set }
  var name: String? { get set }
  var email: String? { get set }
  var body: String? { get set }
}
