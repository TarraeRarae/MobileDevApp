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
                "Authorization": "Bearer BQAH63g8x5mHp94v2UrUSToTwyjdGVFeXyARTNdIefaKQaqg1W8vc0zRnZ8ASBnEzKglCjaNi79XE_5BsBkwF8nwvfBvLL5N5B7wX4crGVawrjo_lBc213HK-7A3xRevOSWNjqoJBUsB6ApzkqS7wMUMjHMPTRhzeYzx-QiTNYXdWA"]
    }

}
