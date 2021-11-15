//
//  AuthenticationInteractorOutputProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 14.11.2021.
//

import Foundation

protocol AuthenticationInteractorOutputProtocol: AnyObject {

    func didReceiveData(data: [AuthenticationCellData])
}
