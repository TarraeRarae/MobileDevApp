//
//  TrackOlayer.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import AVFoundation

class TrackPlayer {

    var player: AVPlayer?

    func startTrack(url: URL) {
        if url.absoluteString.count == 0 {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }

    func play() {
        guard let player = player else { return }
        player.play()
    }

    func pause() {
        guard let player = player else { return }
        player.pause()
    }

    func closeTrack() {
        player = nil
    }
}
