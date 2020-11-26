//
//  FirstScreenCollectionViewCell.swift
//  iTunesAPISearch
//
//  Created by Анастасия Кудашева on 25.11.2020.
//

import UIKit

// MARK: - Class for using reuseble outlets in Collection View Cells

class FirstScreenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    func updateCell(album: AlbumModel) {
        albumNameLabel.text = album.collectionName
        
        guard let imageUrl = URL(string: album.artworkUrl100) else { return }
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    self.albumImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
}
