//
//  TrackListViewControllerProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

protocol TrackListViewControllerProtocol: AnyObject {

    func reloadData()
    func showTrackOverview(with data: TrackData)
}
