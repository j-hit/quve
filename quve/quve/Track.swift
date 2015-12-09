//
//  Song.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

func ==(lhs: Track, rhs: Track) -> Bool{
    return lhs.title.isEqual(rhs.title) && lhs.artistName.isEqual(rhs.artistName)
}

class Track{
    private let artworkSize = 300
    var title: String
    var artistName: String
    var cuePoints: [CuePoint]
    var artwork: UIImage?
    
    init(title: String, artistName: String){
        self.title = title
        self.artistName = artistName
        self.cuePoints = [CuePoint]()
    }
    
    init(nowPlayingItem: MPMediaItem){
        self.title = nowPlayingItem.title ?? "Unknown title"
        self.artistName = nowPlayingItem.artist ?? "Unknown artist"
        self.artwork = nowPlayingItem.artwork?.imageWithSize(CGSize(width: artworkSize, height: artworkSize))
        self.cuePoints = [CuePoint]()
    }
}

extension Track: Hashable{
    var hashValue: Int {
        return title.hashValue ^ artistName.hashValue
    }
}