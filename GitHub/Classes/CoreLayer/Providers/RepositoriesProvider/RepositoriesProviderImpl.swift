//
//  RepositoriesProviderImpl.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

class RepositoriesProviderImpl {
  private let networkManager: NetworkManager
  init(networkManager: NetworkManager) {
    self.networkManager = networkManager
  }
}

// MARK: - RepositoriesProvider
extension RepositoriesProviderImpl: RepositoriesProvider {
  @discardableResult func search(
    with searchText: String,
    page: Int,
    completionHandler: @escaping RepositoriesProvider.BaseCompletion) -> URLSessionDataTask {
    let url = "https://api.github.com/search/repositories"
    let parameters: [String : Any] = [
      C.Keys.SearchRequest.words : searchText,
      C.Keys.SearchRequest.page : page,
      C.Keys.SearchRequest.sort : C.starsSort,
      C.Keys.SearchRequest.perPage : C.perPage]
    
    return networkManager.get(url: url, parameters: parameters, headers: nil) { data, response, error in
      completionHandler(data, error)
    }
  }
}

private enum C {
  static let perPage = 15
  static let starsSort = "stars"
  
  enum Keys {
    enum SearchRequest {
      static let words = "q"
      static let sort = "sort"
      static let page = "page"
      static let perPage = "per_page"
    }
  }
}
