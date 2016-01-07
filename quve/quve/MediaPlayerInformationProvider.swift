//
//  MediaPlayerInformationProvider.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaPlayerInformationProvider {
    lazy var systemMusicPlayer: MPMusicPlayerController = {
       return MPMusicPlayerController.systemMusicPlayer()
    }()
  
    func nowPlayingItem() -> MPMediaItem?{
        return systemMusicPlayer.nowPlayingItem
    }
    
    func currentPlaybackTime() -> NSTimeInterval{
        return systemMusicPlayer.currentPlaybackTime
    }
}