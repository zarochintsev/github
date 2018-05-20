//
//  Repository.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

struct Repository {
  let id: Int
  let name: String
  let url: URL
  let stars: Int
}

// MARK: - Decodable
extension Repository: Decodable {
  enum Keys: String, CodingKey {
    case id = "id"
    case name = "full_name"
    case url = "html_url"
    case stars = "stargazers_count"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    
    let id = try container.decode(Int.self, forKey: .id)
    let name = try container.decode(String.self, forKey: .name)
    let url = try container.decode(URL.self, forKey: .url)
    let stars = try container.decode(Int.self, forKey: .stars)
    
    self.init(id: id, name: name, url: url, stars: stars)
  }
}
