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
  
  private var config: RepositoryInfoModuleConfig!
}

// MARK: - RepositoryInfoModule
extension RepositoryInfoPresenter: RepositoryInfo {
  func configure(config: RepositoryInfoModuleConfig) {
    self.config = config
  }
}

// MARK: - RepositoryInfoViewOutput
extension RepositoryInfoPresenter: RepositoryInfoViewOutput {
  func viewDidLoad() {
    view?.configure(with: config.name, url: config.url)
  }
  
  func dismissButtonDidTap() {
    router.dismissModule()
  }
}

// MARK: - RepositoryInfoInteractorOutput
extension RepositoryInfoPresenter: RepositoryInfoInteractorOutput {
}
