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
  
  static func make(name: String, stringUrl: String) -> UIViewController {
    return makeRepositoryInfoViewController(name: name, stringUrl: stringUrl)
  }
}

private extension RepositoryInfoFactory {
  static func makeRepositoryInfoViewController(name: String, stringUrl: String) -> UIViewController {
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
    
    presenter.name = name
    presenter.stringUrl = stringUrl
    
    interactor.output = presenter
    viewController.output = presenter
    
    return viewController
  }
  
}

