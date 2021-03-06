//
//  RepositoriesInteractor.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

class RepositoriesInteractor {
  /// Reference to the Presenter's output interface.
  weak var output: RepositoriesInteractorOutput?
  
  var authorizationService: AuthorizationService!
  var repositoriesService: RepositoriesService!
}

// MARK: - RepositoriesInteractorInput
extension RepositoriesInteractor: RepositoriesInteractorInput {
  func searchRepositories(with name: String, isNewSearch: Bool) {
    repositoriesService.searchRepositories(with: name, isNewSearch: isNewSearch) { [weak self] repositories, error in
      self?.output?.obtainRepositories(repositories: repositories)
    }
  }
  
  func cancelAllRequests() {
    repositoriesService.cancelAllRequests()
  }
  
  var isAuthorize: Bool {
    return authorizationService.isAuthorization
  }
  
  func signIn() {
    authorizationService.signIn()
  }
  
  func signOut() {
    authorizationService.signOut()
    output?.obtainRepositories(repositories: [])
  }
}
