//
//  TimeData.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 26.11.2021.
//

import Foundation

struct TimeData {
    var hours: Int
    var minutes: Int
    var seconds: Int

    init(milliseconds: Int64) {
        let seconds = milliseconds / 1000
        self.seconds = Int(seconds % 60)
        let minutes = seconds / 60
        self.minutes = Int(minutes % 60)
        self.hours = Int(minutes / 60)
    }

    public func getTimeInSeconds() -> Int64 {
        return Int64(hours * 3600 + minutes * 60 + seconds)
    }
}
