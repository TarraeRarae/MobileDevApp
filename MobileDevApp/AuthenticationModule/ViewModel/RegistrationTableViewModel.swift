//
//  RegistrationTableViewModel.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 13.10.2021.
//

import UIKit

// class RegistrationTableViewModel: TableViewViewModelProtocol {
//
//    private let cellDataArray: [AuthenticationCellData] =  [
//        AuthenticationCellData(tag: 0, placeholder: "Email".localized, isSequreTextField: false, contentType: .emailAddress),
//        AuthenticationCellData(tag: 0, placeholder: "Username".localized, isSequreTextField: false, contentType: .username),
//        AuthenticationCellData(tag: 0, placeholder: "Password. At least 6. Must contains num".localized, isSequreTextField: true, contentType: .password),
//        AuthenticationCellData(tag: 0, placeholder: "Confirm password".localized, isSequreTextField: true, contentType: .password)]
//    private let validator = AuthenticationHelper()
//    var tableView: UITableView?
//
//    var isTableViewValid: [ValidationErrorInfo] {
//        return self.validateTableView()
//    }
//
//    func numberOfRows() -> Int {
//        return cellDataArray.count
//    }
//
//    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelProtocol? {
//        let cellViewModel = AuthenticationCellViewModel(cellData: cellDataArray[indexPath.row])
//        cellViewModel.complition = { tag in
//            if self.tableView?.viewWithTag(cellViewModel.tag) != nil {
//                // Closure for change editing textField
//            }
//        }
//        return cellViewModel
//    }
//
//    private func validateTableView() -> [ValidationErrorInfo] {
//        guard let tableView = tableView else { return [] }
//        var validationErrors: [ValidationErrorInfo] = []
//        for cell in tableView.visibleCells {
//            guard let authCell = cell as? AuthenticationCell, let viewModel = authCell.viewModel else { return [] }
//            let cellValidation = validate(text: authCell.textField.text, cellData: viewModel.cellData)
//            if !cellValidation.isValid {
//                authCell.makeTextFieldInvalid()
//            }
//            validationErrors.append(cellValidation)
//        }
//        saveUserData(data: validationErrors)
//        return validationErrors
//    }

//    private func saveUserData(data: [ValidationErrorInfo]) {
//        var isValid: Bool = true
//        for item in data {
//            isValid = isValid && item.isValid
//        }
//        if isValid {
//            guard let tableView = tableView else { return }
//            for cell in tableView.visibleCells {
//                guard let authCell = cell as? AuthenticationCell, let viewModel = authCell.viewModel else { return }
//                self.addUserDataToUserDefaults(text: authCell.textField.text, cellData: viewModel.cellData)
//            }
//        }
//    }
//
//    public func validate(text: String?, cellData: AuthenticationCellData) -> ValidationErrorInfo {
//        guard let text = text else { return ValidationErrorInfo(isValid: false, errorInfo: nil) }
//        if text.count == 0 {
//            return ValidationErrorInfo(isValid: false, errorInfo: "Input data into all fields".localized)
//        }
//        switch cellData.contentType {
//        case .emailAddress:
//            return validator.validateEmail(email: text)
//        case .password:
//                return validator.validatePassword(password: text)
//        case .username:
//            return ValidationErrorInfo(isValid: true, errorInfo: nil)
//        case .confirmPassword:
//            return validator.comparePasswords(password: text)
//        }
//    }
//
//    public func addUserDataToUserDefaults(text: String?, cellData: AuthenticationCellData) {
//        guard let text = text else { return }
//        switch cellData.contentType {
//        case .username:
//            UserDefaults.standard.set(text, forKey: AuthenticationCellViewModel.Constant.usernameKey)
//        case .password:
//            UserDefaults.standard.set(text, forKey: AuthenticationCellViewModel.Constant.userPasswordKey)
//        default:
//            return
//        }
//    }
// }
