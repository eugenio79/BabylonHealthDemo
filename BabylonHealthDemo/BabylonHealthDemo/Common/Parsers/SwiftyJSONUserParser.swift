//
//  SwiftyJSONUserParser.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import SwiftyJSON

class SwiftyJSONUserParser: UserParser {
  
  func parse(data: Data) -> [User] {
    let json = JSON(data: data)
    guard let usersArray = json.array else { return [] }
    
    // I'm currently assuming the JSON is always correct
    // in a production code, I'd validate each field
    return usersArray.map { user in
      
      let geo = RestGeolocation(lat: user["address"]["geo"]["lat"].string!,
                                lng: user["address"]["geo"]["lng"].string!)
      
      let address = RestAddress(street: user["address"]["street"].string!,
                                suite: user["address"]["suite"].string!,
                                city: user["address"]["city"].string!,
                                zipcode: user["address"]["zipcode"].string!,
                                geo: geo)
      
      let company = RestCompany(name: user["company"]["name"].string!,
                                catchPhrase: user["company"]["catchPhrase"].string!,
                                bs: user["company"]["bs"].string!)
      
      let user = RestUser(id: user["id"].int!,
                          name: user["name"].string!,
                          username: user["username"].string!,
                          email: user["email"].string!,
                          address: address,
                          phone: user["phone"].string!,
                          website: user["website"].string!,
                          company: company)
      return user
    }
  }
}
