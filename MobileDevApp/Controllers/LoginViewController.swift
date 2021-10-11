//
//  LoginViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.10.2021.
//

import UIKit

class LoginViewController: UIViewController {

	private var textFieldDataArray: [TextFieldData] = [
		TextFieldData(placeholder: "Login", isSequre: false, contentType: .emailAddress),
		TextFieldData(placeholder: "Password", isSequre: true, contentType: .password)
	]
	weak var tableView: UITableView!

}

extension LoginViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return textFieldDataArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthenticationCell.Constant.cellID, for: indexPath) as? AuthenticationCell else {
				fatalError("Can't dequeue reusable cell.")
		}
		cell.setTextField(data: textFieldDataArray[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
