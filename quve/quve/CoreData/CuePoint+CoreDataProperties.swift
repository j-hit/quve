//
//  CuePoint+CoreDataProperties.swift
//  quve
//
//  Created by James Bampoe on 06/01/16.
//  Copyright © 2016 James Bampoe. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CuePoint {

    @NSManaged var name: String?
    @NSManaged var playbackTime: NSNumber?
    @NSManaged var track: Track?

}
