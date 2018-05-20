//
//  RepositoriesService.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

protocol RepositoriesService {
  typealias SearchCompletion = ([Repository], Error?) -> Void
  
  func searchRepositories(with name: String, isNewSearch: Bool, completionHandler: @escaping RepositoriesService.SearchCompletion)
}
