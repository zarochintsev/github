//
//  LastSearchHistoryViewOutput.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

protocol LastSearchHistoryViewOutput: class {
  func viewDidLoad()
  func didSelectRepositiry(name: String, stringUrl: String)
}
