//
//  TableViewViewModelProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

protocol TableViewViewModelProtocol {

    var isTableViewValid: [ValidationErrorInfo] { get }
    var tableView: UITableView? { get set }
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol?
}
