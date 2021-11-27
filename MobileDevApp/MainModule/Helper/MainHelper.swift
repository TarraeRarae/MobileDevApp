//
//  Helper.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import Foundation
import CoreMedia

class MainHelper: NSObject {

    enum StringConstant: String {
        case playImageName = "play.fill"
        case pauseFillImageName = "pause.fill"
        case pauseImageName = "pause"
        case multiplyImageName = "multiply"
        case placeholderImageName = "trackPlaceholder"
        case moreMenuImageName = "ellipsis.circle"
        case deleteButtonImageName = "multiply.circle"
        case downloadButtonImageName = "icloud.and.arrow.down"
        case authToken = "Bearer BQBHr-8EarZlCZjIfDNaJUoTPr46guJBHyk2SzXb_TiFK5TeEHGvcrurusgDnCuKcJZnnffb0Z07SNkK0YbKSD8kRZgCLIQewmC1BAwgpAZ9X7Vrs9ApR_g246Y2BQs7w76oBW60rQVw9YFfY0_-1hXnGzqMndBtVAXPIF-NoaAo-g"
        case cid = "774b29d4f13844c495f206cafdad9c86"
        case entityName = "TrackDataEntity"
        case albumURL = "43RGWSAgcUh3ytWu26mdGH"
    }

    enum FloatConstant: Float {
        case previewDurationInSeconds = 30
        case previewDurationInMilliseconds = 30000
    }
}
