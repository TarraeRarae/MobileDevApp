//
//  RegistrationView.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 16.10.2021.
//

import UIKit

class AuthenticationTableHeaderView: UIView, TableHeaderViewProtocol {

    var pageControll: UISegmentedControl = {
        let segmentControll = UISegmentedControl()

        return segmentControll
    }()

    var pageLabel: UILabel = {
       let label = UILabel()

        return label
    }()

    var nextButton: UIButton = {
       let button = UIButton()

        return button
    }()
}
