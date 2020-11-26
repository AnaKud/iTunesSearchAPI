//
//  SecondScreenTableViewCell.swift
//  iTunesAPISearch
//
//  Created by Анастасия Кудашева on 25.11.2020.
//

import UIKit

// MARK: - Class for using reuseble outlets in Table View Cells

class SecondScreenTableViewCell: UITableViewCell {
    // 
    @IBOutlet weak var trackNumber: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(tracks: TrackModel) {
        trackNumber.text = String(tracks.trackNumber)
        trackName.text = tracks.trackName
        
        // Calculate current track time
        let trackMinutes = tracks.trackTimeMillis / 60000
        let trackSeconds = tracks.trackTimeMillis / 1000 - trackMinutes * 60
        let trackTimeCurrent = String("\(trackMinutes):\(trackSeconds)")
        trackTime.text = trackTimeCurrent
    }
}
