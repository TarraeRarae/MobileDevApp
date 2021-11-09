//
//  TrackListViewModelProtocol.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

protocol TrackListViewModelProtocol: AnyObject {

    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TrackListCellViewModelProtocol?
    func overviewViewModel(for indexPath: IndexPath) -> TrackOverviewViewModelProtocol?
}
