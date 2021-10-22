//
//  UITableViewDataSource.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 22.10.2021.
//

import UIKit

protocol LoginDataSourceProtocol: UITableViewDataSource {

    func isTableViewValid() -> [ValidationErrorInfo]
}
