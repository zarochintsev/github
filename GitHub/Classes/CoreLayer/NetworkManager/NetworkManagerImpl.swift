//
//  NetworkManagerImpl.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

class NetworkManagerImpl {
  private var session = URLSession(
    configuration: URLSessionConfiguration.default,
    delegate: nil,
    delegateQueue: nil)
}

// MARK: - NetworkManager
extension NetworkManagerImpl: NetworkManager {
  @discardableResult func get(
    url: String,
    parameters: [String : Any]?,
    headers: [String : String]?,
    completionHandler: @escaping RequestCompletion) -> URLSessionDataTask {
    
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    
    let encodedUrlRequest = try? encodeUrlRequest(urlRequest: request, withParameters: parameters)
    let task = session.dataTask(with: encodedUrlRequest!) { (data, response, error) in
      completionHandler(data, response, error)
    }
    
    task.resume()
    return task
  }
  
  private func encodeUrlRequest(
    urlRequest: URLRequest,
    withParameters parameters: [String: Any]?) throws -> URLRequest {
    var urlRequest = urlRequest
    
    guard let url = urlRequest.url else {
      throw NSError()
    }
    
    guard let params = parameters, !params.isEmpty else {
      return urlRequest
    }
    
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    urlComponents?.queryItems = params.map { URLQueryItem(name: "\($0.key)", value: "\($0.value)") }
    urlRequest.url = urlComponents?.url
    
    return urlRequest
  }
  
}

