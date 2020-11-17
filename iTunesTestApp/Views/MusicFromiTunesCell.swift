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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCellSettings()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        soundImage.image = nil
        titleLabel.text = ""
        artistLabel.text = ""
        genreLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellSettings() {
        soundImage.layer.cornerRadius = 10
    }
}
