//
//  AuthenticationPresenterProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import UIKit

protocol RegistrationPresenterProtocol: AnyObject {

    func viewDidLoad(for segmentedIndex: Int)
    func validateTableData(tableView: UITableView, for segmentedIndex: Int)
    func numberOfRows() -> Int
    func getCellData(for indexPath: IndexPath) -> AuthenticationCellData
}
