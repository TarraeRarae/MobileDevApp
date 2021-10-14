//
//  LoginViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.10.2021.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel: TableViewViewModelProtocol? = LoginTableViewViewModel()
	weak var tableView: UITableView!

    override func viewDidLoad() {
        if var viewModel = viewModel {
            viewModel.tableView = tableView
        }
    }

    func isTableViewValid() -> Bool {
        guard let viewModel = viewModel else { fatalError() }
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
