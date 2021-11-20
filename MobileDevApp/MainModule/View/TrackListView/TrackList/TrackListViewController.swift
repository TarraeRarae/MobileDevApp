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
                self.view.insertSubview(trackOverviewView, aboveSubview: trackTableView)
                trackTableView.contentSize = CGSize(width: self.view.frame.width, height: trackTableView.contentSize.height + trackOverviewView.frame.height * 0.7)
            }
        }
    }

    var presenter: TrackListPresenterProtocol?
    var configurator = TrackListConfigurator()

	override func viewDidLoad() {
		super.viewDidLoad()
        configurator.configure(view: self)
        self.view.backgroundColor = .systemBackground
		navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        trackListTitleView = TrackListTitleView(frame: self.view.frame)
        guard let trackListTitleView = trackListTitleView else { fatalError() }
        trackListTitleView.delegate = self
        navigationItem.titleView = trackListTitleView
        setupTrackTableView()
        if let presenter = presenter {
            presenter.viewDidLoad()
        }
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
        guard let presenter = presenter else { return 0 }
        return presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackCellViewController.Constant.cellID, for: indexPath) as? TrackCellViewController, let presenter = presenter else { fatalError() }
        cell.cellData = presenter.getCellData(for: indexPath)
        cell.delegate = self
        return cell
    }
}

extension TrackListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TrackCellViewController.Constant.rowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let presenter = presenter else { return }
        presenter.didCellTap(at: indexPath)
    }
}

extension TrackListViewController: TrackListTitleViewDelegate {

    func presentMoreMenu(alertController: UIAlertController) {
        alertController.addAction(UIAlertAction(title: "Exit".localized, style: .destructive, handler: { (_: UIAlertAction) in
            self.show(AuthenticationViewController(), sender: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension TrackListViewController: TrackOverviewDelegate {

    func presentSingleTrackView(data: TrackData, isPaused: Bool) {
        let singleTrackViewController = SingleTrackViewController()
        singleTrackViewController.delegate = self
        singleTrackViewController.data = data
        singleTrackViewController.isPaused = isPaused
        present(singleTrackViewController, animated: true, completion: nil)
    }

    func closeTrack() {
        if let trackOverviewView = trackOverviewView {
            trackOverviewView.removeFromSuperview()
            trackTableView.frame = self.view.frame
            self.trackOverviewView = nil
            self.presenter?.closeTrack()
        }
    }

    func playButtonTaped(isPaused: Bool) {
        presenter?.changeTrackCondition(isPaused: isPaused)
    }
}

extension TrackListViewController: SingleTrackViewControllerDelegate {

    func playButtonTapped(isPaused: Bool) {
        trackOverviewView?.updateTrackCondition(isPaused: isPaused)
        presenter?.changeTrackCondition(isPaused: isPaused)
    }
}

extension TrackListViewController: TrackListViewControllerProtocol {

    func reloadData() {
        trackTableView.reloadData()
    }

    func showTrackOverview(with data: TrackData) {
        guard let trackOverview = trackOverviewView, let overviewData = trackOverview.data else {
            trackOverviewView = TrackOverviewView(frame: self.view.frame, data: data)
            trackOverviewView?.delegate = self
            return
        }
        if overviewData == data {
            self.playButtonTapped(isPaused: !trackOverview.isTrackPaused)
            return
        }
        closeTrack()
        showTrackOverview(with: data)
    }
}

extension TrackListViewController: TrackListTableViewCellDelegate {

    func downloadButtonTapped(data: TrackData) {
        <#code#>
    }
}
