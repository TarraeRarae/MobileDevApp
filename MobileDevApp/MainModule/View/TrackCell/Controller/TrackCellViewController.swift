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
        static let rowHeight: CGFloat = 80
    }

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var dataButton: UIButton!

    weak var delegate: TrackListTableViewCellDelegate?
    var isDataDownloaded: Bool? {
        willSet(isDataSaved) {
            guard let isDataSaved = isDataSaved else { return }
            if isDataSaved {
                self.dataButton.setImage(UIImage(systemName: MainHelper.Constant.deleteButtonImageName.rawValue), for: .normal)
                return
            }
            self.dataButton.setImage(UIImage(systemName: MainHelper.Constant.downloadButtonImageName.rawValue), for: .normal)
        }
    }
    var cellData: TrackData? {
        willSet(cellData) {
            guard let cellData = cellData else { return }
            self.trackNameLabel.text = cellData.name
            self.singerNameLabel.text = cellData.artists[0].name
//            if let storedImagesData = cellData.storedImagesData {
//                self.trackImageView.image = UIImage(data: storedImagesData[0])
//                return
//            }
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
        trackImageView.image = UIImage(named: MainHelper.Constant.placeholderImageName.rawValue)
        trackNameLabel.text = ""
        singerNameLabel.text = ""
    }

    @IBAction func didDataButtonTap(_ sender: UIButton!) {
        guard let cellData = cellData, let isDataSaved = isDataDownloaded else { return }
        self.isDataDownloaded = !isDataSaved
        delegate?.didDataButtonTap(data: cellData, isDataDownloaded: isDataSaved)
    }
}
