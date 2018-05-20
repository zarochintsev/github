//
//  RepositoriesFactory.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

struct RepositoriesFactory {
  private init() {}
  
  static func make() -> UIViewController {
    return makeRepositoriesViewController()
  }
}

private extension RepositoriesFactory {
  static func makeRepositoriesViewController() -> UIViewController {
    let viewController = StoryboardFactory
      .make(.repositories)
      .instantiateViewController(withIdentifier: RepositoriesViewController.className) as! RepositoriesViewController
    
    let router = RepositoriesRouter()
    router.view = viewController
    
    let interactor = RepositoriesInteractor()
    interactor.repositoriesService = ServicesFactory.makeRepositoriesService()
    
    let presenter = RepositoriesPresenter()
    presenter.router = router
    presenter.view = viewController
    presenter.interactor = interactor
    
    interactor.output = presenter
    viewController.output = presenter
    
    let dataDisplayManager = RepositoriesDataDisplayManagerImpl()
    dataDisplayManager.output = viewController
    
    viewController.dataDisplayManager = dataDisplayManager
    
    return viewController
  }
  
}
