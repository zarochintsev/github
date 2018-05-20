//
//  RepositoriesDataDisplayManagerOutput.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

protocol RepositoriesDataDisplayManagerOutput: class {
  func didSelectRepository(_ repository: Repository)
  func needLoadNewPieces()
}
