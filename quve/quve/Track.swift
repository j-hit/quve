//
//  Song.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import Foundation
import UIKit

class Track{
    var title: String
    var artistName: String
    var cuePoints: [CuePoint]
    var artwork: UIImage?
    
    init(title: String, artistName: String){
        self.title = title
        self.artistName = artistName
        self.cuePoints = [CuePoint]()
    }
}