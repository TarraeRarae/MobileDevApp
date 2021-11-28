//
//  TrackListTableViewCellDelegate.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 20.11.2021.
//

import Foundation

protocol TrackListTableViewCellDelegate: AnyObject {

    func didDataButtonTap(data: TrackData, isDataDownloaded: Bool, closure: @escaping () -> Void)
}
