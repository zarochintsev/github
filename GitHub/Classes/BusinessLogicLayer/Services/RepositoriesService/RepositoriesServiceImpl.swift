//
//  RepositoriesServiceImpl.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation
import CoreData

class RepositoriesServiceImpl {
  let provider: RepositoriesProvider
  let coreDataManager: CoreDataManager
  
  init(provider: RepositoriesProvider, coreDataManager: CoreDataManager) {
    self.provider = provider
    self.coreDataManager = coreDataManager
  }
  
  // MARK: - Private
  private let dispatchGroup = DispatchGroup()
  
  private var page = 1
  private var searchedRepositories = [Repository]()
}

// MARK: - RepositoriesService
extension RepositoriesServiceImpl: RepositoriesService {
  func searchRepositories(with name: String, isNewSearch: Bool, completionHandler: @escaping RepositoriesService.SearchCompletion) {
    if isNewSearch {
      page = 1
      searchedRepositories.removeAll()
    }
    
    DispatchQueue.global().async(group: dispatchGroup) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.dispatchGroup.enter()
      strongSelf.provider.search(with: name, page: strongSelf.page) { (responseObject, error) in
        guard let responseObject = responseObject as? [String : AnyObject],
          let items = responseObject["items"] as? NSArray else { return }
        
        do {
          let data = try JSONSerialization.data(withJSONObject: items, options: JSONSerialization.WritingOptions.prettyPrinted)
          let repositories = try JSONDecoder().decode([Repository].self, from: data)
          strongSelf.searchedRepositories.append(contentsOf: repositories)
        }
        catch {
        }
        
        strongSelf.dispatchGroup.leave()
      }
    }
    
    DispatchQueue.global().async(group: dispatchGroup) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.dispatchGroup.enter()
      
      strongSelf.provider.search(with: name, page: strongSelf.page + 1) { (responseObject, error) in
        guard let responseObject = responseObject as? [String : AnyObject],
          let items = responseObject["items"] as? NSArray else { return }
        
        do {
          let data = try JSONSerialization.data(withJSONObject: items, options: JSONSerialization.WritingOptions.prettyPrinted)
          let repositories = try JSONDecoder().decode([Repository].self, from: data)
          strongSelf.searchedRepositories.append(contentsOf: repositories)
        }
        catch {
        }
        
        strongSelf.dispatchGroup.leave()
      }
    }
    
    dispatchGroup.notify(queue: .main) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.page += 2
      strongSelf.save(repositories: strongSelf.searchedRepositories)
      completionHandler(strongSelf.searchedRepositories.sorted(by: { $0.stars > $1.stars }), nil)
    }
  }
}

private extension RepositoriesServiceImpl {
  func save(repositories: [Repository]) {
    let backgroundContext = coreDataManager.persistentContainer.newBackgroundContext()
    
    repositories.forEach {
      let model = NSEntityDescription.insertNewObject(
        forEntityName: RepositoryModelObject.className,
        into: backgroundContext) as? RepositoryModelObject
      model?.identifier = "\($0.id)"
      model?.name = $0.name
      model?.stars = Int64($0.stars)
      model?.url = $0.url.absoluteString
    }
    
    try? backgroundContext.save()
  }
}
