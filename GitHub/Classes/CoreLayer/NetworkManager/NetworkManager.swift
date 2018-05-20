//
//  NetworkManager.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

protocol NetworkManager {
  typealias RequestCompletion = (Data?, URLResponse?, Error?) -> Void
  
  @discardableResult func get(
    url: String,
    parameters: [String : Any]?,
    headers: [String : String]?,
    completionHandler: @escaping RequestCompletion) -> URLSessionDataTask
}
