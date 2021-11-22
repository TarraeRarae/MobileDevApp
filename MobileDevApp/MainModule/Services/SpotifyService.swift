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
}

extension SpotifyService: TargetType {

    var baseURL: URL {
        URL(string: "https://api.spotify.com")!
    }

    var path: String {
        switch self {
        case .getTracksFromAlbum(let albumID):
            return "/v1/albums/\(albumID)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getTracksFromAlbum:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getTracksFromAlbum:
            return .requestParameters(parameters: ["market": "ES"], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Bearer BQDbqN2askjPKSKMgZIGojV2vcZif-bAWfozzkRt2251DrNWb09x4IvctmAu9nVPZwyC3iSf7DZE8kwiWJ_J8eRE6aRsFHVzfpI-C1XynQ_MN7TEIhgIDuF3MsWYte2fjf-SZHtNQ8EaOl4tr1KaJ-DG_-RzXR28otEg5d95UKzkrQ"]
    }

}
