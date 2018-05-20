//
//  LastSearchHistoryInteractor.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

class LastSearchHistoryInteractor {
  /// Reference to the Presenter's output interface.
  weak var output: LastSearchHistoryInteractorOutput?
}

// MARK: - LastSearchHistoryInteractorInput
extension LastSearchHistoryInteractor: LastSearchHistoryInteractorInput {
}
