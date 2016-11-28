//
//  CDPost+CoreDataProperties.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
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
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension CDPost {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: CDComment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: CDComment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
