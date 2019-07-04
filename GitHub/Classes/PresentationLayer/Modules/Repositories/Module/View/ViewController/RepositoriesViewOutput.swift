//
//  RepositoriesViewOutput.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

protocol RepositoriesViewOutput: class {
  func viewDidLoad()
  
  func didChangeSearchBarText(searchText: String)
  func didTapCancelButtonOnSearchBar()
  
  func didTapSignInButton()
  func didTapBookmarksButton()
  
  func didSelectRepository(_ repository: Repository)
  func needLoadNewPieces()
}
