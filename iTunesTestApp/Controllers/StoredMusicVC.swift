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
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    func makeDeleteAlert(musicToDelete: Int) {
        let alertVC = UIAlertController(title: "Delete the track!", message: "Do you want to delete the track?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { [weak self] (action) in
            CoreDataManager.shared.deleteMusicData(musicToDelete: musicToDelete)
            CoreDataManager.shared.storedMusic.removeAll()
            CoreDataManager.shared.fetchMusicData { [weak self] (music) in
                CoreDataManager.shared.storedMusic = music
                self?.tableView.reloadData()
            }
        }
        cancelAction.setValue(UIColor.green, forKey: "titleTextColor")
        deleteAction.setValue(UIColor.red, forKey: "titleTextColor")
        alertVC.addAction(cancelAction)
        alertVC.addAction(deleteAction)
        present(alertVC, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.storedMusic.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_ID, for: indexPath) as! MusicFromiTunesCell
        cell.titleLabel.text = CoreDataManager.shared.storedMusic[indexPath.row].trackName
        cell.artistLabel.text = CoreDataManager.shared.storedMusic[indexPath.row].artistName
        cell.genreLabel.text = CoreDataManager.shared.storedMusic[indexPath.row].primaryGenreName
        cell.imageView?.image = UIImage(data: CoreDataManager.shared.storedMusic[indexPath.row].albumImage!, scale: 0.6)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, index, completionHandler) in
            self?.makeDeleteAlert(musicToDelete: indexPath.row)
            print("data deleted")
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
