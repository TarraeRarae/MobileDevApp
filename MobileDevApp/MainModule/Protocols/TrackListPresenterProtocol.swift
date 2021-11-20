//
//  TrackListPresenterProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

protocol TrackListPresenterProtocol: AnyObject {

    func viewDidLoad(for index: Int)
    func closeTrack()
    func didExitButtonTap()
    func didClearButtonTap()
    func didCellTap(at indexPath: IndexPath)
    func numberOfRows() -> Int
    func changeTrackCondition(isPaused: Bool)
    func getCellData(for indexPath: IndexPath) -> TrackData
    func saveData(data: TrackData)
}
