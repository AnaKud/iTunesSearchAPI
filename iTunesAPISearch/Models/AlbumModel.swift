//
//  AlbumModel.swift
//  iTunesAPISearch
//
//  Created by Анастасия Кудашева on 25.11.2020.
//

import Foundation

class AlbumModel {
    let artistName: String
    let artworkUrl100: String
    let collectionId: Int
    let collectionName: String
    let country: String
    let trackCount: Int
    let releaseDate: String
    let copyright: String
    let primaryGenreName: String
    
    init(artistName: String, artworkUrl100: String, collectionId: Int, collectionName: String, country: String, trackCount: Int, releaseDate: String, copyright: String, primaryGenreName: String) {
        self.artistName = artistName
        self.artworkUrl100 = artworkUrl100
        self.collectionId = collectionId
        self.collectionName = collectionName
        self.country = country
        self.trackCount = trackCount
        self.releaseDate = releaseDate
        self.copyright = copyright
        self.primaryGenreName = primaryGenreName
    }
    
}
