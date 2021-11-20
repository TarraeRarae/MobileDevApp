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
                "Authorization": "Bearer BQD2Ov9ATs53UggofnneIVbUuO1cuFKZkyqgMW1tWPyeJIBAz2qTYGQZB3AaqSo1gjxTW8N3TZHeY9yXJB4b7aj_oWViZQJln7yQsU_3PjAgZN5VaAjCIFLKaQUIu62SjaMijlD0RbMhZdLKzWCncH-lrD7uLaYQ_xmGeA08BbydPQ"]
    }

}
