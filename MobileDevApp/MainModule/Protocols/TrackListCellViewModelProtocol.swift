//
//  TrackListCellViewModelProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

protocol TrackListCellViewModelProtocol: AnyObject {

    var cellTrackData: TrackData { get }
    var name: String { get }
    var uri: String { get }
    var artistNames: [String] { get }
}
