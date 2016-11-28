//
//  CDGeolocation+CoreDataProperties.swift
//  
//
//  Created by Giuseppe Morana on 28/11/2016.
//
//

import Foundation
import CoreData


extension CDGeolocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeolocation> {
        return NSFetchRequest<CDGeolocation>(entityName: "CDGeolocation");
    }

    @NSManaged public var lat: String?
    @NSManaged public var lng: String?

}
