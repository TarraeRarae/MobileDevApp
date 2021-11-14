//
//  AuthenticationPresenterProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import UIKit

protocol RegistrationPresenterProtocol: AnyObject {

    func viewDidLoad()
    func validateTableData(tableView: UITableView)
    func numberOfRows() -> Int
    func getCellData(for indexPath: IndexPath) -> AuthenticationCellData
}
