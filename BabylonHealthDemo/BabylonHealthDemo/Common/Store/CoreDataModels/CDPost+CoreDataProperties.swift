//
//  CDPost+CoreDataProperties.swift
//  
//
//  Created by Giuseppe Morana on 28/11/2016.
//
//

import Foundation
import CoreData


extension CDPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost");
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var user: CDUser?
    @NSManaged public var comments: CDComment?

}
