//
//  RepositoryInfo.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 04.07.2019.
//  Copyright © 2019 Alex Zarochintsev. All rights reserved.
//

import Foundation

protocol RepositoryInfo {
  func configure(config: RepositoryInfoModuleConfig)
}
