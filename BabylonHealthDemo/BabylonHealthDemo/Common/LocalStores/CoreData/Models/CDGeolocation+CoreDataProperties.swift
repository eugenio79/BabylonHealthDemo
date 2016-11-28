//
//  CDGeolocation+CoreDataProperties.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import CoreData


extension CDGeolocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeolocation> {
        return NSFetchRequest<CDGeolocation>(entityName: "CDGeolocation");
    }

    @NSManaged public var lat: String?
    @NSManaged public var lng: String?
    @NSManaged public var address: CDAddress?

}
