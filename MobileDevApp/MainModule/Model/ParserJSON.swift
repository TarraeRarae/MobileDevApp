//
//  ParserJSON.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.11.2021.
//

import Foundation

class ParserJSON {

    static func parseJSON() -> TrackDataJSON? {
        let decoder = JSONDecoder()
        var trackDataJSONArray: TrackDataJSON?
        do {
            if let bundlePath = Bundle.main.path(forResource: "Data", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let resultData = try decoder.decode(TrackDataJSON.self, from: jsonData)
//                trackDataJSONArray.append(resultData)
//                return trackDataJSONArray
                trackDataJSONArray = resultData
                return trackDataJSONArray
            }
        } catch {
            print("error")
        }
        return nil
    }
}
