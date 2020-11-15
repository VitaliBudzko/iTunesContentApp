//
//  MusicFromiTunesTableViewCell.swift
//  iTunesTestApp
//
//  Created by admin on 12.11.2020.
//

import UIKit

class MusicFromiTunesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
