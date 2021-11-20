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
                "Authorization": "Bearer BQDnjv41fvvRbQHswFfbtT4fTAZwVmiuB55lOLqe5g6Q2waxvh_Whfn6Y-SjYBPmHFCuq7_u-PLiu_eUvIe766mqdNtl8nYtvfJU8-gMObA-8xlq4idJ_RSvFehyRPP8t6i4e3TR3JdRmgUCnqDHX09slX1CxEWcpCXrKwTiUH9QeQ"]
    }

}
