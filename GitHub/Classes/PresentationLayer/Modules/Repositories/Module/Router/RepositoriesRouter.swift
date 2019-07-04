//
//  RepositoriesRouter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class RepositoriesRouter {
  weak var view: TransitionHandler?
}

// MARK: - RepositoriesRouterInput
extension RepositoriesRouter: RepositoriesRouterInput {
  func showLastSearchHistoryModule() {
    let viewController = LastSearchHistoryFactory.make()
    view?.push(view: viewController, animated: true)
  }
  
  func presentRepositoryInfoModule(config: RepositoryInfoModuleConfig) {
    let viewController = RepositoryInfoFactory.make {
      $0.configure(config: config)
    }
    viewController.modalPresentationStyle = .custom
    viewController.modalTransitionStyle = .crossDissolve
    view?.present(view: viewController, animated: true, completion: nil)
  }
}
