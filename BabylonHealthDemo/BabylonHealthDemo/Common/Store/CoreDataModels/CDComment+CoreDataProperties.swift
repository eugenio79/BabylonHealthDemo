//
//  CDComment+CoreDataProperties.swift
//  
//
//  Created by Giuseppe Morana on 28/11/2016.
//
//

import Foundation
import CoreData


extension CDComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDComment> {
        return NSFetchRequest<CDComment>(entityName: "CDComment");
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var body: String?
    @NSManaged public var post: CDPost?

}
