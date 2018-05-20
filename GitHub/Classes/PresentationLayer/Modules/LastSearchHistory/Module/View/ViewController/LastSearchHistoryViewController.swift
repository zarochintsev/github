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
  }
  
  // MARK: - Setup
  func navigationItemSetup() {
    title = LS.LastSearchHistory.title.localized()
    navigationItem.rightBarButtonItem = editButtonItem
  }
  
  func dataDisplayManagerSetup() {
    dataDisplayManager.configure(with: tableView)
  }
  
  // MARK: - Actions
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    if isEditing {
      tableView.setEditing(false, animated: animated)
    }
    
    tableView.setEditing(editing, animated: animated)
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
