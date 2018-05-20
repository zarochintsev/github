//
//  LastSearchHistoryViewController.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class LastSearchHistoryViewController: BaseViewController {
  /// Reference to the Presenter's output interface.
  var output: LastSearchHistoryViewOutput!
  var dataDisplayManager: LastSearchHistoryDataDisplayManager!
  
  // MARK: - Outlets
  @IBOutlet private weak var tableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItemSetup()
    dataDisplayManagerSetup()
    output.viewDidLoad()
  }
  
  // MARK: - Setup
  func navigationItemSetup() {
    title = LS.LastSearchHistory.title.localized()
  }
  
  func dataDisplayManagerSetup() {
    dataDisplayManager.configure(with: tableView)
  }
}

// MARK: - LastSearchHistoryViewInput
extension LastSearchHistoryViewController: LastSearchHistoryViewInput {
}

// MARK: - LastSearchHistoryDataDisplayManagerOutput
extension LastSearchHistoryViewController: LastSearchHistoryDataDisplayManagerOutput {
  func didSelectRepositiry(name: String, stringUrl: String) {
    output.didSelectRepositiry(name: name, stringUrl: stringUrl)
  }
}
