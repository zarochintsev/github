//
//  RepositoriesViewInput.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

protocol RepositoriesViewInput: class {
  func update(repositories: [Repository])
  func updateSignInButton(isAuthorize: Bool)
}
