//
//  NetworkManager.swift
//  iTunesAPISearch
//
//  Created by Анастасия Кудашева on 25.11.2020.
//

import Foundation

// MARK: - two functions for fetch and parse json data
class NetworkManager {
    
    func getAlbumData(searchRequest: String, completion: @escaping ([AlbumModel])->()) {
        var albums = [AlbumModel]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term=\(searchString)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let albumsResults = json["results"] as? NSArray {
                        for album in albumsResults {
                            if let albumInfo = album as? [String: AnyObject] {
                                guard let artistName = albumInfo["artistName"] as? String else { return }
                                guard let artworkUrl100 = albumInfo["artworkUrl100"] as? String else { return }
                                guard let collectionId = albumInfo["collectionId"] as? Int else { return }
                                guard let collectionName = albumInfo["collectionName"] as? String else { return }
                                guard let country = albumInfo["country"] as? String else { return }
                                guard let trackCount = albumInfo["trackCount"] as? Int else { return }
                                guard let releaseDate = albumInfo["releaseDate"] as? String else { return }
                                guard let primaryGenreName = albumInfo["primaryGenreName"] as? String else { return }
                                guard let copyright = albumInfo["copyright"] as? String else { return }
                                let albumInstance = AlbumModel(artistName: artistName, artworkUrl100: artworkUrl100, collectionId: collectionId, collectionName: collectionName, country: country, trackCount: trackCount, releaseDate: releaseDate, copyright: copyright, primaryGenreName: primaryGenreName)
                                albums.append(albumInstance)
                            }
                        }
                        completion(albums)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
    
    func getAlbumTracks (collectionId: Int, completion: @escaping ([TrackModel]) -> ()) {
        var tracksArray = [TrackModel]()
        let url = URL(string: "https://itunes.apple.com/lookup?entity=song&id=\(collectionId)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let trackResults = json["results"] as? NSArray {
                        for song in trackResults {
                            if trackResults.index(of: song) != 0 {
                                if let songInfo = song as? [String: AnyObject] {
                                    guard let trackName = songInfo["trackName"] as? String else { return }
                                    guard let trackNumber = songInfo["trackNumber"] as? Int else { return }
                                    guard let trackTimeMillis = songInfo["trackTimeMillis"] as? Int else { return }
                                    let track = TrackModel(trackNumber: trackNumber, trackName: trackName, trackTimeMillis: trackTimeMillis)
                                    tracksArray.append(track)
                                }
                            }
                        }
                        completion(tracksArray)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            if error != nil {
                print(error!.localizedDescription)
            }
        }.resume()
    }
}

