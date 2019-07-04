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
  private var tasks = NSMapTable<NSString, URLSessionDataTask>(keyOptions: .strongMemory, valueOptions: .weakMemory)
}

// MARK: - RepositoriesService
extension RepositoriesServiceImpl: RepositoriesService {
  func searchRepositories(
    with name: String,
    isNewSearch: Bool,
    completionHandler: @escaping RepositoriesService.SearchCompletion) {
    if isNewSearch {
      page = 1
      searchedRepositories.removeAll()
    }
    
    DispatchQueue.global().async(group: dispatchGroup) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.dispatchGroup.enter()
      let task = strongSelf.provider.search(with: name, page: strongSelf.page) { data, error in
        if let data = data, let repositorySearch = try? JSONDecoder().decode(RepositorySearch.self, from: data) {
          strongSelf.searchedRepositories.append(contentsOf: repositorySearch.repositories)
        }
        
        strongSelf.dispatchGroup.leave()
      }
      
      DispatchQueue.main.async {
        let key = (task.currentRequest?.url?.absoluteString ?? "") as NSString
        strongSelf.tasks.setObject(task, forKey: key)
      }
    }
    
    DispatchQueue.global().async(group: dispatchGroup) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.dispatchGroup.enter()
      let task =  strongSelf.provider.search(with: name, page: strongSelf.page + 1) { data, error in
        if let data = data, let repositorySearch = try? JSONDecoder().decode(RepositorySearch.self, from: data) {
          strongSelf.searchedRepositories.append(contentsOf: repositorySearch.repositories)
        }
        
        strongSelf.dispatchGroup.leave()
      }
      
      DispatchQueue.main.async {
        let key = (task.currentRequest?.url?.absoluteString ?? "") as NSString
        strongSelf.tasks.setObject(task, forKey: key)
      }
    }
    
    dispatchGroup.notify(queue: .main) { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.page += 2
      strongSelf.save(repositories: strongSelf.searchedRepositories)
      completionHandler(strongSelf.searchedRepositories.sorted(by: { $0.stars > $1.stars }), nil)
    }
  }
  
  func cancelAllRequests() {
    tasks.objectEnumerator()?.forEach {
      ($0 as? URLSessionDataTask)?.cancel()
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
