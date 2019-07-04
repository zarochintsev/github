//
//  ProvidersFactory.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/20/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

struct ProvidersFactory {
  private init() {}
  
  static func makeRepositoriesProvider() -> RepositoriesProvider {
    let networkManager = NetworkManagerImpl()
    let repositoriesProvider = RepositoriesProviderImpl(networkManager: networkManager)
    return repositoriesProvider
  }
}
