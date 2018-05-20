//
//  RepositoriesDataDisplayManager.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

protocol RepositoriesDataDisplayManager: class {
  func configure(with tableView: UITableView)
  
  func update(repositories: [Repository])
  func append(repositories: [Repository])
}
