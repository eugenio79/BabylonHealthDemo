//
//  CDUser+CoreDataProperties.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser");
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var cdAddress: CDAddress?
    @NSManaged public var cdCompany: CDCompany?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension CDUser {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: CDPost)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: CDPost)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}
