//
//  TrackOlayer.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 18.11.2021.
//

import AVFoundation

class TrackPlayerManager {

    static let shared = TrackPlayerManager()

    public var onlinePlayer: AVPlayer?
    private var offlinePlayer: AVAudioPlayer?
    private var audioSession = AVAudioSession.sharedInstance()
    private var audioObserver = AudioObserver.shared
    private var displayLink: CADisplayLink?

    init() {
        do {
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(.playback)
            try audioSession.setMode(.moviePlayback)
            AudioObserver.shared.audioPlayer = self
        } catch {
            print("error")
        }
    }

    deinit {
        do {
            try audioSession.setActive(false)
        } catch {
            print("error")
        }
    }

    func startOnlineTrack(url: URL) {
        if url.absoluteString.count == 0 && onlinePlayer != nil {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        onlinePlayer = AVPlayer(playerItem: playerItem)
        onlinePlayer?.play()
        addStopObserverForOnlineTrack()
        onlinePlayer?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.0001, preferredTimescale: 60000), queue: DispatchQueue.main, using: { time in
            self.audioObserver.trackCurrentTimeDidChange(newValue: Float(time.seconds))
        })
    }

    func startDownloadedTrack(url: URL) {
        do {
            offlinePlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = offlinePlayer else { return }
            player.play()
            player.numberOfLoops = Int(FP_INFINITE)
            displayLink = CADisplayLink(target: self, selector: #selector(updateTrackCurrentTime))
            displayLink?.add(to: .current, forMode: .common)
        } catch {
            print("error")
        }
    }

    func play() {
        guard let player = onlinePlayer else {
            if let audioPlayer = offlinePlayer, let displayLink = displayLink {
                displayLink.isPaused = false
                audioPlayer.play()
            }
            return
        }
        player.play()
    }

    func pause() {
        guard let player = onlinePlayer else {
            if let audioPlayer = offlinePlayer, let displayLink = displayLink {
                displayLink.isPaused = true
                audioPlayer.pause()
            }
            return
        }
        player.pause()
    }

    func closeTrack() {
        displayLink = nil
        onlinePlayer = nil
        offlinePlayer = nil
    }

    func setTrackTime(time: Float) {
        guard let offlinePlayer = offlinePlayer else {
            guard let onlinePlayer = self.onlinePlayer else {
                return
            }
            onlinePlayer.currentItem?.seek(to: CMTimeMakeWithSeconds(Float64(time), preferredTimescale: 60000), completionHandler: nil)
            return
        }
        offlinePlayer.currentTime = TimeInterval(Double(time))
    }

    private func addStopObserverForOnlineTrack() {
        NotificationCenter.default.addObserver(self, selector: #selector(restartOnlineTrack), name: .AVPlayerItemDidPlayToEndTime, object: onlinePlayer?.currentItem)
    }

    @objc private func restartOnlineTrack() {
        guard let onlinePlayer = onlinePlayer else {
            return
        }
        onlinePlayer.currentItem?.seek(to: CMTimeMakeWithSeconds(0, preferredTimescale: 60000), completionHandler: nil)
        onlinePlayer.play()
    }

    @objc private func updateTrackCurrentTime() {
        guard let offlinePlayer = offlinePlayer else {
            return
        }
        audioObserver.trackCurrentTimeDidChange(newValue: Float(offlinePlayer.currentTime))
    }
}

extension TrackPlayerManager: ObservableAudioObjectProtocol {

    func observableValueDidChange(newValue: Float) {
        setTrackTime(time: newValue)
    }
}
