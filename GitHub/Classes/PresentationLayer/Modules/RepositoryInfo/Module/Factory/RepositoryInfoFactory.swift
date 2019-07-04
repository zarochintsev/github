//
//  RepositoryInfoFactory.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

struct RepositoryInfoFactory {
  private init() {}
  
  static func make(_ configurator: ModuleConfigurator<RepositoryInfo>) -> UIViewController {
    return makeRepositoryInfoViewController(configurator)
  }
}

private extension RepositoryInfoFactory {
  static func makeRepositoryInfoViewController(_ configurator: ModuleConfigurator<RepositoryInfo>) -> UIViewController {
    let viewController = StoryboardFactory
      .make(.repositoryInfo)
      .instantiateViewController(withIdentifier: RepositoryInfoViewController.className) as! RepositoryInfoViewController
    
    let router = RepositoryInfoRouter()
    router.view = viewController
    
    let interactor = RepositoryInfoInteractor()
    
    let presenter = RepositoryInfoPresenter()
    presenter.router = router
    presenter.view = viewController
    presenter.interactor = interactor
    
    interactor.output = presenter
    viewController.output = presenter
    
    configurator(presenter)
    
    return viewController
  }
}
