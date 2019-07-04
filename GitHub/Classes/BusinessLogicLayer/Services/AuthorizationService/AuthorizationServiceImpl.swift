//
//  AuthorizationServiceImpl.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/20/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class AuthorizationServiceImpl {
  private init() {}
  
  static let `default` = AuthorizationServiceImpl()
  
  private var redirectUrl: URL?
}

// MARK: - AuthorizationService
extension AuthorizationServiceImpl: AuthorizationService {
  var isAuthorization: Bool {
    return redirectUrl == nil ? false : true
  }
  
  func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
    if url.absoluteString.range(of:"zarochintsev://?code=") != nil {
      redirectUrl = url
      NotificationCenter.default.post(name: NSNotification.Name.DidChangeAuthorizationState, object: nil)
      return true
    }
    
    return false
  }
  
  func signIn() {
    let stringUrl = "https://github.com/login/oauth/authorize?scope=nil&client_id=28dd9b368cd2bb853f54"
    
    if let url = URL(string: stringUrl) {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  func signOut() {
    redirectUrl = nil
    NotificationCenter.default.post(name: NSNotification.Name.DidChangeAuthorizationState, object: nil)
  }
}
