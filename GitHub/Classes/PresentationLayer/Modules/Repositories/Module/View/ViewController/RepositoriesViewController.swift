//
//  RepositoriesViewController.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
  /// Reference to the Presenter's output interface.
  var output: RepositoriesViewOutput!
  var dataDisplayManager: RepositoriesDataDisplayManager!
  
  private let searchController = UISearchController(searchResultsController: nil)
  private var signInButton: UIBarButtonItem!
  private var timer: Timer?
  
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
    signInButton = UIBarButtonItem(
      title: nil,
      style: .plain,
      target: self,
      action: #selector(didTapSignInButton))
    navigationItem.leftBarButtonItem = signInButton
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .bookmarks,
      target: self,
      action: #selector(didTapBookmarksButton))
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
  @objc func didTapBookmarksButton() {
    output.didTapBookmarksButton()
  }
  
  @objc func didTapSignInButton() {
    output.didTapSignInButton()
  }
  
  // MARK: Actions
  @objc func timerFire() {
    output.didChangeSearchBarText(searchText: searchController.searchBar.text ?? "")
  }
}

// MARK: - RepositoriesViewInput
extension RepositoriesViewController: RepositoriesViewInput {
  func update(repositories: [Repository]) {
    dataDisplayManager.update(repositories: repositories)
  }
  
  func updateSignInButton(isAuthorize: Bool) {
    signInButton.title = isAuthorize
      ? LS.Repositories.Button.signOut.localized()
      : LS.Repositories.Button.signIn.localized()
    searchController.searchBar.isUserInteractionEnabled = isAuthorize
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
    timer?.invalidate()
    timer = nil
    timer = Timer.scheduledTimer(
      timeInterval: C.timerDelay,
      target: self,
      selector: #selector(timerFire),
      userInfo: nil,
      repeats: false)
  }
}

// MARK: - UISearchBarDelegate
extension RepositoriesViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    output.didTapCancelButtonOnSearchBar()
  }
}

// MARK: - Constants
private enum C {
  static let timerDelay = 0.8
}
