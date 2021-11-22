//
//  TrackData.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import Foundation
import UIKit

class TrackData {
    let artists: [Artist]
    let name: String
    let previewURL: String
    var imagesURLs: [String] = []
    var storedImagesData: [Data]?

    init(data: Item, images: [Image]) {
        self.artists = data.artists
        self.name = data.name
        self.previewURL = data.previewURL
        for image in images {
            self.imagesURLs.append(image.url)
        }
    }

    init(data: Item, images: [Data]) {
        self.artists = data.artists
        self.name = data.name
        self.previewURL = data.previewURL
        self.storedImagesData = images
    }

    static func == (left: TrackData, right: TrackData) -> Bool {
        if left.previewURL == right.previewURL {
            return true
        }
        return false
    }

    func getImageData(from imageURL: String?) -> Data? {
        guard let stringURL = imageURL else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return imageData
    }
}
