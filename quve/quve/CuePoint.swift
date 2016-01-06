//
//  CuePoint.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation

class CuePoint{
    var playbackTime: NSTimeInterval
    var description: String?
    
    init(playbackTime: NSTimeInterval){
        self.playbackTime = playbackTime
    }
    
    func estimatedStartTimeOfInterestPoint()->String{
        var estimatedStartTime: NSTimeInterval = 0.0
        let secondsToSubtractFromPlaybackTime = 10.0
        if(playbackTime >= secondsToSubtractFromPlaybackTime){
            estimatedStartTime = playbackTime - secondsToSubtractFromPlaybackTime
        }
        return estimatedStartTime.timeAsHourMinuteSecondStringRepresentation()
    }
    
    func addedAtPlaybackTime()->String{
        return playbackTime.timeAsHourMinuteSecondStringRepresentation()
    }
}

extension NSTimeInterval{
    func timeAsHourMinuteSecondStringRepresentation()->String{
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