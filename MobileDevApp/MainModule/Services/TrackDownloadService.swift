//
//  TrackDownloadService.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 24.11.2021.
//

import Foundation
import Moya

enum TrackDownloadService {

    case downloadTrack(url: String)
}

extension TrackDownloadService: TargetType {

    var baseURL: URL {
        return URL(string: "https://p.scdn.co")!
    }

    var path: String {
        switch self {
        case .downloadTrack(let url):
            return "/mp3-preview/\(url)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .downloadTrack:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .downloadTrack:
            return .downloadParameters(parameters: ["cid": MainHelper.Constant.cid], encoding: URLEncoding.queryString) { _, response in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
                return (fileURL, [.createIntermediateDirectories])
            }
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
