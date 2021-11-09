//
//  TrackDataJSON.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.11.2021.
//

import Foundation

struct TrackDataJSON: Codable {

    let tracks: [Tracks]
}

struct Tracks: Codable {

    let album: Album
    let artists: [Artists]
    let name: String
    let uri: String
}

struct Album: Codable {

    let images: [Images]
}

struct Images: Codable {
    let url: URL
    let height: Int
    let width: Int
}

struct Artists: Codable {

    let name: String
}
