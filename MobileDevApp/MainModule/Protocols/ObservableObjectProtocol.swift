//
//  ObservableObject.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 28.11.2021.
//

import Foundation

protocol ObservableObjectProtocol: AnyObject {

    func observableValueDidChange(newValue: Float)
}
