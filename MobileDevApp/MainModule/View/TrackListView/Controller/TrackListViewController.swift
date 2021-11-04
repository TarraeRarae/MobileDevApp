//
//  TrackListViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 11.10.2021.
//

import UIKit

class TrackListViewController: UIViewController {

    private var trackTableView = UITableView()
    private var trackListTitleView: TrackListTitleView?
    private var trackOverviewView: TrackOverviewView? {
        didSet {
            if let trackOverviewView = trackOverviewView {
                self.view.addSubview(trackOverviewView)
                trackTableView.frame = CGRect(x: 0, y: trackOverviewView.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - trackOverviewView.frame.height)
                trackTableView.contentSize = CGSize(width: self.view.frame.width, height: trackTableView.contentSize.height + trackOverviewView.frame.height * 2)
            }
        }
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        self.view.backgroundColor = .white
		navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        trackListTitleView = TrackListTitleView(frame: self.view.frame)
        guard let trackListTitleView = trackListTitleView else { fatalError() }
        trackListTitleView.delegate = self
        navigationItem.titleView = trackListTitleView
        setupTrackTableView()
	}

    private func setupTrackTableView() {
        trackTableView = UITableView(frame: self.view.frame, style: .plain)
        trackTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        trackTableView.register(UINib(nibName: TrackCellViewController.Constant.nibName, bundle: nil), forCellReuseIdentifier: TrackCellViewController.Constant.cellID)
        trackTableView.dataSource = self
        trackTableView.delegate = self
        self.view.addSubview(trackTableView)
    }
}

extension TrackListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackCellViewController.Constant.cellID, for: indexPath) as? TrackCellViewController else { fatalError() }
        return cell
    }
}

extension TrackListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TrackCellViewController.Constant.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let trackOverviewView = trackOverviewView {
            trackOverviewView.removeFromSuperview()
        }
        trackOverviewView = TrackOverviewView(frame: self.view.frame)
        trackOverviewView?.delegate = self
    }
}

extension TrackListViewController: TrackListTitleViewDelegate {

    func presentMoreMenu(alertController: UIAlertController) {
        alertController.addAction(UIAlertAction(title: "Exit", style: .destructive, handler: { (_: UIAlertAction) in
            self.show(AuthenticationViewController(), sender: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension TrackListViewController: TrackOverviewProtocol {

    func presentSingleTrackView() {
        present(SingleTrackViewController(), animated: true, completion: nil)
    }

    func closeTrack() {
        if let trackOverviewView = trackOverviewView {
            trackOverviewView.removeFromSuperview()
            trackTableView.frame = self.view.frame
        }
    }
}
