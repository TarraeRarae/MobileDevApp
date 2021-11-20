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
    var images: [Data] = []

    init(data: Item, images: [Image]) {
        self.artists = data.artists
        self.name = data.name
        self.previewURL = data.previewURL
        for image in images {
            guard let imageData = ImageManager.shared.getImageData(from: image.url) else { continue }
            self.images.append(imageData)
        }
    }

    init(data: Item, images: [Data]) {
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
