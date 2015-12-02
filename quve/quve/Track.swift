//
//  Song.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation

class Track{
    var title: String
    var artistName: String
    var cuePoints: [CuePoint]
    
    init(title: String, artistName: String){
        self.title = title
        self.artistName = artistName
        self.cuePoints = [CuePoint]()
    }
}