//
//  RepositoryInfoViewController.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 19/05/2018.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit
import WebKit

class RepositoryInfoViewController: UIViewController {
  /// Reference to the Presenter's output interface.
  var output: RepositoryInfoViewOutput!
  
  // MARK: - Outlets
  @IBOutlet private weak var navigationBar: UINavigationBar!
  @IBOutlet private weak var webView: WKWebView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: C.showDuration) {
      self.view.backgroundColor = C.backgroundColor
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    UIView.animate(withDuration: C.dismissDuration) {
      self.view.backgroundColor = .clear
    }
  }
  
  // MARK: - Actions
  @IBAction func dismissButtonDidTap(_ sender: UIBarButtonItem) {
    output.dismissButtonDidTap()
  }
}

// MARK: - RepositoryInfoViewInput
extension RepositoryInfoViewController: RepositoryInfoViewInput {
  func configure(with name: String, stringUrl: String) {
    navigationBar.topItem?.title = name
    
    if let url = URL(string: stringUrl) {
      let urlRequest = URLRequest(url: url)
      webView.load(urlRequest)
    }
    
  }
}

// MARK: Constants
private enum C {
  static let showDuration: TimeInterval = 0.5
  static let dismissDuration: TimeInterval = 0.5
  static let backgroundColor = UIColor(white: 26 / 255.0, alpha: 0.4)
}
