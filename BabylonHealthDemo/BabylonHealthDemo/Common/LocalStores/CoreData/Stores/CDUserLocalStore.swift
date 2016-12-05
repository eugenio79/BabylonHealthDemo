//
//  CDUserLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import CoreData

extension CDGeolocation: Geolocation {}

extension CDAddress: Address {
  var geo: Geolocation? {
    get {
      return cdGeo
    }
    set(newGeo) {
      cdGeo = newGeo as? CDGeolocation
    }
  }
}

extension CDCompany: Company {}

extension CDUser: User {
  var address: Address? {
    get {
      return cdAddress
    }
    set(newAddress) {
      cdAddress = newAddress as? CDAddress
    }
  }
  var company: Company? {
    get {
      return cdCompany
    }
    set(newCompany) {
      cdCompany = newCompany as? CDCompany
    }
  }
}

class CDUserLocalStore: UserLocalStore {
  
  var coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func insert(users: [User], completion: @escaping (UserLocalStoreInsertCompletion) -> Void) {
    
    /// In a production code I'd do this operation in background
    DispatchQueue.main.async {
      for user in users {
        self.insert(user: user, context: self.coreDataStack.managedContext)
      }
      
      self.coreDataStack.saveContext()
      completion(.success)
//      do {
//        try
//        completion(.success)
//      } catch let error as NSError {
//        print("Could not save \(error), \(error.userInfo)")
//        completion(.failure(error: .generic))
//      }
    }
  }
  
  func addPosts(posts: [Post], to user: User, completion: @escaping (UserLocalStoreAddPostsResult) -> Void) {
    
    /// In a production code I'd do this operation in background but currently I use viewContext
    DispatchQueue.main.async {
      let fetchedUser = self.fetchUser(user: user, context: self.coreDataStack.managedContext)
      
      guard let cdUser = fetchedUser else {
        // user not found
        completion(.failure)
        return
      }
      
      let postInserted = self.insertPostList(posts: posts, context: self.coreDataStack.managedContext)
      cdUser.addToPosts(postInserted)
      
      self.coreDataStack.saveContext()
      completion(.success)
//      do {
//        try self.coreDataStack.managedContext.save()
//        completion(.success)
//      } catch let error as NSError {
//        print("Could not save \(error), \(error.userInfo)")
//        completion(.failure)
//      }
    }
  }
  
  func fetch(completion: @escaping (UserLocalStoreFetchCompletion) -> Void) {
    
    /// In a production code I'd do this operation in background but currently I use viewContext
    DispatchQueue.main.async {
      do {
        let request = NSFetchRequest<CDUser>(entityName: "CDUser")
        let users = try self.coreDataStack.managedContext.fetch(request)
        completion(.success(users: users))
      } catch let error as NSError {
        print("Fetching error: \(error), \(error.userInfo)")
        completion(.failure)
      }
    }
  }
  
  /// In a production code I'd do this operation in background
  func count() -> Int {
    do {
      let request = NSFetchRequest<CDUser>(entityName: "CDUser")
      return try coreDataStack.managedContext.count(for: request)
    } catch let error as NSError {
      print("Count error: \(error), \(error.userInfo)")
      return 0  // for the purpose of this demo, I think it's enough
    }
  }
  
}

// MARK: - private methods
fileprivate extension CDUserLocalStore {
  
  func fetchUser(user: User, context: NSManagedObjectContext) -> CDUser? {
    
    var fetchedUser: CDUser? = nil
    
    let fetch: NSFetchRequest<CDUser> = CDUser.fetchRequest()
    fetch.predicate = NSPredicate(format: "%K == %d", #keyPath(CDUser.id), user.id)
    
    do {
      let results = try context.fetch(fetch)
      if results.count > 0 {
        fetchedUser = results.first
      }
    } catch let error as NSError {
      print("Fetching error: \(error), \(error.userInfo)")
    }
    
    return fetchedUser
  }
  
  func insertPostList(posts: [Post], context: NSManagedObjectContext) -> NSSet {
    let postSetToReturn = NSMutableSet()
    
    for post in posts {
      let postInserted = insertPost(post: post, context: context)
      postSetToReturn.add(postInserted)
    }
    
    return postSetToReturn
  }
  
  func insertPost(post: Post, context: NSManagedObjectContext) -> CDPost {
    
    let cdPost = CDPost(context: context)
    
    cdPost.id = post.id
    cdPost.title = post.title
    cdPost.body = post.body
    
    return cdPost
  }
  
  func insert(user: User, context: NSManagedObjectContext) {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDUser", in: context)!
    let cdUser = CDUser(entity: entity, insertInto: context)
    
    cdUser.id = user.id
    cdUser.name = user.name
    cdUser.username = user.username
    cdUser.email = user.email
    cdUser.phone = user.phone
    cdUser.website = user.website
    cdUser.cdAddress = address(user: user, context: context)
    cdUser.cdCompany = company(user: user, context: context)
  }
  
  func address(user: User, context: NSManagedObjectContext) -> CDAddress {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDAddress", in: context)!
    let address = CDAddress(entity: entity, insertInto: context)
    
    address.street = user.address?.street
    address.suite = user.address?.suite
    address.city = user.address?.city
    address.zipcode = user.address?.zipcode
    address.cdGeo = geo(user: user, context: context)
    
    return address
  }
  
  func company(user: User, context: NSManagedObjectContext) -> CDCompany {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDCompany", in: context)!
    let company = CDCompany(entity: entity, insertInto: context)
    
    company.name = user.company?.name
    company.catchPhrase = user.company?.catchPhrase
    company.bs = user.company?.bs
    
    return company
  }
  
  func geo(user: User, context: NSManagedObjectContext) -> CDGeolocation {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDGeolocation", in: context)!
    let geolocation = CDGeolocation(entity: entity, insertInto: context)
    
    geolocation.lat = user.address?.geo?.lat
    geolocation.lng = user.address?.geo?.lng
    
    return geolocation
  }
}

//{
//  "id": 1,
//  "name": "Leanne Graham",
//  "username": "Bret",
//  "email": "Sincere@april.biz",
//  "address": {
//    "street": "Kulas Light",
//    "suite": "Apt. 556",
//    "city": "Gwenborough",
//    "zipcode": "92998-3874",
//    "geo": {
//      "lat": "-37.3159",
//      "lng": "81.1496"
//    }
//  },
//  "phone": "1-770-736-8031 x56442",
//  "website": "hildegard.org",
//  "company": {
//    "name": "Romaguera-Crona",
//    "catchPhrase": "Multi-layered client-server neural-net",
//    "bs": "harness real-time e-markets"
//  }
//}
