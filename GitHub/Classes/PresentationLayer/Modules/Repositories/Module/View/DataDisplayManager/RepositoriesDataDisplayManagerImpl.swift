//
//  RepositoriesDataDisplayManagerImpl.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class RepositoriesDataDisplayManagerImpl: NSObject {
  /// Reference to the Views's output interface.
  weak var output: RepositoriesDataDisplayManagerOutput!

  // MARK: - Other
  var tableView: UITableView?
  
  private var isUpdating = false
  private var repositories = [Repository]()
}

// MARK: - CardsDataDisplayManagerInput
extension RepositoriesDataDisplayManagerImpl: RepositoriesDataDisplayManager {
  func configure(with tableView: UITableView) {
    tableView.register(
      UINib(nibName: RepositoryTableViewCell.className, bundle: nil),
      forCellReuseIdentifier: RepositoryTableViewCell.className)
    
    tableView.keyboardDismissMode = .onDrag
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    
    self.tableView = tableView
  }
  
  func update(repositories: [Repository]) {
    self.repositories.removeAll()
    self.repositories = repositories
    tableView?.reloadData()
    isUpdating = false
  }
  
  func append(repositories: [Repository]) {
    self.repositories.append(contentsOf: repositories)
    tableView?.reloadData()
  }
}

// MARK: - UITableViewDataSource
extension RepositoriesDataDisplayManagerImpl: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositories.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.className) as! RepositoryTableViewCell
    let repository = repositories[indexPath.row]
    
    cell.configure(
      with: repository.name.cropTo(letters: C.nameMaxLetters),
      subtitle: "\(repository.stars)",
      viewed: false)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension RepositoriesDataDisplayManagerImpl: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let repository = repositories[indexPath.row]
    output.didSelectRepository(repository)
  }
}

// MARK: - UIScrollViewDelegate
extension RepositoriesDataDisplayManagerImpl: UIScrollViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if isUpdating { return }
    if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height - 5 * C.rowHeight {
      output.needLoadNewPieces()
    }
  }
}

// MARK: - Constants
private enum C {
  static let rowHeight: CGFloat = UITableViewAutomaticDimension
  static let nameMaxLetters = 30
}
