//
//  ImageService.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import Foundation
import Moya
import Alamofire

enum ImageService {
    case getImageBy(url: String)
}

extension ImageService: TargetType {
    var baseURL: URL {
        return URL(string: "https://i.scdn.co")!
    }

    var path: String {
        switch self {
        case .getImageBy(let url):
            return "/image/\(url)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getImageBy:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getImageBy:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
