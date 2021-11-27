//
//  NetworkManager.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 10.11.2021.
//

import Foundation
import Moya
import Alamofire

enum SpotifyService {

    case getTracksFromAlbum(albumID: String)
    case checkConnection
}

extension SpotifyService: TargetType {

    var baseURL: URL {
        URL(string: "https://api.spotify.com")!
    }

    var path: String {
        switch self {
        case .getTracksFromAlbum(let albumID):
            return "/v1/albums/\(albumID)"
        case .checkConnection:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .getTracksFromAlbum:
            return .get
        case .checkConnection:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getTracksFromAlbum:
            return .requestParameters(parameters: ["market": "ES"], encoding: URLEncoding.queryString)
        case .checkConnection:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": MainHelper.StringConstant.authToken.rawValue]
    }

}
