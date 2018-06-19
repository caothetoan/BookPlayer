//
//  BookCellView.swift
//  BookPlayer
//
//  Created by Florian Pichler on 12.04.18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//

import UIKit

enum PlaybackState {
    case playing
    case paused
    case stopped
}

class BookCellView: UITableViewCell {
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var progressTrailing: NSLayoutConstraint!
    @IBOutlet private weak var progressView: ItemProgress!
    @IBOutlet private weak var artworkButton: UIButton!

    var onArtworkTap: (() -> Void)?

    var artwork: UIImage? {
        get {
            return self.artworkImageView.image
        }
        set {
            self.artworkImageView.layer.cornerRadius = 4.0
            self.artworkImageView.layer.masksToBounds = true

            self.artworkImageView.image = newValue
        }
    }

    var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }

    var subtitle: String? {
        get {
            return self.subtitleLabel.text
        }
        set {
            self.subtitleLabel.text = newValue
        }
    }

    var progress: Double {
        get {
            return self.progressView.value
        }
        set {
            self.progressView.value = newValue
        }
    }

    var isPlaylist: Bool = false {
        didSet {
            if self.isPlaylist {
                self.accessoryType = .disclosureIndicator

                self.progressTrailing.constant = 0
            } else {
                self.accessoryType = .none

                self.progressTrailing.constant = 16.0
            }
        }
    }

    var playbackState: PlaybackState = PlaybackState.stopped {
        didSet {
            switch playbackState {
                case .playing:
                    self.artworkButton.backgroundColor = UIColor.tintColor.withAlpha(newAlpha: 0.3)
                    self.artworkButton.setImage(#imageLiteral(resourceName: "playStatePlaying"), for: .normal)
                    self.titleLabel.textColor = UIColor.tintColor
                case .paused:
                    self.artworkButton.backgroundColor = UIColor.tintColor.withAlpha(newAlpha: 0.3)
                    self.artworkButton.setImage(#imageLiteral(resourceName: "playStatePaused"), for: .normal)
                    self.titleLabel.textColor = UIColor.tintColor
                default:
                    self.artworkButton.backgroundColor = UIColor.clear
                    self.artworkButton.setImage(nil, for: .normal)
                    self.titleLabel.textColor = UIColor.textColor
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setup()
    }

    private func setup() {
        self.accessoryType = .none
        self.selectionStyle = .none
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        self.artworkImageView.layer.cornerRadius = 3.0
        self.artworkImageView.layer.masksToBounds = true

        self.artworkButton.layer.cornerRadius = 3.0
        self.artworkButton.layer.masksToBounds = true
    }

    @IBAction func artworkButtonTapped(_ sender: Any) {
        self.onArtworkTap?()
    }
}
