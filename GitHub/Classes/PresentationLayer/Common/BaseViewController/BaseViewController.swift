//
//  BaseViewController.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  lazy var backBarButtonItem: UIBarButtonItem = {
    return UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItemSetup()
  }
  
  // MARK: - Setup
  private func navigationItemSetup() {
    navigationItem.backBarButtonItem = backBarButtonItem
  }
}
