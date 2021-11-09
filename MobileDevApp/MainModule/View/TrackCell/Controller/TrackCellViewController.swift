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

    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!

    var viewModel: TrackListCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            self.trackNameLabel.text = viewModel.name
            self.singerNameLabel.text = viewModel.artistNames[0]
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        trackImage.image = UIImage(named: MainHelper.Constant.placeholderImageName)
        trackNameLabel.text = ""
        singerNameLabel.text = ""
    }
}
