//
//  CuePointManager.swift
//  quve
//
//  Created by James Bampoe on 18/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import MediaPlayer
import CoreData

final class CuePointManager {
  static let sharedInstance = CuePointManager()
  
  lazy var stack: CoreDataStack = {
    let storeName = "Quve"
    let options : [String : NSObject] = [NSPersistentStoreUbiquitousContentNameKey : storeName,
      NSMigratePersistentStoresAutomaticallyOption : true,
      NSInferMappingModelAutomaticallyOption: true]
    return CoreDataStack(modelName: "QuveDataModel", storeName: storeName, options: options)
  }()
  
  lazy var tracks : NSFetchedResultsController = {
    let request = NSFetchRequest(entityName: "Track")
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    
    let tracks = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.stack.context, sectionNameKeyPath: nil, cacheName: nil)
    return tracks
  }()
  
  var mediaPlayerInformationProvider: MediaPlayerInformationProvider
  
  private init(){
    mediaPlayerInformationProvider = MediaPlayerInformationProvider()
  }
  
  func reloadSavedData(){
    do {
      try tracks.performFetch()
    } catch let error as NSError {
      NSLog("Error fetching data \(error)")
    }
  }
  
  func deleteTrack(atIndexPath indexPath: NSIndexPath) {
    let trackToDelete = tracks.objectAtIndexPath(indexPath) as! Track
    stack.context.deleteObject(trackToDelete)
    stack.saveContext()
  }
  
  func deleteCuePoint(cuePoint: CuePoint) {
    stack.context.deleteObject(cuePoint)
    stack.saveContext()
    reloadSavedData()
  }
  
  func addCuePoint(){
    if let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
      track = trackForNewCuePoint(ofMediaItem: nowPlayingItem),
      cuePoint = cuePointForNowPlayingTrack(){
        let cuePoints = track.cuePoints?.mutableCopy() as? NSMutableSet
        cuePoints?.addObject(cuePoint)
        track.cuePoints = cuePoints?.copy() as? NSSet
        stack.saveContext()
    }
  }
  
  func trackForNewCuePoint(ofMediaItem mediaItem: MPMediaItem) -> Track?{
    if let title = mediaItem.title, artistName = mediaItem.artist {
      let trackFetchRequest = NSFetchRequest(entityName: "Track")
      trackFetchRequest.predicate = NSPredicate(format: "title == %@ AND artistName == %@", title, artistName)
      do {
        if let track = try (stack.context.executeFetchRequest(trackFetchRequest) as! [Track]).first{
          return track
        } else {
          if let newTrack = NSEntityDescription.insertNewObjectForEntityForName("Track", inManagedObjectContext: stack.context) as? Track {
            newTrack.setInformationAccordingTo(nowPlayingItem: mediaItem)
            return newTrack
          }
        }
      } catch let error as NSError {
        print("Could not get track \(error)")
      }
    }
    
    return nil
  }
  
  func cuePointForNowPlayingTrack() -> CuePoint? {
    if let cuePoint = NSEntityDescription.insertNewObjectForEntityForName("CuePoint", inManagedObjectContext: stack.context) as? CuePoint {
      cuePoint.playbackTime = mediaPlayerInformationProvider.currentPlaybackTime()
      cuePoint.name = ""
      return cuePoint
    }
    return nil
  }
  
  func titleOfNowPlayingItem() -> String{
    guard let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
      let title = nowPlayingItem.title else{
        return ""
    }
    return title
  }
  
  func artistOfNowPlayingItem() -> String{
    guard let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
      let artist = nowPlayingItem.artist else{
        return ""
    }
    return artist
  }
  
  func artworkOfNowPlayingItem() -> UIImage?{
    guard let nowPlayingItem = mediaPlayerInformationProvider.nowPlayingItem(),
      let artwork = nowPlayingItem.artwork else{
        return nil
    }
    return artwork.imageWithSize(CGSize(width: 400, height: 400))
  }
}