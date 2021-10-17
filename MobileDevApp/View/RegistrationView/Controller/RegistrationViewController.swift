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
    private var loginView: LoginViewController?
    private var keyboardFrameHeight: CGFloat = 0
    private let backgroundImage: UIImageView = UIImageView(image: UIImage(named: "background"))
    private var pageControll: UISegmentedControl = {
        let segmentedControll = UISegmentedControl()
        segmentedControll.backgroundColor = .white
        segmentedControll.selectedSegmentTintColor = .white
        segmentedControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentedControll.insertSegment(withTitle: "Login", at: 0, animated: true)
        segmentedControll.insertSegment(withTitle: "Registration", at: 1, animated: true)
        segmentedControll.selectedSegmentIndex = 1
        segmentedControll.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        segmentedControll.layer.shadowColor = UIColor.black.cgColor
        segmentedControll.layer.shadowRadius = 10
        segmentedControll.layer.shadowOpacity = 0.5
        return segmentedControll
    }()

	private let nextButton: UIButton = {
        let button = UIButton()
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
        return switcher
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
		backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.contentMode = .scaleAspectFill
		backgroundImage.frame = UIScreen.main.bounds
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
		setupTableView()
        if var viewModel = viewModel {
            viewModel.tableView = authenticationTableView
        }
        loginView = LoginViewController(tableView: authenticationTableView)
	}

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
		authenticationTableView.reloadData()
        confirmSwitch.isOn = false
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

    @objc func authorize() {
        guard let viewModel = viewModel else { return }
        var isValidInput = true
        if  authenticationTableView.dataSource === self {
            isValidInput = isValidInput && viewModel.isTableViewValid && self.confirmSwitch.isOn
        } else {
            if let loginView = loginView {
                isValidInput = isValidInput && loginView.isTableViewValid()
            }
        }
        if isValidInput {
            show(TrackListViewController(), sender: nil)
        }
    }

    @objc func indexChanged(_ sender: UISegmentedControl) {
        if pageControll.selectedSegmentIndex == 0 {
            authenticationTableView.dataSource = loginView
            authenticationTableView.reloadData()
        } else if pageControll.selectedSegmentIndex == 1 {
            authenticationTableView.dataSource = self
            authenticationTableView.reloadData()
        }
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
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.addSubview(pageControll)
        NSLayoutConstraint.activate([
            pageControll.centerXAnchor.constraint(equalTo: tableHeaderView.centerXAnchor),
            pageControll.centerYAnchor.constraint(equalTo: tableHeaderView.centerYAnchor),
            pageControll.widthAnchor.constraint(equalTo: tableHeaderView.widthAnchor, multiplier: 0.6),
            pageControll.heightAnchor.constraint(equalTo: tableHeaderView.heightAnchor, multiplier: 0.15)
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
