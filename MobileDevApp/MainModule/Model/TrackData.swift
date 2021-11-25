//
//  TrackData.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import Foundation
import UIKit
import Alamofire

struct TrackData {
    let artists: [Artist]
    let name: String
    let previewURL: String
    var imagesURLs: [String] = []
    var destinationURL: URL?

    init(data: Item, images: [Image] = []) {
        self.artists = data.artists
        self.name = data.name
        self.previewURL = data.previewURL
        for image in images {
            self.imagesURLs.append(image.url)
        }
    }

    static func == (left: TrackData, right: TrackData) -> Bool {
        if left.previewURL == right.previewURL {
            return true
        }
        return false
    }
}
