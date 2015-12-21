//
//  MasterViewController.swift
//  quve
//
//  Created by James Bampoe on 15/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import UIKit
import MediaPlayer

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
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func insertNewObject(sender: AnyObject) {
        cuePointManager.addCuePoint()
        tableView.reloadData()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                let track = cuePointManager.tracks[indexPath.row]
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
        return cuePointManager.tracks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackTableViewCell", forIndexPath: indexPath) as! TrackTableViewCell
        let track = cuePointManager.tracks[indexPath.row]
        
        cell.artistNameLabel.text = track.artistName
        cell.trackNameLabel.text = track.title
        cell.cueCountLabel.text = String.localizedStringWithFormat(NSLocalizedString("CueCountLabel", comment: "Info label: Track cue count"), track.cuePoints.count)
        cell.artworkImage.image = track.artwork ?? nil
        
        cell.artworkImage.layer.cornerRadius = 10
        cell.artworkImage.clipsToBounds = true
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            cuePointManager.tracks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 82.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

