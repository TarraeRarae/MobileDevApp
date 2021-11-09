//
//  TrackListViewModelProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

protocol TrackListViewModelProtocol: AnyObject {

    func numberOfRows() -> Int
    func getData(for indexPath: IndexPath) -> TrackData?
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TrackListCellViewModelProtocol?
}
