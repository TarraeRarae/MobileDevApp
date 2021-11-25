//
//  TrackListInteractorProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

protocol TrackListInteractorProtocol: AnyObject {

    func fetchOnlineData()
    func fetchDownloadedData()
    func startTrack(data: TrackData)
    func clearDownloadedData()
    func playTrack()
    func pauseTrack()
    func closeTrack()
    func saveData(data: TrackData)
    func isDataSaved(data: TrackData) -> Bool
    func deleteObjectFromSavedData(data: TrackData)
}
