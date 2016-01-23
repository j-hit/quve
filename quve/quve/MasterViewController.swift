//
//  MasterViewController.swift
//  quve
//
//  Created by James Bampoe on 15/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import UIKit
import MediaPlayer
import CoreData

class MasterViewController: UITableViewController {
  
  var detailViewController: DetailViewController? = nil
  var cuePointManager = CuePointManager.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    if let split = self.splitViewController {
      let controllers = split.viewControllers
      self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
    
    cuePointManager.reloadSavedData()
    tableView.reloadData()
    cuePointManager.tracks.delegate = self // TODO: Create cuepointManagerDelegate
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
        let track = cuePointManager.tracks.fetchedObjects?[indexPath.row] as? Track
        controller.track = track
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        //controller.navigationItem.backBarButtonItem?.title = " "
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
  // MARK: - Table View
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cuePointManager.tracks.fetchedObjects?.count ?? 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TrackTableViewCell", forIndexPath: indexPath) as! TrackTableViewCell
    
    configureCell(cell, indexPath: indexPath)
    
    return cell
  }
  
  private func configureCell(cell: TrackTableViewCell, indexPath: NSIndexPath) {
    if let track = cuePointManager.tracks.objectAtIndexPath(indexPath) as? Track {
      cell.artistNameLabel.text = track.artistName
      cell.trackNameLabel.text = track.title
      cell.cueCountLabel.text = String.localizedStringWithFormat(NSLocalizedString("CueCountLabel", comment: "Info label: Track cue count"), track.cuePoints?.count ?? 0)
      cell.artworkImage.image = track.artwork as? UIImage ?? nil
      
      cell.artworkImage.layer.cornerRadius = 10
      cell.artworkImage.clipsToBounds = true
    }
  }
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      cuePointManager.deleteTrack(atIndexPath: indexPath)
    }
  }
  
  override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 82.0
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

extension MasterViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(controller: NSFetchedResultsController) {
    tableView.beginUpdates()
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type{
    case .Insert:
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
    case .Delete:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
    case .Update:
      if let indexPath = indexPath, cell = tableView.cellForRowAtIndexPath(indexPath) as? TrackTableViewCell
      {
        configureCell(cell, indexPath: indexPath)
      }
    case .Move:
      tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
      tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
    }
  }
  
  func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
    let indexSet = NSIndexSet(index: sectionIndex)
    
    switch type {
    case .Insert:
      tableView.insertSections(indexSet, withRowAnimation: .Automatic)
    case .Delete:
      tableView.deleteSections(indexSet, withRowAnimation: .Automatic)
    default:
      break
    }
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.endUpdates()
  }
}
