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
                "Authorization": "Bearer BQBhAFN-ZdwPAU7laRoWXz7FBqmJQ_h5-rNo4mSoK0UAamvwvJtCK7N96AHMRGzYWpYlY91Vp0lWS_3rBzs1WAvlWQln5j63gTkzPh2Z42OAUiTolErNTUIZ2RPayZBq6DyFqSpGRCoSItoB2FCQxuwYJJR2HDuioKKXPHirJ8IPFw"]
    }

}
