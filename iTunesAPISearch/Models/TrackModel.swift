//
//  TrackModel.swift
//  iTunesAPISearch
//
//  Created by Анастасия Кудашева on 26.11.2020.
//

import Foundation

class TrackModel {
    let trackNumber: Int
    let trackName: String
    let trackTimeMillis: Int
    
    init(trackNumber: Int, trackName: String, trackTimeMillis: Int) {
        self.trackNumber = trackNumber
        self.trackName = trackName
        self.trackTimeMillis = trackTimeMillis
    }
}
