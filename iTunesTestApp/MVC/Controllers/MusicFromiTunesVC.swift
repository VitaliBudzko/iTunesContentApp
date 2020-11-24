//
//  MusicFromiTunesVC.swift
//  iTunesTestApp
//
//  Created by admin on 12.11.2020.
//

import UIKit

class MusicFromiTunesVC: UIViewController {

    let defaultRequest = "music"
    var request = ""
    var tracks = [Music]()
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegates
        setDelegates()
        
        // Register table view cell class from nib
        setTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Get default data from iTunes
        requestiTunesData()
        
        // Get data from core data
        CoreDataManager.shared.storedMusic.removeAll()
        CoreDataManager.shared.fetchMusicData { (music) in
            CoreDataManager.shared.storedMusic = music
        }
    }
    
    private func setTableViewCell() {
        let cellNib = UINib(nibName: "MusicFromiTunesCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: TABLE_VIEW_CELL_ID)
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        searchField.delegate = self
    }
    
    private func requestiTunesData() {
        if request.isEmpty {
            request = defaultRequest
        }
        getiTunesData(searchRequest: request)
    }
    
    // MARK: - Get data from iTunes
    private func getiTunesData(searchRequest: String) {
        RequestManager.getDataFromiTunes(searchString: searchRequest) { [weak self] (music) in
            DispatchQueue.main.async { [weak self] in
                self?.tracks = music
                self?.tableView.reloadData()
            }
        }
    }
    
    private func getImages(imageView: UIImageView, imageURL: String) {
        RequestManager.getImageFromiTunes(imageURL: imageURL) { (image) in
            DispatchQueue.main.async { [weak self] in
                imageView.image = image
                for (index, track) in self!.tracks.enumerated() {
                    if track.albumImageURL == imageURL {
                        self?.tracks[index].albumImage = image
                    }
                }
            }
        }
    }
    
    private func makeSaveAlert(isSavedTrack: Bool) {
        var alertVC = UIAlertController()
        var okAction = UIAlertAction()
        if !isSavedTrack {
            alertVC = UIAlertController(title: "Saved!", message: "The track was saved!", preferredStyle: .alert)
            okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (action) in
                CoreDataManager.shared.storedMusic.removeAll()
                CoreDataManager.shared.fetchMusicData { (music) in
                    CoreDataManager.shared.storedMusic = music
                    self?.tableView.reloadData()
                }
            }
        } else {
            alertVC = UIAlertController(title: "You can't save the track!", message: "The track is already saved!", preferredStyle: .alert)
            okAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        }
        okAction.setValue(UIColor.green, forKey: "titleTextColor")
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
}

extension MusicFromiTunesVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view delegate and data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_VIEW_CELL_ID, for: indexPath) as! MusicFromiTunesCell
        cell.titleLabel.text = tracks[indexPath.row].trackName
        cell.artistLabel.text = tracks[indexPath.row].artistName
        cell.genreLabel.text = tracks[indexPath.row].primaryGenreName
        cell.setIsSaveLabelSettings(isSaved: tracks[indexPath.row].isSaved)
        getImages(imageView: cell.soundImage, imageURL: tracks[indexPath.row].albumImageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let saveAction = UIContextualAction(style: .normal, title: "Save") { [weak self] (action, index, completionHandler) in
            if self!.tracks[indexPath.row].isSaved {
                self?.makeSaveAlert(isSavedTrack: self!.tracks[indexPath.row].isSaved)
            } else {
                CoreDataManager.shared.saveMusicData(musicToSave: self!.tracks[indexPath.row]) { [weak self] (done) in
                    if done {
                        self?.makeSaveAlert(isSavedTrack: self!.tracks[indexPath.row].isSaved)
                        self!.tracks[indexPath.row].isSaved = true
                    }
                }
            }
        }
        saveAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [saveAction])
    }
}

extension MusicFromiTunesVC: UISearchBarDelegate {
    
    // MARK: - Search bar delegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = searchText.isEmpty ? false : true
        request = searchText
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestiTunesData()
        searchField.endEditing(true)
    }
}
