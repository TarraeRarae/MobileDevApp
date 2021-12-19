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
        case authToken = "Bearer BQCpskQPBJZ78ZD9-_QcX5la1VRIeetuA4dcFFiCfvjj5EaojGhg26qifN1Hl1_ERC8bSdfB3MbsHBC0cjZQ8EJ_6QchdB9vWlEzsput5Lm4VNH9h-mhtA8k6lKH2zxE7TEKHCqMEoVMNpulgV41jqgKwvd2Zy7yEtZxsQYHdTyyCQ"
        case cid = "774b29d4f13844c495f206cafdad9c86"
        case entityName = "TrackDataEntity"
        case albumURL = "43RGWSAgcUh3ytWu26mdGH"
    }

    enum FloatConstant: Float {
        case previewDurationInSeconds = 30
        case previewDurationInMilliseconds = 30000
    }
}
