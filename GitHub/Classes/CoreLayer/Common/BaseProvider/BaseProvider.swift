//
//  BaseProvider.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

protocol BaseProvider {
  typealias BaseCompletion = (Any?, Error?) -> Void
}
