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
                "Authorization": "Bearer BQBciRTuMqeZ7jO2_2jnz1q5J_JldNUPRlXLuEO-_8Njs7z7E_6-DbvR-7afR9EQsFFAK3bOfADjcg_CVsO4Fpv1FfZHBgCC4B2vX9yqiEcMf0HvZboWGpcz9e-w_p84mzMnbrqBZrJw4LjvUZdDAIVf2WGuPFXqXIMiBv9le7gedg"]
    }

}
