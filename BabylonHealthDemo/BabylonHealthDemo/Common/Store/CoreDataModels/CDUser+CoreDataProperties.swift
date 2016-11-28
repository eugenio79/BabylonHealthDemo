//
//  CDUser+CoreDataProperties.swift
//  
//
//  Created by Giuseppe Morana on 28/11/2016.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser");
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var website: String?
    @NSManaged public var address: CDAddress?
    @NSManaged public var company: CDCompany?
    @NSManaged public var posts: CDPost?

}
