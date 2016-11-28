//
//  CDPost+CoreDataProperties.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import CoreData


extension CDPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost");
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var cdComments: NSSet?
    @NSManaged public var user: CDUser?

}

// MARK: Generated accessors for cdComments
extension CDPost {

    @objc(addCdCommentsObject:)
    @NSManaged public func addToCdComments(_ value: CDComment)

    @objc(removeCdCommentsObject:)
    @NSManaged public func removeFromCdComments(_ value: CDComment)

    @objc(addCdComments:)
    @NSManaged public func addToCdComments(_ values: NSSet)

    @objc(removeCdComments:)
    @NSManaged public func removeFromCdComments(_ values: NSSet)

}
