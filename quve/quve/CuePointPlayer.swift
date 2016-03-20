//
//  CuePointPlayer.swift
//  quve
//
//  Created by James Bampoe on 30/01/16.
//  Copyright © 2016 James Bampoe. All rights reserved.
//

import Foundation
import MediaPlayer

class CuePointPlayer {
  private var timer: NSTimer
  private let mediaPlayerInformationProvider: MediaPlayerInformationProvider
  
  private var trackToBeRestoredAfterPlayback: MPMediaItem?
  private var playbackTimeOfTrackToBeRestored: NSTimeInterval?
  
  init(mediaPlayerInformationProvider: MediaPlayerInformationProvider) {
    self.mediaPlayerInformationProvider = mediaPlayerInformationProvider
    timer = NSTimer()
  }
  
  func playCuePoint(cuePoint: CuePoint) {
    let systemMusicPlayer = mediaPlayerInformationProvider.systemMusicPlayer
    
    //stopCuePointPlayback()
    
    trackToBeRestoredAfterPlayback = systemMusicPlayer.nowPlayingItem
    playbackTimeOfTrackToBeRestored = mediaPlayerInformationProvider.currentPlaybackTime()
    
    let query = MPMediaQuery.songsQuery()
    let selectedSongFilterPredicate = MPMediaPropertyPredicate(value: cuePoint.track?.persistentID, forProperty: MPMediaItemPropertyPersistentID, comparisonType: .EqualTo)
    query.addFilterPredicate(selectedSongFilterPredicate)
    let items = query.items
    print(items)
    
    
    systemMusicPlayer.setQueueWithQuery(query)
    systemMusicPlayer.currentPlaybackTime = cuePoint.estimatedStartTimeOfInterestPoint
    systemMusicPlayer.play()
    
    timer = NSTimer.scheduledTimerWithTimeInterval(cuePoint.duration, target: self, selector: "stopCuePointPlayback", userInfo: nil, repeats: false)
  }
  
  @objc func stopCuePointPlayback() {
    let systemMusicPlayer = mediaPlayerInformationProvider.systemMusicPlayer
    systemMusicPlayer.stop()
    timer.invalidate()
    restoreTrackThatWasPlayingBefore()
  }
  
  private func restoreTrackThatWasPlayingBefore() {
    let systemMusicPlayer = mediaPlayerInformationProvider.systemMusicPlayer
    
    if let trackToBeRestoredAfterPlayback = trackToBeRestoredAfterPlayback, playbackTimeOfTrackToBeRestored = playbackTimeOfTrackToBeRestored {
      let query = MPMediaQuery.songsQuery()
      let selectedSongFilterPredicate = MPMediaPropertyPredicate(value: trackToBeRestoredAfterPlayback.valueForProperty(MPMediaItemPropertyPersistentID), forProperty: MPMediaItemPropertyPersistentID, comparisonType: .EqualTo)
      query.addFilterPredicate(selectedSongFilterPredicate)
      systemMusicPlayer.setQueueWithQuery(query)
      systemMusicPlayer.currentPlaybackTime = playbackTimeOfTrackToBeRestored
      systemMusicPlayer.play()
      
      self.trackToBeRestoredAfterPlayback = nil
      self.playbackTimeOfTrackToBeRestored = nil
    }
  }
}