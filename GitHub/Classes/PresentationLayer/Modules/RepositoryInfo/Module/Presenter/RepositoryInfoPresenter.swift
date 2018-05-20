//
//  RepositoryInfoPresenter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

class RepositoryInfoPresenter {
  /// Reference to the View's interface.
  weak var view: RepositoryInfoViewInput?
  /// Reference to the Interactor's interface.
  var interactor: RepositoryInfoInteractorInput!
  /// Reference to the Router's interface.
  var router: RepositoryInfoRouterInput!
  
  var name: String!
  var stringUrl: String!
}

// MARK: - RepositoryInfoModuleInput
extension RepositoryInfoPresenter: RepositoryInfoModuleInput {
}

// MARK: - RepositoryInfoViewOutput
extension RepositoryInfoPresenter: RepositoryInfoViewOutput {
  func viewDidLoad() {
    if let name = name, let stringUrl = stringUrl {
      view?.configure(with: name, stringUrl: stringUrl)
    }
  }
  
  func dismissButtonDidTap() {
    router.dismissModule()
  }
}

// MARK: - RepositoryInfoInteractorOutput
extension RepositoryInfoPresenter: RepositoryInfoInteractorOutput {
}
