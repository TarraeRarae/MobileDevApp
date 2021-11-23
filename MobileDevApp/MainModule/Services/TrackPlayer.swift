//
//  TrackOlayer.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import AVFoundation

class TrackPlayer {

    private var onlinePlayer: AVPlayer?
    private var offlinePlayer: AVAudioPlayer?

    func startOnlineTrack(url: URL) {
        if url.absoluteString.count == 0 {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        onlinePlayer = AVPlayer(playerItem: playerItem)
        onlinePlayer?.play()
    }

    func startDownloadedTrack(url: URL) {
        print(url)
        do {
            offlinePlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = offlinePlayer else { return }
            player.play()
        } catch {
            print("error")
        }
    }

    func play() {
        guard let player = onlinePlayer else {
            if let audioPlayer = offlinePlayer {
                audioPlayer.play()
            }
            return
        }
        player.play()
    }

    func pause() {
        guard let player = onlinePlayer else {
            if let audioPlayer = offlinePlayer {
                audioPlayer.pause()
            }
            return
        }
        player.pause()
    }

    func closeTrack() {
        onlinePlayer = nil
        offlinePlayer = nil
    }
}
