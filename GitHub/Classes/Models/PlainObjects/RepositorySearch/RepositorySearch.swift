//
//  RepositorySearch.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/20/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

struct RepositorySearch {
  let repositories: [Repository]
}

// MARK: - Decodable
extension RepositorySearch: Decodable {
  enum Keys: String, CodingKey {
    case items
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    let repositories = try container.decode([Repository].self, forKey: .items)
    self.init(repositories: repositories)
  }
}
