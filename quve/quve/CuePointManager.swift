//
//  CuePointManager.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation
import UIKit

final class CuePointManager {
    static let sharedInstance = CuePointManager()
    
    var tracks: [Track]
    var mediaPlayerInformationProvider: MediaPlayerInformationProvider
    
    private init(){
        tracks = [Track]()
        mediaPlayerInformationProvider = MediaPlayerInformationProvider()
    }
    
    func addCuePoint(){
        if let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
            let title = nowPlayingItem.title{
                let track = Track(title: title, artistName: nowPlayingItem.artist ?? "")
                track.cuePoints.append(mediaPlayerInformationProvider.cuePointForNowPlayingTrack())
                track.artwork = nowPlayingItem.artwork?.imageWithSize(CGSize(width: 50, height: 50))
                tracks.append(track)
        }
    }
    
    func titleOfNowPlayingItem() -> String{
        guard let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
            let title = nowPlayingItem.title else{
            return ""
        }
        return title
    }
    
    func artistOfNowPlayingItem() -> String{
        guard let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
            let artist = nowPlayingItem.artist else{
                return ""
        }
        return artist
    }
    
    func artworkOfNowPlayingItem() -> UIImage?{
        guard let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
            let artwork = nowPlayingItem.artwork else{
                return nil
        }
        return artwork.imageWithSize(CGSize(width: 50, height: 50))
    }
}