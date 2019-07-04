//
//  LastSearchHistoryPresenter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

class LastSearchHistoryPresenter {
  /// Reference to the View's interface.
  weak var view: LastSearchHistoryViewInput?
  /// Reference to the Interactor's interface.
  var interactor: LastSearchHistoryInteractorInput!
  /// Reference to the Router's interface.
  var router: LastSearchHistoryRouterInput!
}

// MARK: - LastSearchHistoryViewOutput
extension LastSearchHistoryPresenter: LastSearchHistoryViewOutput {  
  func didSelectRepositiry(name: String, stringUrl: String) {
    if let url = URL(string: stringUrl) {
      router.presentRepositoryInfoModule(config: .init(name: name, url: url))
    }
  }
}

// MARK: - LastSearchHistoryInteractorOutput
extension LastSearchHistoryPresenter: LastSearchHistoryInteractorOutput {
}
