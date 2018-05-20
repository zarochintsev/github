//
//  AuthorizationService.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/20/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

protocol AuthorizationService {
  var isAuthorization: Bool { get }
  
  func signIn()
  func signOut()
  
  func application(_ application: UIApplication, handleOpen url: URL) -> Bool
}
