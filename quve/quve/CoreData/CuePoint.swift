//
//  CuePoint.swift
//  quve
//
//  Created by James Bampoe on 06/01/16.
//  Copyright © 2016 James Bampoe. All rights reserved.
//

import Foundation
import CoreData


class CuePoint: NSManagedObject {
  func estimatedStartTimeOfInterestPointAsString()->String {
    return estimatedStartTimeOfInterestPoint.timeAsHourMinuteSecondStringRepresentation()
  }
  
  var estimatedStartTimeOfInterestPoint: NSTimeInterval {
    var estimatedStartTime: NSTimeInterval = 0.0
    if let playbackTime = playbackTime?.doubleValue where playbackTime >= duration{
      estimatedStartTime = playbackTime - duration
    }
    return estimatedStartTime
  }
  
  var duration: NSTimeInterval {
    return 10.0
  }
  
  func addedAtPlaybackTime()->String {
    var playbackTimeString = ""
    if let playbackTime = playbackTime?.doubleValue {
      playbackTimeString = playbackTime.timeAsHourMinuteSecondStringRepresentation()
    }
    return playbackTimeString
  }
}

extension NSTimeInterval{
  func timeAsHourMinuteSecondStringRepresentation()->String {
    var playbackTimeStringRepresentation: String = ""
    let playbackTimeInSeconds = Int(round(self));
    let hours = playbackTimeInSeconds / 3600;
    let minutes = (playbackTimeInSeconds % 3600) / 60;
    let seconds = playbackTimeInSeconds % 60;
    
    if(hours == 0){
      playbackTimeStringRepresentation = String(format: "%01d:%02d", Int(minutes), Int(seconds))
    } else if (hours > 0){
      playbackTimeStringRepresentation = String(format: "%01d:%01d:%02d", Int(hours), Int(minutes), Int(seconds))
    }
    
    return playbackTimeStringRepresentation
  }
}