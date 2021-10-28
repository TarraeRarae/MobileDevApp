//
//  LoginViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.10.2021.
//

import UIKit

class LoginDataSource: NSObject {

    private let viewModel: TableViewViewModelProtocol? = LoginTableViewViewModel()
    var tableView: UITableView?

    init(tableView: UITableView) {
        self.tableView = tableView
        if var viewModel = viewModel {
            viewModel.tableView = tableView
        }
    }
}

// MARK: - LoginDataSourceProtocol methods

extension LoginDataSource: LoginDataSourceProtocol {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { fatalError() }
        return viewModel.numberOfRows()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthenticationCell.Constant.cellID, for: indexPath) as? AuthenticationCell, let viewModel = viewModel else { fatalError() }
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

    func isTableViewValid() -> [ValidationErrorInfo] {
        guard let viewModel = viewModel, tableView != nil else { fatalError() }
        return viewModel.isTableViewValid
    }
}
