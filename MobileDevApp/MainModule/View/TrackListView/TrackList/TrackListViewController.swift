//
//  TrackListViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 11.10.2021.
//

import UIKit

class TrackListViewController: UIViewController {

    private var trackTableView = UITableView()
    private var titleSegmentedControl: TitleSegmentedControl?
    private var titleViewRightBarButton: TitleViewRightBarButton?
    private var trackOverviewHeight: CGFloat = 0
    private var moreMenu: UIAlertController {
        let alertController = UIAlertController(title: "More".localized, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Exit".localized, style: .destructive, handler: { (_: UIAlertAction) in
            self.presenter?.didExitButtonTap()
        }))
        alertController.addAction(UIAlertAction(title: "Clear downloaded tracks".localized, style: .default, handler: { (_: UIAlertAction) in
            self.presenter?.didClearButtonTap()
        }))
        return alertController
    }

    private var trackOverviewView: TrackOverviewView? {
        didSet {
            guard let trackOverviewView = trackOverviewView else {
                trackTableView.contentSize = CGSize(width: self.view.frame.width, height: trackTableView.contentSize.height - trackOverviewHeight)
                return
            }
            self.view.insertSubview(trackOverviewView, aboveSubview: trackTableView)
            trackOverviewHeight = trackOverviewView.frame.height
            trackTableView.contentSize = CGSize(width: self.view.frame.width, height: trackTableView.contentSize.height + trackOverviewHeight)
            return
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
        customizeNavigationBar()
        setupTrackTableView()
        if let presenter = presenter, let segmentedControl = titleSegmentedControl {
            presenter.viewDidLoad(for: segmentedControl.selectedSegmentIndex)
        }
	}

    private func customizeNavigationBar() {
        titleSegmentedControl = TitleSegmentedControl(frame: self.view.frame)
        titleViewRightBarButton = TitleViewRightBarButton()
        guard let segmentedControl = titleSegmentedControl, let rightBarButton = titleViewRightBarButton else { return }
        segmentedControl.delegate = self
        rightBarButton.delegate = self
        navigationItem.titleView = segmentedControl
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func setupTrackTableView() {
        trackTableView = UITableView(frame: self.view.frame, style: .plain)
        trackTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        trackTableView.backgroundColor = .clear
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
        cell.isDataDownloaded = presenter.isTrackDownloaded(for: indexPath)
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

extension TrackListViewController: TitleSegmentedControlDelegate {

    func updateTableView(indexOfSection index: Int) {
        presenter?.viewDidLoad(for: index)
    }
}

extension TrackListViewController: TitleViewRightBarButtonDelegate {

    func presentMoreMenu() {
        self.present(moreMenu, animated: true, completion: nil)
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
        self.trackTableView.reloadData()
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

    func closeTrackOverview(for data: TrackData) {
        guard let trackOverview = trackOverviewView, let trackOverviewData = trackOverview.data else { return }
        if trackOverviewData == data {
            closeTrack()
        }
    }
}

extension TrackListViewController: TrackListTableViewCellDelegate {

    func didDataButtonTap(data: TrackData, isDataDownloaded: Bool) {
        presenter?.didDataButtonTap(data: data, isDataDownloaded: isDataDownloaded)
    }
}
