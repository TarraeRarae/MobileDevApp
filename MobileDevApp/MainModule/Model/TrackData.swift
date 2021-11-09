//
//  TrackData.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 09.11.2021.
//

import Foundation

struct TrackData {

    let images: [Images]
    let name: String
    let uri: String
    var artistsNames: [String] = []

    init(data: Tracks) {
        self.name = data.name
        self.images = data.album.images
        self.uri = data.uri
        for item in data.artists {
            artistsNames.append(item.name)
        }
    }
}
