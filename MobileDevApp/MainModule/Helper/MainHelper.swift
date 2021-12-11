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
        // should be in keychain
        case authToken = "Bearer BQDzN6MF07_NUlLz3PkpxX7L6FqHMwp8hBZRrlXIpSgGyaV6Xw39mOYeoqHprpkihsoFL-2r0BrdBjOXD8QfQMZNutsxuZ6XynKmjafP2GnFM4Tpru11ldcF62HMRXfZg6kX30rANAxpqdwgWpRexRKBWlWGqiVZrfr3MuHyCM-eqg"
        case cid = "774b29d4f13844c495f206cafdad9c86"
        case entityName = "TrackDataEntity"
        case albumURL = "43RGWSAgcUh3ytWu26mdGH"
    }

    enum FloatConstant: Float {
        case previewDurationInSeconds = 30
        case previewDurationInMilliseconds = 30000
    }
}
