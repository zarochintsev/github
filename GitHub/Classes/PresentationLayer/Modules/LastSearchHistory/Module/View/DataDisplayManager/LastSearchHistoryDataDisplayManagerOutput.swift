//
//  LastSearchHistoryDataDisplayManagerOutput.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

protocol LastSearchHistoryDataDisplayManagerOutput: class {
  func didSelectRepositiry(name: String, stringUrl: String)
}
