//
//  MusicFromiTunesCell.swift
//  iTunesTestApp
//
//  Created by admin on 17.11.2020.
//

import UIKit

class MusicFromiTunesCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var isSavedLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        soundImage.image = nil
        titleLabel.text = ""
        artistLabel.text = ""
        genreLabel.text = ""
    }
    
    func setIsSaveLabelSettings(isSaved: Bool) {
        if isSaved {
            isSavedLabel.textColor = .green
            isSavedLabel.text = "SAVED"
        } else {
            isSavedLabel.textColor = .red
            isSavedLabel.text = "NOT SAVED"
        }
    }
}
