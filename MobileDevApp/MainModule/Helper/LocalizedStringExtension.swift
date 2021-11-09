//
//  LocalizedStringExtension.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 10.11.2021.
//

import Foundation

extension String {

  var localized: String {
    return NSLocalizedString(self, comment: "\(self)_comment")
  }
}
