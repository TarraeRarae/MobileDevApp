//
//  ViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit
import IQKeyboardManagerSwift

class RegistrationViewController: UIViewController {

    private var viewModel: TableViewViewModelProtocol? = RegistrationTableViewModel()
    private var authenticationTableView: UITableView = UITableView()
    private var keyboardDismissTapGesture: UIGestureRecognizer?
    private var loginView: LoginViewController?
    private var authenticationTableHeaderView: AuthenticationTableHeaderView?
    private var registrationTableFooterView: RegistraionTableFooterView?
    private var loginTableFooterView: LoginTableFooterView?
    private var keyboardFrameHeight: CGFloat = 0
    private let backgroundImage: UIImageView = UIImageView(image: UIImage(named: "background"))

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = UIScreen.main.bounds
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        setupTableView()
        setupAuthenticationHeaderView()
        setupRegistrationFooterView()
        setupLoginFooterView()

        if var viewModel = viewModel {
            viewModel.tableView = authenticationTableView
        }
        loginView = LoginViewController(tableView: authenticationTableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        registerObservers()
        navigationController?.navigationBar.isHidden = true
        authenticationTableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        removeObservers()
    }

    private func setupTableView() {
        authenticationTableView = UITableView(frame: view.frame, style: .grouped)
        authenticationTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        authenticationTableView.backgroundColor = .clear
        authenticationTableView.isScrollEnabled = true
        authenticationTableView.register(UINib(nibName: AuthenticationCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: AuthenticationCell.Constant.cellID)
        authenticationTableView.separatorStyle = .none
        authenticationTableView.delegate = self
        authenticationTableView.dataSource = self
        view.addSubview(authenticationTableView)
    }

    private func setupAuthenticationHeaderView() {
        authenticationTableHeaderView = AuthenticationTableHeaderView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.bounds.height * 0.4))
        authenticationTableHeaderView?.delegate = self
    }

    private func setupRegistrationFooterView() {
        registrationTableFooterView = RegistraionTableFooterView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.bounds.height * 0.4))
        registrationTableFooterView?.delegate = self
    }

    private func setupLoginFooterView() {
        loginTableFooterView = LoginTableFooterView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.bounds.height * 0.4))
        loginTableFooterView?.delegate = self
    }

    private func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(disableSegmentedControll), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableSegmentedControll), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    private func registration() -> Bool {
        guard let viewModel = viewModel else { return false }
        var isValidInput = true
        var errors: Set<String> = []
        for item in viewModel.isTableViewValid {
            isValidInput = isValidInput && item.isValid
            if let errorInfo = item.errorInfo {
                errors.insert(errorInfo)
            }
        }
        if !isValidInput {
            self.setupAlertController(data: errors)
        }
        return isValidInput
    }

    private func login() -> Bool {
        var isValidInput = true
        var errors: Set<String> = []
        if let loginView = loginView {
            for item in loginView.isTableViewValid() {
                isValidInput = isValidInput && item.isValid
                if let errorInfo = item.errorInfo {
                    errors.insert(errorInfo)
                }
            }
        }
        if !isValidInput {
            self.setupAlertController(data: errors)
        }
        return isValidInput
    }

    private func setupAlertController(data: Set<String>) {
        var alertMessage: String = ""
        for item in data {
            alertMessage += item + "\n"
        }
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func enableSegmentedControll() {
        authenticationTableHeaderView?.enableSegmentedControll()
    }

    @objc func disableSegmentedControll() {
        authenticationTableHeaderView?.disableSegmentedControll()
    }
}

// MARK: - UITableViewDataSource methods

extension RegistrationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { fatalError() }
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = authenticationTableView.dequeueReusableCell(withIdentifier: AuthenticationCell.Constant.cellID, for: indexPath) as? AuthenticationCell, let viewModel = viewModel else { fatalError() }
        cell.backgroundColor = .clear
        cell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.layoutIfNeeded()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate methods

extension RegistrationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return authenticationTableHeaderView
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

// MARK: - TableHeaderViewDelegate method

extension RegistrationViewController: TableHeaderViewDelegate {

    func updateTableView(indexOfSection index: Int) {
        switch index {
        case 0:
            authenticationTableView.dataSource = loginView
            authenticationTableView.reloadData()
        case 1:
            authenticationTableView.dataSource = self
            authenticationTableView.reloadData()
        default:
            return
        }
    }
}

// MARK: - TableFooterViewDelegate method

extension RegistrationViewController: TableFooterViewDelegate {

    func authorize() {
        var isValid: Bool = true
        if authenticationTableView.dataSource === self {
            isValid = registration()
        } else {
           isValid =  login()
        }
        if isValid {
            show(TrackListViewController(), sender: nil)
        }
    }
}
