//
//  NetworkManagerImpl.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManagerImpl {
}

// MARK: - NetworkManager
extension NetworkManagerImpl: NetworkManager {
  func get(
    url: String,
    parameters: [String : Any]?,
    headers: [String : String]?,
    completionHandler: @escaping RequestCompletion) {
    Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
      completionHandler(response.request, response.response, response.result.value, response.error)
    } 
  }
}
