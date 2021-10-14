//
//  ViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: TableViewViewModelProtocol? = RegistrationTableViewModel()
	private var authenticationTableView: UITableView = UITableView()
	private var keyboardDismissTapGesture: UIGestureRecognizer?
    private let loginView = LoginViewController()
    private var keyboardFrameHeight: CGFloat = 0
    private let backgroundImage: UIImageView = UIImageView(image: UIImage(named: "background"))

	private let loginPageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        button.layer.borderWidth = 0.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 1.0, height: 3)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(setLoginTableView), for: .touchUpInside)
        button.setTitle("Login", for: .normal)
        return button
    }()

    private let registerPageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        button.layer.borderWidth = 0.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 1.0, height: 3)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(setRegisterTableView), for: .touchUpInside)
        button.setTitle("Register", for: .normal)
        return button
    }()

	private let nextButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        button.layer.borderWidth = 0.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 1.0, height: 3)
        button.addTarget(nil, action: #selector(authorize), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.tintColor = .black
        return button
    }()

	private let confirmLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm our privacy policy"
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
	private let confirmSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.preferredStyle = .automatic
        return switcher
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
//		UserDefaults.standard.removeObject(forKey: "Username")
//		UserDefaults.standard.removeObject(forKey: "UserPassword")
		registerKeyboardNotifications()
		backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		backgroundImage.frame = UIScreen.main.bounds
		view.insertSubview(backgroundImage, at: 0)
		loginView.tableView = authenticationTableView
		setupTableView()
        if var viewModel = viewModel {
            viewModel.tableView = authenticationTableView
        }
	}

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
		authenticationTableView.reloadData()
	}

	deinit {
		removeKeyboardNotifications()
	}

	func setupTableView() {
        authenticationTableView = UITableView(frame: view.bounds, style: .grouped)
		authenticationTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		authenticationTableView.backgroundColor = .clear
		authenticationTableView.isScrollEnabled = false
		authenticationTableView.register(UINib(nibName: AuthenticationCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: AuthenticationCell.Constant.cellID)
		authenticationTableView.separatorStyle = .none
		authenticationTableView.delegate = self
		authenticationTableView.dataSource = self

		view.addSubview(authenticationTableView)
	}

	func registerKeyboardNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	func removeKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}

	@objc func keyboardWillShow(_ notification: Notification) {
        if keyboardFrameHeight == 0 {
            let userInfo = notification.userInfo
            guard let keyboardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            self.keyboardFrameHeight = keyboardFrameSize.height
        }
        authenticationTableView.contentOffset = CGPoint(x: 0, y: keyboardFrameHeight * 0.9)
		if keyboardDismissTapGesture == nil {
			keyboardDismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
			keyboardDismissTapGesture?.cancelsTouchesInView = false
			self.view.addGestureRecognizer(keyboardDismissTapGesture!)
		}
	}

	@objc func setLoginTableView() {
		authenticationTableView.dataSource = loginView
		authenticationTableView.reloadData()
	}

	@objc func setRegisterTableView() {
		authenticationTableView.dataSource = self
		authenticationTableView.reloadData()
	}

	@objc func keyboardWillHide(_ notification: Notification) {
		authenticationTableView.contentOffset = CGPoint.zero
		if keyboardDismissTapGesture != nil {
			self.view.removeGestureRecognizer(keyboardDismissTapGesture!)
			keyboardDismissTapGesture = nil
		}
	}

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func authorize() {
        guard let viewModel = viewModel else { return }
        if viewModel.isTableViewValid {
            show(TrackListViewController(), sender: nil)
        }
        return
    }

}

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

extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.frame.height * 0.4))
		tableHeaderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		tableHeaderView.addSubview(loginPageButton)
		tableHeaderView.addSubview(registerPageButton)

		loginPageButton.translatesAutoresizingMaskIntoConstraints = false
		registerPageButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loginPageButton.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: tableHeaderView.frame.height * 0.4),
			loginPageButton.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: tableHeaderView.frame.width * 0.1),
			loginPageButton.trailingAnchor.constraint(equalTo: registerPageButton.leadingAnchor, constant: -tableHeaderView.frame.width * 0.2),
			loginPageButton.heightAnchor.constraint(equalTo: tableHeaderView.heightAnchor, multiplier: 0.1),

			registerPageButton.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: tableHeaderView.frame.height * 0.4),
			registerPageButton.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -tableHeaderView.frame.width * 0.1),
			registerPageButton.heightAnchor.constraint(equalTo: tableHeaderView.heightAnchor, multiplier: 0.1),
			registerPageButton.widthAnchor.constraint(equalTo: tableHeaderView.widthAnchor, multiplier: 0.3)
		])
		tableHeaderView.layoutIfNeeded()
		return tableHeaderView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return authenticationTableView.bounds.height * 0.4
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: authenticationTableView.bounds.width, height: authenticationTableView.bounds.height * 0.4))
		tableFooterView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		tableFooterView.addSubview(nextButton)
		nextButton.translatesAutoresizingMaskIntoConstraints = false
		if authenticationTableView.dataSource === self {
			tableFooterView.addSubview(confirmSwitch)
			tableFooterView.addSubview(confirmLabel)
			confirmLabel.translatesAutoresizingMaskIntoConstraints = false
			confirmSwitch.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				confirmSwitch.topAnchor.constraint(equalTo: tableFooterView.topAnchor, constant: tableFooterView.frame.height * 0.1),
				confirmSwitch.leadingAnchor.constraint(equalTo: tableFooterView.leadingAnchor, constant: tableFooterView.frame.width * 0.2),
				confirmSwitch.widthAnchor.constraint(equalTo: tableFooterView.widthAnchor, multiplier: 0.1),
				confirmSwitch.heightAnchor.constraint(equalTo: tableFooterView.heightAnchor, multiplier: 0.25),

				confirmLabel.topAnchor.constraint(equalTo: tableFooterView.topAnchor, constant: tableFooterView.frame.height * 0.07),
				confirmLabel.trailingAnchor.constraint(equalTo: tableFooterView.trailingAnchor, constant: -tableFooterView.frame.width * 0.2),
				confirmLabel.widthAnchor.constraint(equalTo: tableFooterView.widthAnchor, multiplier: 0.3),
				confirmLabel.heightAnchor.constraint(equalTo: tableFooterView.heightAnchor, multiplier: 0.3),

				nextButton.topAnchor.constraint(equalTo: tableFooterView.topAnchor, constant: tableFooterView.frame.height * 0.4),
				nextButton.bottomAnchor.constraint(equalTo: tableFooterView.bottomAnchor, constant: -tableFooterView.frame.height * 0.15),
				nextButton.leadingAnchor.constraint(equalTo: tableFooterView.leadingAnchor, constant: tableFooterView.frame.width * 0.4),
				nextButton.trailingAnchor.constraint(equalTo: tableFooterView.trailingAnchor, constant: -tableFooterView.frame.width * 0.4)
			])
		} else {
			NSLayoutConstraint.activate([
				nextButton.topAnchor.constraint(equalTo: tableFooterView.topAnchor, constant: tableFooterView.frame.height * 0.2),
				nextButton.bottomAnchor.constraint(equalTo: tableFooterView.bottomAnchor, constant: -tableFooterView.frame.height * 0.35),
				nextButton.leadingAnchor.constraint(equalTo: tableFooterView.leadingAnchor, constant: tableFooterView.frame.width * 0.4),
				nextButton.trailingAnchor.constraint(equalTo: tableFooterView.trailingAnchor, constant: -tableFooterView.frame.width * 0.4)
			])
		}
		tableFooterView.layoutIfNeeded()
		return tableFooterView
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return AuthenticationCell.Constant.rowHeight
	}

}
