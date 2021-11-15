//
//  ViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit
import IQKeyboardManagerSwift

class RegistrationViewController: UIViewController {

    private var authenticationTableView: UITableView = UITableView()
    private var keyboardDismissTapGesture: UIGestureRecognizer?
    var authenticationTableHeaderView: AuthenticationTableHeaderView?
    private var registrationTableFooterView: RegistraionTableFooterView?
    private var loginTableFooterView: LoginTableFooterView?
    private var keyboardFrameHeight: CGFloat = 0
    private let backgroundImage: UIImageView = UIImageView(image: UIImage(named: AuthenticationHelper.Constant.backgroundImageName))

    var presenter: RegistrationPresenterProtocol?
    var configurator = RegistrationConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(view: self)
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.frame = UIScreen.main.bounds
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        setupTableView()
        setupAuthenticationHeaderView()
        setupRegistrationFooterView()
        setupLoginFooterView()
        if let authenticationTableHeaderView = authenticationTableHeaderView {
            presenter?.viewDidLoad(for: authenticationTableHeaderView.getCurrentSegmentIndex())
        }
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
        NotificationCenter.default.addObserver(self, selector: #selector(disableView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func enableView() {
        authenticationTableHeaderView?.enableSegmentedControll()
        registrationTableFooterView?.enableSwitcher()
    }

    @objc func disableView() {
        authenticationTableHeaderView?.disableSegmentedControll()
        registrationTableFooterView?.disableSwitcher()
    }
}

// MARK: - UITableViewDataSource methods

extension RegistrationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = authenticationTableView.dequeueReusableCell(withIdentifier: AuthenticationCell.Constant.cellID, for: indexPath) as? AuthenticationCell, let presenter = presenter else { fatalError() }
        cell.cellData = presenter.getCellData(for: indexPath)
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
        guard let tableHeaderView = authenticationTableHeaderView else { return nil }
        switch tableHeaderView.getCurrentSegmentIndex() {
        case 0:
            return loginTableFooterView
        case 1:
            return registrationTableFooterView
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AuthenticationCell.Constant.rowHeight
    }
}

// MARK: - TableHeaderViewDelegate method

extension RegistrationViewController: TableHeaderViewDelegate {

    func updateTableView(indexOfSection index: Int) {
        guard let tableHeaderView = authenticationTableHeaderView else { return }
        presenter?.viewDidLoad(for: tableHeaderView.getCurrentSegmentIndex())
    }
}

// MARK: - TableFooterViewDelegate method

extension RegistrationViewController: TableFooterViewDelegate {

    func authorize() {
        guard let tableHeaderView = authenticationTableHeaderView, let presenter = presenter else { return }
        presenter.validateTableData(tableView: authenticationTableView, for: tableHeaderView.getCurrentSegmentIndex())
    }
}

extension RegistrationViewController: RegistrationViewControllerProtocol {

    func reloadData() {
        DispatchQueue.main.async {
            self.authenticationTableView.reloadData()
        }
    }

    func getCurrentSegmentedIndex() -> Int {
        guard let tableHeaderView = authenticationTableHeaderView else { return 0 }
        return tableHeaderView.getCurrentSegmentIndex()
    }

    func setupAlertController(data: Set<String>) {
        var alertMessage: String = ""
        for item in data {
            alertMessage += item + "\n"
        }
        let alertController = UIAlertController(title: "Error".localized, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
