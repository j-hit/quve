//
//  CuePointManager.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation
import UIKit

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
                track.artwork = nowPlayingItem.artwork?.imageWithSize(CGSize(width: 50, height: 50))
                tracks.append(track)
        }
    }
}