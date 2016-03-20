//
//  Track.swift
//  quve
//
//  Created by James Bampoe on 06/01/16.
//  Copyright © 2016 James Bampoe. All rights reserved.
//

import Foundation
import CoreData
import MediaPlayer

func ==(lhs: Track, rhs: Track) -> Bool{
  if let leftTrackTitle = lhs.title,
    leftArtistName = lhs.artistName {
      return leftTrackTitle.isEqual(rhs.title) && leftArtistName.isEqual(rhs.artistName)
  }
  return false
}

class Track: NSManagedObject {
  private let artworkSize = 100

  func setInformationAccordingTo(nowPlayingItem nowPlayingItem: MPMediaItem){
    self.title = nowPlayingItem.title ?? "Unknown title"
    self.artistName = nowPlayingItem.artist ?? "Unknown artist"
    self.artwork = nowPlayingItem.artwork?.imageWithSize(CGSize(width: artworkSize, height: artworkSize))
    self.persistentID = nowPlayingItem.valueForProperty(MPMediaItemPropertyPersistentID) as? NSNumber
    self.cuePoints = Set<CuePoint>()
  }
}
