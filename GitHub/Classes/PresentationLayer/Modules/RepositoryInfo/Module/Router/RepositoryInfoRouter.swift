//
//  RepositoryInfoRouter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class RepositoryInfoRouter {
  /// This property contain protocol protected view controller for transition.
  weak var view: TransitionHandler?
}

// MARK: - RepositoryInfoRouterInput
extension RepositoryInfoRouter: RepositoryInfoRouterInput {
  func dismissModule() {
    view?.close(animated: true, completion: nil)
  }
}
