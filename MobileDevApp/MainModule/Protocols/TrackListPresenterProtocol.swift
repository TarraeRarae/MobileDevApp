//
//  TrackListPresenterProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

protocol TrackListPresenterProtocol: AnyObject {

    func viewDidLoad()
    func closeTrack()
    func didCellTap(at indexPath: IndexPath)
    func numberOfRows() -> Int
    func changeTrackCondition(isPaused: Bool)
    func getCellData(for indexPath: IndexPath) -> TrackData
}