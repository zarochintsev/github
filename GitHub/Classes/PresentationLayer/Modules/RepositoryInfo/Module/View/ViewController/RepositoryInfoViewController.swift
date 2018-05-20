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
  @IBOutlet private weak var wrapperView: UIView!
  
  // MARK: - Private
  private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
  private var initialOrigin = CGPoint.zero
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    UIView.animate(withDuration: C.showDuration) {
      self.view.backgroundColor = C.backgroundColor
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    initialOrigin = wrapperView.frame.origin
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
  
  @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
    let touchPoint = sender.location(in: self.view?.window)
    
    switch sender.state {
    case .began:
      initialTouchPoint = touchPoint
    case .changed:
      let distance = touchPoint.y - initialTouchPoint.y
      if distance > 0 {
        wrapperView.frame.origin.y = initialOrigin.y + distance
      }
    case .ended, .cancelled:
      if touchPoint.y - initialTouchPoint.y > 100 {
        output.dismissButtonDidTap()
      } else {
        UIView.animate(withDuration: 0.3, animations: {
          self.wrapperView.frame.origin = self.initialOrigin
        })
      }
    default:
      break
    }
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
