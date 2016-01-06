//
//  DetailViewController.swift
//  quve
//
//  Created by James Bampoe on 15/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var track: Track? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let lightRed = UIColor(red:0.84, green:0.26, blue:0.33, alpha:1.0)
    let darkViolet = UIColor(red:0.45, green:0.33, blue:0.40, alpha:1.0)
    let lightBlue = UIColor(red:0.46, green:0.66, blue:0.73, alpha:1.0)
    let goldYellow = UIColor(red:0.96, green:0.80, blue:0.02, alpha:1.0)
    let creme = UIColor(red:0.96, green:0.97, blue:0.85, alpha:1.0)
    
    var colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colors = [creme, lightRed, lightBlue, darkViolet, goldYellow]
    }
    
    override func viewWillAppear(animated: Bool) {
        if let track = track{
            navigationItem.title = track.title + " - " + track.artistName
        }
        tableView.reloadData()
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return track?.cuePoints.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CuepointTableViewCell", forIndexPath: indexPath) as! CuepointTableViewCell
        
        if let cuepoint = track?.cuePoints[indexPath.row]{
            cell.cuepointDescriptionLabel.text = cuepoint.description ?? ""
            cell.cuepointTimeRangeLabel.text = "\(cuepoint.estimatedStartTimeOfInterestPoint()) - \(cuepoint.addedAtPlaybackTime())"
            cell.cuepointImage.backgroundColor = colors[indexPath.row % colors.count]
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            track?.cuePoints.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 74.0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

