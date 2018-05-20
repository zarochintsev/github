//
//  TransitionHandler.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

protocol TransitionHandler: class {
  func present(view: UIViewController, animated: Bool, completion: (() -> Void)?)
  func push(view: UIViewController, animated: Bool)
  func close(animated: Bool, completion: (() -> Void)?)
}

extension UIViewController: TransitionHandler {
  func present(view: UIViewController, animated: Bool, completion: (() -> Void)?) {
    present(view, animated: animated, completion: completion)
  }
  
  func push(view: UIViewController, animated: Bool) {
    navigationController?.pushViewController(view, animated: animated)
  }
  
  func close(animated: Bool, completion: (() -> Void)?) {
    dismiss(animated: true, completion: completion)
  }
  
}
