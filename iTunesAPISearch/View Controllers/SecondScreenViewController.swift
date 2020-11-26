//
//  SecondScreenViewController.swift
//  iTunesAPISearch
//
//  Created by Анастасия Кудашева on 25.11.2020.
//

import UIKit

class SecondScreenViewController: UIViewController {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var musicStyleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    @IBOutlet weak var copyrightsLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var networkManager = NetworkManager()
    var album: AlbumModel!
    var image: UIImage!
    var tracksArray = [TrackModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateOutlets()
        loadTracks()
    }
    // album's information
    func updateOutlets() {
        albumImageView.image = image
        artistLabel.text = album.artistName
        albumLabel.text = album.collectionName
        countryLabel.text = album.country
        musicStyleLabel.text = album.primaryGenreName
        releaseDateLabel.text = String(album.releaseDate.prefix(10))
        trackCountLabel.text = String(album.trackCount)
        copyrightsLabel.text = album.copyright
    }
    // list of song
    func loadTracks() {
        networkManager.getAlbumTracks(collectionId: album.collectionId) { (tracks) in
            self.tracksArray = tracks
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView Extension
extension SecondScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as? SecondScreenTableViewCell {
            cell.updateCell(tracks: tracksArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
