//
//  DetailViewController.swift
//  quve
//
//  Created by James Bampoe on 15/11/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var track: Track? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        if let track = self.track {
            if let label = self.detailDescriptionLabel {
                label.text = "\(track.artistName) - \(track.title)"
                for cuepoint in track.cuePoints{
                    label.text?.appendContentsOf(" \n\(cuepoint.estimatedStartTimeOfInterestPoint()) - \(cuepoint.addedAtPlaybackTime())")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

