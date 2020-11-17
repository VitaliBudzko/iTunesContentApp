//
//  StoredMusicVC.swift
//  iTunesTestApp
//
//  Created by admin on 17.11.2020.
//

import UIKit

class StoredMusicVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register table view cell class from nib
        let cellNib = UINib(nibName: "MusicFromiTunesCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: TABLE_VIEW_CELL_ID)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_ID, for: indexPath) as! MusicFromiTunesCell
        //cell.titleLabel.text = tracks[indexPath.row].trackName
        //cell.artistLabel.text = tracks[indexPath.row].artistName
        //cell.genreLabel.text = tracks[indexPath.row].primaryGenreName
        //getImages(imageView: cell.soundImage, imageURL: tracks[indexPath.row].albumImageURL)
        //return cell
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, index, completionHandler) in
            print("data deleted")
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
