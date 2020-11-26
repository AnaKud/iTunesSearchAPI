//
//  FirstScreenViewController.swift
//  iTunesAPISearch
//
//  Created by Анастасия Кудашева on 25.11.2020.
//

import UIKit

class FirstScreenViewController: UIViewController {
    @IBOutlet weak var searcher: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var networkManager = NetworkManager()
    var albumsArray = [AlbumModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searcher.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // prepere for usig data in Second Screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueForPassData" {
            if let destinationVC = segue.destination as? SecondScreenViewController {
                if let album = sender as? AlbumModel {
                    destinationVC.album = album
                    let index = albumsArray.firstIndex(where: {$0 === album})
                    let indexPath = IndexPath(row: index!, section: 0)
                    if let cell = collectionView.cellForItem(at: indexPath) as? FirstScreenCollectionViewCell {
                        destinationVC.image = cell.albumImageView.image
                    }
                }
            }
        }
    }
}

// MARK: - CollectionViewController extention

extension FirstScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as? FirstScreenCollectionViewCell {
            cell.updateCell(album: albumsArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    // pass data to Second Screen
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueForPassData", sender: albumsArray[indexPath.row])
        searcher.resignFirstResponder()
    }
}

// MARK: - Searchbar delegate

extension FirstScreenViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }
        networkManager.getAlbumData(searchRequest: searchBarText) { (albumSearchResult) in
            //albums will be sorted by alphabetically
            self.albumsArray = albumSearchResult.sorted(by: {$0.collectionName < $1.collectionName})
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
}
