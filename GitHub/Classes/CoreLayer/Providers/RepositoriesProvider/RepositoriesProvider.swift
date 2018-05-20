//
//  RepositoriesProvider.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

protocol RepositoriesProvider: BaseProvider {
  @discardableResult func search(
    with searchText: String,
    page: Int,
    completionHandler: @escaping RepositoriesProvider.BaseCompletion) -> URLSessionDataTask
}
