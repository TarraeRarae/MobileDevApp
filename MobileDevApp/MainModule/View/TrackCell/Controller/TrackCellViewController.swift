//
//  TrackCellViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import UIKit
import Kingfisher

class TrackCellViewController: UITableViewCell {

    struct Constant {
        static let cellID = "TrackCellID"
        static let nibName = "TrackCell"
        static let rowHeight: CGFloat = 65
    }

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var dataButton: UIButton!

    private var progressView: ProgressView?
    weak var delegate: TrackListTableViewCellDelegate?
    var isDataDownloaded: Bool? {
        willSet(isDataSaved) {
            guard let isDataSaved = isDataSaved else { return }
            if isDataSaved {
                self.dataButton.setImage(UIImage(systemName: MainHelper.StringConstant.deleteButtonImageName.rawValue), for: .normal)
                return
            }
            self.dataButton.setImage(UIImage(systemName: MainHelper.StringConstant.downloadButtonImageName.rawValue), for: .normal)
        }
    }
    var cellData: TrackData? {
        willSet(cellData) {
            guard let cellData = cellData else { return }
            self.trackNameLabel.text = cellData.name
            self.singerNameLabel.text = cellData.artists[0].name
            guard cellData.imagesURLs.count != 0, let imageUrl = URL(string: cellData.imagesURLs[0]) else { return }
            self.trackImageView.kf.setImage(with: imageUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = UIImage(named: MainHelper.StringConstant.placeholderImageName.rawValue)
        trackNameLabel.text = ""
        singerNameLabel.text = ""
        dataButton.isEnabled = true
        if let progressView = progressView {
            progressView.removeFromSuperview()
        }
        progressView = nil
    }

    @IBAction func didDataButtonTap(_ sender: UIButton!) {
        guard let cellData = cellData, let isDataSaved = isDataDownloaded else { return }
        if !isDataSaved {
            progressView = ProgressView(frame: CGRect(x: dataButton.frame.width * 0.5 - 10, y: dataButton.frame.height * 0.5 - 10, width: 20, height: 20), colors: [.systemRed], lineWidth: 2)
            dataButton.isEnabled = false
            dataButton.setImage(nil, for: .normal)
            if let progressView = progressView {
                dataButton.addSubview(progressView)
            }
            progressView?.animateStroke()
            delegate?.didDataButtonTap(data: cellData, isDataDownloaded: isDataSaved) {
                [weak self] in
                self?.progressView?.removeFromSuperview()
                self?.progressView = nil
                self?.isDataDownloaded = !isDataSaved
                self?.dataButton.isEnabled = true
            }
        } else {
            self.delegate?.didDataButtonTap(data: cellData, isDataDownloaded: isDataSaved) {
                [weak self] in
                self?.progressView = nil
                self?.isDataDownloaded = !isDataSaved
            }
        }
    }
}
