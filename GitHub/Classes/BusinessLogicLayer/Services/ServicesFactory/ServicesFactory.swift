//
//  ServicesFactory.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/20/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

struct ServicesFactory {
  private init() {}
  
  static func makeAuthorizationService() -> AuthorizationService {
    return AuthorizationServiceImpl.default
  }
  
  static func makeRepositoriesService() -> RepositoriesService {
    let repositoriesProvider = ProvidersFactory.makeRepositoriesProvider()
    let coreDataManager = CoreDataManagerImpl.default
    
    let repositoriesService = RepositoriesServiceImpl(
      provider: repositoriesProvider,
      coreDataManager: coreDataManager)
    
    return repositoriesService
  }
  
}
