//
//  RepositoriesPresenter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

class RepositoriesPresenter {
  /// Reference to the View's interface.
  weak var view: RepositoriesViewInput?
  /// Reference to the Interactor's interface.
  var interactor: RepositoriesInteractorInput!
  /// Reference to the Router's interface.
  var router: RepositoriesRouterInput!
  
  private var lastSearchText: String = ""
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Actions
  @objc func didChangeAuthState() {
    view?.updateSignInButton(isAuthorize: interactor.isAuthorize)
  }
}

// MARK: - RepositoriesViewOutput
extension RepositoriesPresenter: RepositoriesViewOutput {
  func viewDidLoad() {
    view?.updateSignInButton(isAuthorize: interactor.isAuthorize)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didChangeAuthState),
      name: .DidChangeAuthorizationState,
      object: nil)
  }
  
  func searchBarTextDidChange(searchText: String) {
    if !searchText.isEmpty {
      lastSearchText = searchText
      interactor.searchRepositories(with: searchText, isNewSearch: true)
    }
  }
  
  func searchBarCancelButtonClicked() {
    interactor.cancelAllRequests()
  }
  
  func signInButtonDidTap() {
    interactor.isAuthorize ? interactor.signOut() : interactor.signIn()
  }
  
  func bookmarksButtonDidTap() {
    router.showLastSearchHistoryModule()
  }
  
  func didSelectRepository(_ repository: Repository) {
    router.presentRepositoryInfoModule(
      with: repository.name,
      stringUrl: repository.url.absoluteString)
  }
  
  func needLoadNewPieces() {
    interactor.searchRepositories(with: lastSearchText, isNewSearch: false)
  }
}

// MARK: - RepositoriesInteractorOutput
extension RepositoriesPresenter: RepositoriesInteractorOutput {
  func obtainRepositories(repositories: [Repository]) {
    view?.update(repositories: repositories)
  }
}
