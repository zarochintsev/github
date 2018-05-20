//
//  StoryboardFactory.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

enum StoryboardName: String {
  case repositories = "Repositories"
  case lastSearchHistory = "LastSearchHistory"
  case repositoryInfo = "RepositoryInfo"
}

struct StoryboardFactory {
  private init() {}
  
  static func make(_ name: StoryboardName) -> UIStoryboard {
    return UIStoryboard(name: name.rawValue, bundle: nil)
  }
}
