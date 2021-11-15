//
//  TrackListPresenterProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 15.11.2021.
//

import Foundation

protocol TrackListPresenterProtocol: AnyObject {

    func viewDidLoad()
    func didCellTap(at indexPath: IndexPath)
    func numberOfRows() -> Int
    func getCellData(for indexPath: IndexPath) -> TrackData
}
