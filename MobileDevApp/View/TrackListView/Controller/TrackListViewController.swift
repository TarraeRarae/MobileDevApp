//
//  TrackListViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 11.10.2021.
//

import UIKit

class TrackListViewController: UIViewController {

    private var trackListView: TrackListView?

	override func viewDidLoad() {
		super.viewDidLoad()
        trackListView = TrackListView(frame: view.frame)
        view.backgroundColor = .white
        if let trackListView = trackListView {
            view.addSubview(trackListView)
        }
		navigationController?.navigationBar.isHidden = false
	}
}
