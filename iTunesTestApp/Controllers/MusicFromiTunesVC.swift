//
//  MusicFromiTunesVC.swift
//  iTunesTestApp
//
//  Created by admin on 12.11.2020.
//

import UIKit

class MusicFromiTunesVC: UIViewController {

    let defaultRequest = "music"
    var tracks = [Music]()
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        tableView.dataSource = self
        tableView.delegate = self
        searchField.delegate = self
        
        // Register table view cell class from nib
        let cellNib = UINib(nibName: "MusicFromiTunesCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: TABLE_VIEW_CELL_ID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Get default data fromiTunes
        getiTunesData(searchRequest: defaultRequest)
    }
    
    func getiTunesData(searchRequest: String) {
        RequestManager.getDataFromiTunes(searchString: searchRequest) { [weak self] (music) in
            DispatchQueue.main.async { [weak self] in
                self?.tracks = music
                self?.tableView.reloadData()
            }
        }
    }
    
    func getImages(imageView: UIImageView, imageURL: String) {
        RequestManager.getImageFromiTunes(imageURL: imageURL) { (image) in
            DispatchQueue.main.async { [weak self] in
                imageView.image = image
                for (index, track) in self!.tracks.enumerated() {
                    if track.albumImageURL == imageURL {
                        self?.tracks[index].albumImage = image
                        break
                    }
                }
            }
        }
    }
}

extension MusicFromiTunesVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: table view delegate and data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_ID, for: indexPath) as! MusicFromiTunesCell
        cell.titleLabel.text = tracks[indexPath.row].trackName
        cell.artistLabel.text = tracks[indexPath.row].artistName
        cell.genreLabel.text = tracks[indexPath.row].primaryGenreName
        getImages(imageView: cell.soundImage, imageURL: tracks[indexPath.row].albumImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let saveAction = UIContextualAction(style: .normal, title: "Save") { (action, index, completionHandler) in
            print("data saved")
        }
        saveAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [saveAction])
    }
}

extension MusicFromiTunesVC: UISearchBarDelegate {
    
    // MARK: search bar delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var request = ""
        searchBar.showsCancelButton = searchText.isEmpty ? false : true
        if searchText.isEmpty {
            request = defaultRequest
        } else {
            request = searchText
        }
        getiTunesData(searchRequest: request)
    }
}
