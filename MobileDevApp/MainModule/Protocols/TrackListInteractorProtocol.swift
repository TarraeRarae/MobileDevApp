//
//  TrackListInteractorProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

protocol TrackListInteractorProtocol: AnyObject {

    func fetchData()
    func startTrack(data: TrackData)
    func playTrack()
    func pauseTrack()
    func closeTrack()
}
