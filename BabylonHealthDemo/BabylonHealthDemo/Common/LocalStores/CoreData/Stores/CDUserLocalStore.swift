//
//  CDUserLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import CoreData

class CDUserLocalStore: UserLocalStore {
  
  var coreDataStack: CoreDataStack
  
  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
  }
  
  func insert(users: [User], completion: @escaping (UserLocalStoreInsertCompletion) -> Void) {
    
    coreDataStack.storeContainer.performBackgroundTask { [unowned self] managedContext in
      
      for user in users {
        self.insert(user: user, context: managedContext)
      }
      
      do {
        try managedContext.save()
        completion(.success)
      } catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")
        completion(.failure)
      }
    }
  }
  
}

// MARK: - private methods
fileprivate extension CDUserLocalStore {
  
  func insert(user: User, context: NSManagedObjectContext) {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDUser", in: context)!
    let cdUser = CDUser(entity: entity, insertInto: context)
    
    cdUser.id = 1
    cdUser.name = user.name
    cdUser.username = user.username
    cdUser.email = user.email
    cdUser.phone = user.phone
    cdUser.website = user.website
    cdUser.address = address(user: user, context: context)
    cdUser.company = company(user: user, context: context)
  }
  
  func address(user: User, context: NSManagedObjectContext) -> CDAddress {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDAddress", in: context)!
    let address = CDAddress(entity: entity, insertInto: context)
    
    address.street = user.address.street
    address.suite = user.address.suite
    address.city = user.address.city
    address.zipcode = user.address.zipcode
    address.geo = geo(user: user, context: context)
    
    return address
  }
  
  func company(user: User, context: NSManagedObjectContext) -> CDCompany {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDCompany", in: context)!
    let company = CDCompany(entity: entity, insertInto: context)
    
    company.name = user.company.name
    company.catchPhrase = user.company.catchPhrase
    company.bs = user.company.bs
    
    return company
  }
  
  func geo(user: User, context: NSManagedObjectContext) -> CDGeolocation {
    
    let entity = NSEntityDescription.entity(forEntityName: "CDGeolocation", in: context)!
    let geolocation = CDGeolocation(entity: entity, insertInto: context)
    
    geolocation.lat = user.address.geo.lat
    geolocation.lng = user.address.geo.lng
    
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
