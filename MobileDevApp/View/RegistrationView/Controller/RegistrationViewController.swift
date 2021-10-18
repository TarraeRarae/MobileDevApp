//
//  ViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit
import IQKeyboardManagerSwift

class ViewController: UIViewController, TableHeaderViewDelegate, TableFooterViewDelegate {

    private var viewModel: TableViewViewModelProtocol? = RegistrationTableViewModel()
    private var authenticationTableView: UITableView = UITableView()
    private var keyboardDismissTapGesture: UIGestureRecognizer?
    private var loginView: LoginViewController?
    private var tableHeaderView: AuthenticationTableHeaderView?
    private var registrationTableFooterView: RegistraionTableFooterView?
    private var loginTableFooterView: LoginTableFooterView?
    private var keyboardFrameHeight: CGFloat = 0
    private let backgroundImage: UIImageView = UIImageView(image: UIImage(named: "background"))

    // MARK: - That's OK

	override func viewDidLoad() {
		super.viewDidLoad()
		backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.contentMode = .scaleAspectFill
		backgroundImage.frame = UIScreen.main.bounds
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
		setupTableView()

        tableHeaderView = AuthenticationTableHeaderView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.bounds.height * 0.4))
        tableHeaderView?.delegate = self

        registrationTableFooterView = RegistraionTableFooterView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.bounds.height * 0.4))
        registrationTableFooterView?.delegate = self

        loginTableFooterView = LoginTableFooterView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.bounds.height * 0.4))
        loginTableFooterView?.delegate = self

        if var viewModel = viewModel {
            viewModel.tableView = authenticationTableView
        }
        loginView = LoginViewController(tableView: authenticationTableView)
	}

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
		authenticationTableView.reloadData()
	}

	func setupTableView() {
        authenticationTableView = UITableView(frame: view.bounds, style: .grouped)
		authenticationTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		authenticationTableView.backgroundColor = .clear
		authenticationTableView.isScrollEnabled = true
		authenticationTableView.register(UINib(nibName: AuthenticationCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: AuthenticationCell.Constant.cellID)
		authenticationTableView.separatorStyle = .none
		authenticationTableView.delegate = self
		authenticationTableView.dataSource = self
		view.addSubview(authenticationTableView)
	}

    // MARK: - TableFooterViewDelegate method

    func authorize() {
        guard let viewModel = viewModel else { return }
        var isValidInput = true
        var errors: Set<String> = []
        if authenticationTableView.dataSource === self {
            for item in viewModel.isTableViewValid {
                isValidInput = isValidInput && item.isValid
                if let errorInfo = item.errorInfo {
                    errors.insert(errorInfo)
                }
            }
        } else {
            if let loginView = loginView {
                for item in loginView.isTableViewValid() {
                    isValidInput = isValidInput && item.isValid
                    if let errorInfo = item.errorInfo {
                        errors.insert(errorInfo)
                    }
                }
            }
        }
        if isValidInput {
            show(TrackListViewController(), sender: nil)
        } else {
            self.setupAlertController(data: errors)
        }
    }

    private func setupAlertController(data: Set<String>) {
        var alertMessage: String = """
"""
        for item in data {
            alertMessage += item + "\n"
        }
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - TableHeaderViewDelegate method

    func updateTableView() {
        self.view.endEditing(true)
        if authenticationTableView.dataSource === self {
            authenticationTableView.dataSource = loginView
            authenticationTableView.reloadData()
        } else {
            authenticationTableView.dataSource = self
            authenticationTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource methods

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { fatalError() }
        return viewModel.numberOfRows()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = authenticationTableView.dequeueReusableCell(withIdentifier: AuthenticationCell.Constant.cellID, for: indexPath) as? AuthenticationCell, let viewModel = viewModel else { fatalError() }
		cell.backgroundColor = .clear
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

// MARK: - UITableViewDelegate methods

extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if authenticationTableView.dataSource === self {
            registrationTableFooterView?.updateSwitcher()
            return self.registrationTableFooterView
        }
        return loginTableFooterView
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return AuthenticationCell.Constant.rowHeight
	}
}
