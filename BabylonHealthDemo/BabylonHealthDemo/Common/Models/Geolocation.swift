//
//  Geolocation.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// I need the @objc in order to not incure in a linker error (CoreData conformance)
@objc protocol Geolocation {
  var lat: String? { get set }
  var lng: String? { get set }
}
