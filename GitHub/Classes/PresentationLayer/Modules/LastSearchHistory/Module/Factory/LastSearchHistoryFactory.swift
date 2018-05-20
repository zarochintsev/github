//
//  LastSearchHistoryFactory.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

struct LastSearchHistoryFactory {
  private init() {}
  
  static func make() -> UIViewController {
    return makeLastSearchHistoryViewController()
  }
}

private extension LastSearchHistoryFactory {
  static func makeLastSearchHistoryViewController() -> UIViewController {
    let viewController = StoryboardFactory
      .make(.lastSearchHistory)
      .instantiateViewController(withIdentifier: LastSearchHistoryViewController.className) as! LastSearchHistoryViewController
    
    let router = LastSearchHistoryRouter()
    router.view = viewController
    
    let interactor = LastSearchHistoryInteractor()
    
    let presenter = LastSearchHistoryPresenter()
    presenter.router = router
    presenter.view = viewController
    presenter.interactor = interactor
    
    interactor.output = presenter
    viewController.output = presenter
    
    let dataDisplayManager = LastSearchHistoryDataDisplayManagerImpl()
    dataDisplayManager.output = viewController
    dataDisplayManager.coreDataManager = CoreDataManagerImpl.default
    
    viewController.dataDisplayManager = dataDisplayManager
    
    return viewController
  }
  
}
