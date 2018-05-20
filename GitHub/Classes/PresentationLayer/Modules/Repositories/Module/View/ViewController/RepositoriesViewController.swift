//
//  RepositoriesViewController.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class RepositoriesViewController: BaseViewController {
  /// Reference to the Presenter's output interface.
  var output: RepositoriesViewOutput!
  var dataDisplayManager: RepositoriesDataDisplayManager!
  
  private let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - Outlets
  @IBOutlet private weak var tableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItemSetup()
    dataDisplayManagerSetup()
    searchControllerSetup()
    
    output.viewDidLoad()
  }
  
  // MARK: - Setup
  func navigationItemSetup() {
    title = LS.Repositories.title.localized()
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .bookmarks,
      target: self,
      action: #selector(bookmarksButtonDidTap))
  }
  
  func dataDisplayManagerSetup() {
    dataDisplayManager.configure(with: tableView)
  }
  
  func searchControllerSetup() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = LS.Repositories.SearchController.placeholder.localized()
    searchController.searchBar.delegate = self
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
  
  // MARK: - Actions
  @objc func bookmarksButtonDidTap() {
    output.bookmarksButtonDidTap()
  }
  
}

// MARK: - RepositoriesViewInput
extension RepositoriesViewController: RepositoriesViewInput {
  func update(repositories: [Repository]) {
    dataDisplayManager.update(repositories: repositories)
  }
}

// MARK: - RepositoriesDataDisplayManagerOutput
extension RepositoriesViewController: RepositoriesDataDisplayManagerOutput {
  func didSelectRepository(_ repository: Repository) {
    output.didSelectRepository(repository)
  }
  
  func needLoadNewPieces() {
    output.needLoadNewPieces()
  }
}

// MARK: - UISearchResultsUpdating
extension RepositoriesViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    output.searchBarTextDidChange(searchText: searchController.searchBar.text ?? "")
  }
}

// MARK: - UISearchBarDelegate
extension RepositoriesViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    output.searchBarCancelButtonClicked()
  }
}
