//
//  String+Formatter.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/20/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import Foundation

extension String {
  
  func cropTo(letters: Int) -> String {
    if count < letters {
      return self
    } else {
      let endIndex = index(startIndex, offsetBy: letters)
      return String(self[startIndex..<endIndex])
    }
  }
  
}
