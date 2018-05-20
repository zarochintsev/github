//
//  CleanLaunchRouter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

struct CleanLaunchRouter {
  private init() {}
  
  static func make() -> UIViewController {
    let repositoriesViewController = RepositoriesFactory.make()
    let navigationController = UINavigationController(rootViewController: repositoriesViewController)
    navigationController.navigationBar.prefersLargeTitles = true
    return navigationController
  }
}
