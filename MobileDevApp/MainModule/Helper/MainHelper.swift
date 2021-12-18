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
        case trashCircleImageName = "trash.circle"
        case chevronBackwardCircleImageName = "chevron.backward.circle"
        case placeholderImageName = "trackPlaceholder"
        case moreMenuImageName = "ellipsis.circle"
        case deleteButtonImageName = "multiply.circle"
        case downloadButtonImageName = "icloud.and.arrow.down"
        // should be in keychain
        case authToken = "Bearer BQB96Z3co3mDdhbMeMJsXhGe0v8x4pX36yn64D3YHSSTG4MBZSzUpiTCvC1GFsENWaOsdFt0F3JmM9i4p9AmWcz8tVSEtLAVo8zS1y_0auC5cNNdwRvYjtPgrWLbtXiGx-1lQ51BMtwSopXYEd-q4tnnqwyESyD75836WQT_Q0U3rg"
        case cid = "774b29d4f13844c495f206cafdad9c86"
        case entityName = "TrackDataEntity"
        case albumURL = "43RGWSAgcUh3ytWu26mdGH"
    }

    enum FloatConstant: Float {
        case previewDurationInSeconds = 30
        case previewDurationInMilliseconds = 30000
    }
}
