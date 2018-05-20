//
//  LastSearchHistoryRouter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class LastSearchHistoryRouter {
  weak var view: TransitionHandler?
}

// MARK: - LastSearchHistoryRouterInput
extension LastSearchHistoryRouter: LastSearchHistoryRouterInput {
  func presentRepositoryInfoModule(with name: String, stringUrl: String) {
    let viewController = RepositoryInfoFactory.make(name: name, stringUrl: stringUrl)
    viewController.modalPresentationStyle = .custom
    viewController.modalTransitionStyle = .crossDissolve
    view?.present(view: viewController, animated: true, completion: nil)
  }
}
