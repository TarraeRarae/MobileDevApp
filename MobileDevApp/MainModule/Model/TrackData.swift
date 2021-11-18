//
//  TrackData.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import Foundation
import UIKit

struct TrackData {
    let artists: [Artist]
    let name: String
    let previewURL: String
    let images: [Image]

    init(data: Item, images: [Image]) {
        self.artists = data.artists
        self.name = data.name
        self.previewURL = data.previewURL
        self.images = images
    }

    static func == (left: TrackData, right: TrackData) -> Bool {
        if left.previewURL == right.previewURL {
            return true
        }
        return false
    }
}
