//
//  ViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit

class ViewController: UIViewController {

	private var authenticationTableView: UITableView = UITableView()
	private var textFieldDataArray: [TextFieldData] = [
		TextFieldData(placeholder: "Email", isSequre: false, contentType: .emailAddress),
		TextFieldData(placeholder: "Username", isSequre: false, contentType: .username),
		TextFieldData(placeholder: "*********", isSequre: true, contentType: .password),
		TextFieldData(placeholder: "*********", isSequre: true, contentType: .password)
	]
	private var keyboardDismissTapGesture: UIGestureRecognizer?
	private let loginPageButton: UIButton = UIButton()
	private let registerPageButton: UIButton = UIButton()
	private let nextButton: UIButton = UIButton()
	private let loginView = LoginViewController()
	private let confirmLabel: UILabel = UILabel()
	private let confirmSwitch: UISwitch = UISwitch()
	private let backgroundImage: UIImageView = UIImageView(image: UIImage(named: "background"))

	override func viewDidLoad() {
		super.viewDidLoad()
		UserDefaults.standard.removeObject(forKey: "Username")
		UserDefaults.standard.removeObject(forKey: "UserPassword")
		registerKeyboardNotifications()
		backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		backgroundImage.frame = UIScreen.main.bounds
		view.insertSubview(backgroundImage, at: 0)
		loginView.tableView = authenticationTableView
		setupTableView()
		setupLoginPageButton()
		setupRegisterPageButton()
		setupConfirmLabel()
		setupNextButton()
	}

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
		authenticationTableView.reloadData()
	}

	deinit {
		removeKeyboardNotifications()
	}

	func setupTableView() {
		authenticationTableView = UITableView(frame: view.bounds)
		authenticationTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		authenticationTableView.backgroundColor = .clear
		authenticationTableView.isScrollEnabled = false
		authenticationTableView.register(UINib(nibName: AuthenticationCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: AuthenticationCell.Constant.cellID)
		authenticationTableView.separatorStyle = .none
		authenticationTableView.delegate = self
		authenticationTableView.dataSource = self

		view.addSubview(authenticationTableView)
	}

	func setupLoginPageButton() {
		loginPageButton.backgroundColor = .white
		loginPageButton.setTitleColor(.black, for: .normal)
		loginPageButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
		loginPageButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.6)
		loginPageButton.layer.borderWidth = 0.5
		loginPageButton.layer.shadowColor = UIColor.black.cgColor
		loginPageButton.layer.shadowOpacity = 0.5
		loginPageButton.layer.shadowRadius = 5
		loginPageButton.layer.shadowOffset = CGSize(width: 1.0, height: 3)
		loginPageButton.setTitleColor(.black, for: .normal)
		loginPageButton.layer.cornerRadius = 10
		loginPageButton.addTarget(nil, action: #selector(setLoginTableView), for: .touchUpInside)
		loginPageButton.setTitle("Login", for: .normal)
	}

	func setupRegisterPageButton() {
		registerPageButton.backgroundColor = .white
		registerPageButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
		registerPageButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.6)
		registerPageButton.layer.borderWidth = 0.5
		registerPageButton.layer.shadowColor = UIColor.black.cgColor
		registerPageButton.layer.shadowOpacity = 0.5
		registerPageButton.layer.shadowRadius = 5
		registerPageButton.layer.shadowOffset = CGSize(width: 1.0, height: 3)
		registerPageButton.setTitleColor(.black, for: .normal)
		registerPageButton.layer.cornerRadius = 10
		registerPageButton.addTarget(nil, action: #selector(setRegisterTableView), for: .touchUpInside)
		registerPageButton.setTitle("Register", for: .normal)
	}

	func setupNextButton() {
		nextButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.6)
		nextButton.layer.borderWidth = 0.5
		nextButton.layer.shadowColor = UIColor.black.cgColor
		nextButton.layer.shadowOpacity = 0.5
		nextButton.layer.shadowRadius = 5
		nextButton.layer.shadowOffset = CGSize(width: 1.0, height: 3)
		nextButton.addTarget(nil, action: #selector(authorize), for: .touchUpInside)
		nextButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
		nextButton.backgroundColor = .white
		nextButton.layer.cornerRadius = 10
		nextButton.tintColor = .black
	}

	func setupConfirmLabel() {
		confirmLabel.text = "Confirm our privacy policy"
		confirmLabel.textColor = .black
		confirmLabel.lineBreakMode = .byWordWrapping
		confirmLabel.numberOfLines = 0
	}

	func setupSwitch() {
		confirmSwitch.preferredStyle = .automatic
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
		let userInfo = notification.userInfo
		let keyboardFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
		authenticationTableView.contentOffset = CGPoint(x: 0, y: keyboardFrameSize!.height / 2)
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
		var isDataValid = true
		if authenticationTableView.dataSource === self {
			ValidationManager.password = nil
			var arrayOfString: [String] = []
			for row in 0..<textFieldDataArray.count {
				let indexPath = IndexPath(row: row, section: 0)
				guard let cell = authenticationTableView.cellForRow(at: indexPath) as? AuthenticationCell else {
					return
				}
				let textField = cell.getTextField()
				if !ValidationManager.isRegistrationTextFieldValid(textField) {
					cell.makeTextFieldInvalid()
					isDataValid = false
				} else if row < 2 {
					arrayOfString.append(textField.text!)
				}
			}
			if !confirmSwitch.isOn {
				isDataValid = false
			}
			if isDataValid {
				UserDefaults.standard.setValue(arrayOfString[0], forKeyPath: "Username")
				UserDefaults.standard.setValue(arrayOfString[1], forKeyPath: "UserPassword")
			}
		} else {
			for row in 0..<2 {
				let indexPath = IndexPath(row: row, section: 0)
				guard let cell = authenticationTableView.cellForRow(at: indexPath) as? AuthenticationCell else {
					return
				}
				let textField = cell.getTextField()
				if !ValidationManager.isLoginTextFieldValid(textField) {
					cell.makeTextFieldInvalid()
					isDataValid = false
				}
			}
		}
		if isDataValid {
			show(TrackListViewController(), sender: nil)
		}
	}

}

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return textFieldDataArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = authenticationTableView.dequeueReusableCell(withIdentifier: AuthenticationCell.Constant.cellID, for: indexPath) as? AuthenticationCell else {
				fatalError("Can't dequeue reusable cell.")
		}
		cell.backgroundColor = .clear
		cell.setTextField(data: textFieldDataArray[indexPath.row])
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
