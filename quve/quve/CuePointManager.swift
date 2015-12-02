//
//  CuePointManager.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation

class CuePointManager {
    var tracks: [Track]
    var mediaPlayerInformationProvider: MediaPlayerInformationProvider
    
    init(){
        tracks = [Track]()
        mediaPlayerInformationProvider = MediaPlayerInformationProvider()
    }
    
    func addCuePoint(){
        if let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
            let title = nowPlayingItem.title{
                let track = Track(title: title, artistName: nowPlayingItem.artist ?? "")
                track.cuePoints.append(mediaPlayerInformationProvider.cuePointForNowPlayingTrack())
                tracks.append(track)
        }
    }
}