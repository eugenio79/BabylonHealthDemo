//
//  RestToCoreDataSyncEngineFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class RestToCoreDataSyncEngineFactory: SyncEngineFactory {
  
  func makeEngine(networking: Networking, localStores: LocalStores) -> SyncEngine {
    
    let userParser = SwiftyJSONUserParser()
    let userRemoteService = RestUserRemoteService(networking: networking, userParser: userParser)
    
    let postParser = SwiftyJSONPostParser()
    let postRemoteService = RestPostRemoteService(networking: networking, postParser: postParser)
    
    let commentParser = SwiftyJSONCommentParser()
    let commentRemoteService = RestCommentRemoteService(networking: networking, commentParser: commentParser)
    
    let userSync = RestToCDUserSync(remoteService: userRemoteService, localStore: localStores.user)!
    let postSync = RestToCDPostSync(remoteService: postRemoteService, postLocalStore: localStores.post, userLocalStore: localStores.user)!
    let commentSync = RestToCDCommentSync(remoteService: commentRemoteService, commentLocalStore: localStores.comment, postLocalStore: localStores.post)!
    
    return RestToCoreDataSync(userSync: userSync, postSync: postSync, commentSync: commentSync)
  }
}
