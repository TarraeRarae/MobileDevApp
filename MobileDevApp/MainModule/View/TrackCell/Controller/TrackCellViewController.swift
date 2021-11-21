//
//  TrackCellViewController.swift
//  MobileDevApp
//
//  Created by TarraeRarae on 03.11.2021.
//

import UIKit

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
                self.dataButton.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
                return
            }
            self.dataButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        }
    }
    var cellData: TrackData? {
        willSet(cellData) {
            guard let cellData = cellData else { return }
            self.trackNameLabel.text = cellData.name
            self.singerNameLabel.text = cellData.artists[0].name
            guard cellData.images.count != 0 else { return }
            self.trackImageView.image = UIImage(data: cellData.images[0])
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = UIImage(named: MainHelper.Constant.placeholderImageName)
        trackNameLabel.text = ""
        singerNameLabel.text = ""
    }

    @IBAction func didDataButtonTap(_ sender: UIButton!) {
        guard let cellData = cellData, let isDataSaved = isDataDownloaded else { return }
        self.isDataDownloaded = !isDataSaved
        delegate?.didDataButtonTap(data: cellData, isDataDownloaded: isDataSaved)
    }
}
