//
//  TrackDataJSON.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.11.2021.
//

import Foundation

struct TrackDataJSON: Codable {
    let images: [Image]
    let tracks: TracksJSON

    enum CodingKeys: String, CodingKey {
        case images, tracks
    }
}

struct Image: Codable {
    let height: Int
    let url: String
    let width: Int
}

struct TracksJSON: Codable {
    let items: [Item]
}

struct Item: Codable {
    let artists: [Artist]
    let name: String
    let previewURL: String
    let durationMS: Int64

    enum CodingKeys: String, CodingKey {
        case artists, name
        case previewURL = "preview_url"
        case durationMS = "duration_ms"
    }
}

struct Artist: Codable {
    let name: String
}
