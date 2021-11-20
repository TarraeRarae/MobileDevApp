//
//  ImageManager.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import Foundation
import UIKit

class ImageManager {

    static let shared = ImageManager()

    func getImageData(from imageURL: String?) -> Data? {
        guard let stringURL = imageURL else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        return imageData
    }

    func coreDataObjectFromImages(imagesData: [Data]) -> Data? {
        let dataArray = NSMutableArray()
        var images: [UIImage] = []
        for item in imagesData {
            if let image = UIImage(data: item) {
                images.append(image)
            }
        }
        for item in images {
            if let data = item.pngData() {
                dataArray.add(data)
            }
        }
        return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
    }

    func imagesFromCoreDataObject(object: Data?) -> [Data] {
        var result: [Data] = []
        guard let object = object else { return [] }
        if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
            for data in dataArray {
                if let data = data as? Data {
                    result.append(data)
                }
            }
        }
        return result
    }
}
