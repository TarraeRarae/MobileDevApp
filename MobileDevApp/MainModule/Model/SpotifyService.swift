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
                "Authorization": "Bearer BQCiJWeGj5z3QavqOlcFzkDbnIwsvu9b1ob1cj8Ij8wAJvkb0ruLUp3qrQXfN0zXvHWj6AqAcjIoUBC7OzJkj4mSBr0XhRcUi_0JWXYuTUmzHU9MRpNGTz0x_6BKjHlUZ4_O2skNigysCul8D7v7WaLdUTbyh4IcmSrE5Heda5_4PA"]
    }

}
