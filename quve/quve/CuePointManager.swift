//
//  CuePointManager.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

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
            let _ = nowPlayingItem.title{
                let track = trackForNewCuePoint(ofMediaItem: nowPlayingItem)
                track.cuePoints.append(mediaPlayerInformationProvider.cuePointForNowPlayingTrack())
        }
    }
    
    func trackForNewCuePoint(ofMediaItem mediaItem: MPMediaItem) -> Track{
        var track = Track(nowPlayingItem: mediaItem)
        if(tracks.contains(track)){
            track = tracks.filter({$0 == track}).first!
        }else{
            tracks.append(track)
        }
        return track
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
        return artwork.imageWithSize(CGSize(width: 400, height: 400))
    }
}