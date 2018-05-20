//
//  RepositoryTableViewCell.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: BaseTableViewCell {
  // MARK: - Outlets
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var subtitleLabel: UILabel!
  @IBOutlet private weak var viewedLabel: UILabel!
  
  // MARK: - Public
  func configure(with title: String, subtitle: String, viewed: Bool) {
    titleLabel.text = title
    subtitleLabel.text = subtitle
    
    viewedLabel.text = viewed ? "✅" : nil
    viewedLabel.isHidden = !viewed
  }
}
