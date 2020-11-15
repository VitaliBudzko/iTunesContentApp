//
//  MusicFromiTunesVC.swift
//  iTunesTestApp
//
//  Created by admin on 12.11.2020.
//

import UIKit

class MusicFromiTunesVC: UIViewController {
    
    var musicCollection = [Music]()
    var musicItem = Music()
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        tableView.dataSource = self
        tableView.delegate = self
        searchField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            
        RequestManager.getDataFromiTunes(searchString: "music") { [weak self] (music) in
            self?.musicCollection.removeAll()
            for item in music {
                self?.musicItem = Music(trackName: item["trackName"] as! String, artistName: item["artistName"] as! String, primaryGenreName: item["primaryGenreName"] as! String, artworkUrl60: item["artworkUrl60"] as! String)
                self?.musicCollection.append(self!.musicItem)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension MusicFromiTunesVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: table view delegate and data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_ID, for: indexPath) as! MusicFromiTunesTableViewCell
        cell.titleLabel.text = musicCollection[indexPath.row].trackName
        cell.artistLabel.text = musicCollection[indexPath.row].artistName
        cell.genreLabel.text = musicCollection[indexPath.row].primaryGenreName
        RequestManager.getImageFromiTunes(imageURL: musicCollection[indexPath.row].artworkUrl60) { (image) in
            DispatchQueue.main.async {
                cell.soundImage.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
 */
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: <#T##UIContextualAction.Style#>, title: <#T##String?#>, handler: <#T##UIContextualAction.Handler##UIContextualAction.Handler##(UIContextualAction, UIView, @escaping (Bool) -> Void) -> Void#>)
        let saveAction = UIContextualAction(style: <#T##UIContextualAction.Style#>, title: <#T##String?#>, handler: <#T##UIContextualAction.Handler##UIContextualAction.Handler##(UIContextualAction, UIView, @escaping (Bool) -> Void) -> Void#>)
        return UISwipeActionsConfiguration(actions: [deleteAction, saveAction])
    }
    
}

extension MusicFromiTunesVC: UISearchBarDelegate {
    
    // MARK: search bar delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = searchText.isEmpty ? false : true
        RequestManager.getDataFromiTunes(searchString: searchText) { [weak self] (music) in
            self?.musicCollection.removeAll()
            for item in music {
                self?.musicItem = Music(trackName: item["trackName"] as! String, artistName: item["artistName"] as! String, primaryGenreName: item["primaryGenreName"] as! String, artworkUrl60: item["artworkUrl60"] as! String)
                self?.musicCollection.append(self!.musicItem)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
