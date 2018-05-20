//
//  LastSearchHistoryDataDisplayManagerImpl.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit
import CoreData

class LastSearchHistoryDataDisplayManagerImpl: NSObject {
  /// Reference to the Views's output interface.
  weak var output: LastSearchHistoryDataDisplayManagerOutput!
  var coreDataManager: CoreDataManager!
  
  // MARK: - Other
  var tableView: UITableView?
  private var fetchedResultsController: NSFetchedResultsController<RepositoryModelObject>!
  
  private func fetchedResultsControllerSetup() {
    let context = coreDataManager.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<RepositoryModelObject>(entityName: RepositoryModelObject.className)
    fetchRequest.sortDescriptors = [
      NSSortDescriptor(key: "stars", ascending: false)
    ]
    fetchRequest.fetchBatchSize = 20
    fetchedResultsController = NSFetchedResultsController<RepositoryModelObject>(
      fetchRequest: fetchRequest,
      managedObjectContext: context,
      sectionNameKeyPath: nil,
      cacheName: nil)
    fetchedResultsController.delegate = self
  }
  
  private func fetchedResultsControllerPerformFetch() {
    try? fetchedResultsController.performFetch()
  }
}

// MARK: - CardsDataDisplayManagerInput
extension LastSearchHistoryDataDisplayManagerImpl: LastSearchHistoryDataDisplayManager {
  func configure(with tableView: UITableView) {
    tableView.register(
      UINib(nibName: RepositoryTableViewCell.className, bundle: nil),
      forCellReuseIdentifier: RepositoryTableViewCell.className)
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = C.estimatedRowHeight
    tableView.dataSource = self
    tableView.delegate = self
    
    self.tableView = tableView
    
    fetchedResultsControllerSetup()
    fetchedResultsControllerPerformFetch()
  }
}

// MARK: - UITableViewDataSource
extension LastSearchHistoryDataDisplayManagerImpl: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsController.sections?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return fetchedResultsController.sections?[section].name
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.className) as! RepositoryTableViewCell
    
    let repository = fetchedResultsController.object(at: indexPath)
    
    cell.configure(
      with: repository.name?.cropTo(letters: C.nameMaxLetters) ?? "",
      subtitle: "\(repository.stars)",
      viewed: repository.viewed)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
  }
}

// MARK: - UITableViewDelegate
extension LastSearchHistoryDataDisplayManagerImpl: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let repository = fetchedResultsController.object(at: indexPath)
    repository.viewed = true
    
    if let name = repository.name, let url = repository.url {
      output.didSelectRepositiry(name: name, stringUrl: url)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let repository = fetchedResultsController.object(at: indexPath)
      coreDataManager.persistentContainer.viewContext.delete(repository)
    }
  }
}

// MARK: - NSFetchedResultsControllerDelegate
extension LastSearchHistoryDataDisplayManagerImpl: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView?.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
    case .insert:
      tableView?.insertSections(IndexSet(integer: sectionIndex), with: .fade)
    case .delete:
      tableView?.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
    case .move:
      break
    case .update:
      break
    }
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView?.insertRows(at: [newIndexPath!], with: .fade)
    case .delete:
      tableView?.deleteRows(at: [indexPath!], with: .fade)
    case .update:
      tableView?.reloadRows(at: [indexPath!], with: .fade)
    case .move:
      tableView?.moveRow(at: indexPath!, to: newIndexPath!)
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView?.endUpdates()
  }
}

// MARK: - Constants
private enum C {
  static let nameMaxLetters = 30
  static let estimatedRowHeight: CGFloat = 44.0
}
