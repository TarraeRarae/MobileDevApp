//
//  LoginViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.10.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel: TableViewViewModelProtocol? = LoginTableViewViewModel()
    var tableView: UITableView?

    init(tableView: UITableView) {
        self.tableView = tableView
        if var viewModel = viewModel {
            viewModel.tableView = tableView
        }
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func isTableViewValid() -> Bool {
        guard let viewModel = viewModel, tableView != nil else { fatalError() }
        return viewModel.isTableViewValid
    }
}

extension LoginViewController: UITableViewDataSource {

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
}
