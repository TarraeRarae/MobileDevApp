//
//  ViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.09.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	private var authenticationTableView: UITableView = UITableView()
	private let cellID = "cellID"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		setupTableView()
	}

	func setupTableView() {
		self.authenticationTableView = UITableView(frame: view.bounds)
		self.authenticationTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
		self.authenticationTableView.delegate = self
		self.authenticationTableView.dataSource = self
		self.authenticationTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		self.view.addSubview(authenticationTableView)
	}
	
	
	// MARK: - UITableView methods
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
		cell.textLabel?.text = String(indexPath.row)
		return cell
	}
	
}

