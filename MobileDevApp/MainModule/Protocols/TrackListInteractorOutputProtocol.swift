//
//  TrackListInteractorOutputProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

protocol TrackListInteractorOutputProtocol: AnyObject {

    func didReceiveOnlineData(data: [TrackData])
    func diddReceiveDownloadeData(data: [TrackDataEntity])
    func reloadData()
}
