//
//  ViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit

class ViewController: UIViewController {

	private var authenticationTableView: UITableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		setupTableView()
	}

	func setupTableView() {
		self.authenticationTableView = UITableView(frame: view.bounds)
		self.authenticationTableView.register(UINib(nibName: AuthenticationCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: AuthenticationCell.Constant.cellID)
		self.authenticationTableView.separatorStyle = .none
		self.authenticationTableView.delegate = self
		self.authenticationTableView.dataSource = self
		self.authenticationTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(authenticationTableView)
	}

}

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = authenticationTableView.dequeueReusableCell(withIdentifier: AuthenticationCell.Constant.cellID, for: indexPath) as? AuthenticationCell else {
				fatalError("Can't dequeue reusable cell.")
		}
		
		return cell
	}

}

extension ViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return AuthenticationCell.Constant.rowHeight
	}

}
