//
//  TrackListViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 11.10.2021.
//

import UIKit
import Kingfisher

class TrackListViewController: UIViewController {

    var presenter: TrackListPresenterProtocol?
    var configurator = TrackListConfigurator()
    private var trackTableView = UITableView()
    private var titleSegmentedControl: TitleSegmentedControl?
    private var titleViewRightBarButton: TitleViewRightBarButton?
    private var titleViewLeftBarButton: TitleViewLeftBarButton?
    private var trackOverviewHeight: CGFloat = 0

    private var clearSavedTracksData: UIAlertController {
        let alertController = UIAlertController(title: "Clear downloaded audio".localized, message: "Are you sure you want to delete downloaded audio?".localized, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes".localized, style: .destructive, handler: { (_: UIAlertAction) in
            self.presenter?.didClearButtonTap()
        }))
        alertController.addAction(UIAlertAction(title: "No".localized, style: .cancel))
        return alertController
    }

    private var toAuthorize: UIAlertController {
        let alertController = UIAlertController(title: "Exit".localized, message: "Are you sure you want to log out?".localized, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes".localized, style: .destructive, handler: { (_: UIAlertAction) in
            self.presenter?.didExitButtonTap()
        }))
        alertController.addAction(UIAlertAction(title: "No".localized, style: .cancel))
        return alertController
    }

    private var trackOverviewView: TrackOverviewView? {
        didSet {
            guard let trackOverviewView = trackOverviewView else {
                trackTableView.contentSize = CGSize(width: self.view.frame.width, height: trackTableView.contentSize.height - trackOverviewHeight)
                return
            }
            self.view.addSubview(trackOverviewView)
            trackOverviewView.backgroundColor = .systemBackground
            trackOverviewHeight = trackOverviewView.frame.height
            trackTableView.contentSize = CGSize(width: self.view.frame.width, height: trackTableView.contentSize.height + trackOverviewHeight)
            return
        }
    }

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
        titleViewLeftBarButton = TitleViewLeftBarButton()
        guard let segmentedControl = titleSegmentedControl,
              let rightBarButton = titleViewRightBarButton,
              let leftBarButton = titleViewLeftBarButton else { return }
        segmentedControl.delegate = self
        rightBarButton.delegate = self
        leftBarButton.delegate = self
        navigationItem.titleView = segmentedControl
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
    }

    private func setupTrackTableView() {
        trackTableView = UITableView(frame: self.view.frame, style: .plain)
        trackTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        trackTableView.backgroundColor = .clear
        trackTableView.showsVerticalScrollIndicator = false
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

    func presentClearTracksAlert() {
        self.present(clearSavedTracksData, animated: true, completion: nil)
    }
}

extension TrackListViewController: TitleViewLeftBarButtonDelegate {

    func presentExitAlert() {
        self.present(toAuthorize, animated: true, completion: nil)
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

    func trackOverviewPlayButtonDidTap(isPaused: Bool) {
        presenter?.changeTrackCondition(isPaused: isPaused)
    }
}

extension TrackListViewController: SingleTrackViewControllerDelegate {

    func playButtonDidTap(isPaused: Bool) {
        trackOverviewView?.updateTrackCondition(isPaused: isPaused)
        presenter?.changeTrackCondition(isPaused: isPaused)
    }
}

extension TrackListViewController: TrackListViewControllerProtocol {

    func reloadData() {
        self.trackTableView.reloadData()
    }

    func showTrackOverview(with data: TrackData) {
        guard let trackOverview = trackOverviewView else {
            trackOverviewView = TrackOverviewView(frame: self.view.frame, data: data)
            trackOverviewView?.delegate = self
            presenter?.trackOverviewDidCreate(with: data)
            return
        }
        if trackOverview.data == data {
            self.playButtonDidTap(isPaused: !trackOverview.isTrackPaused)
            return
        }
        closeTrack()
        showTrackOverview(with: data)
    }

    func closeTrackOverview(for data: TrackData) {
        guard let trackOverview = trackOverviewView else { return }
        if trackOverview.data == data {
            closeTrack()
        }
    }
}

extension TrackListViewController: TrackListTableViewCellDelegate {

    func didDataButtonTap(data: TrackData, isDataDownloaded: Bool, closure: @escaping () -> Void) {
        presenter?.didDataButtonTap(data: data, isDataDownloaded: isDataDownloaded, closure: closure)
    }
}
