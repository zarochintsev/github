//
//  RepositoryInfoInteractor.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

class RepositoryInfoInteractor {
  /// Reference to the Presenter's output interface.
  weak var output: RepositoryInfoInteractorOutput?
}

// MARK: - RepositoryInfoInteractorInput
extension RepositoryInfoInteractor: RepositoryInfoInteractorInput {
}
