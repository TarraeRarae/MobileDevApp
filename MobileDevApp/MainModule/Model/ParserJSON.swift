//
//  ParserJSON.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 08.11.2021.
//

import Foundation

class ParserJSON {

    static func parseJSON(data: Data) -> TrackDataJSON? {
        let decoder = JSONDecoder()
        var dataJSON: TrackDataJSON?
        do {
            dataJSON = try decoder.decode(TrackDataJSON.self, from: data)
        } catch {
            dataJSON = nil
        }
        return dataJSON
    }
}
