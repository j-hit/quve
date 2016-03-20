//
//  AddCueViewController.swift
//  quve
//
//  Created by James Bampoe on 07/12/15.
//  Copyright © 2015 James Bampoe. All rights reserved.
//

import UIKit
import MediaPlayer

class AddCueViewController: UIViewController {
  
  @IBOutlet weak var addCuepointButton: UIButton!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  
  var cuePointManager = CuePointManager.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    setupView()
    
    cuePointManager.mediaPlayerInformationProvider.systemMusicPlayer.beginGeneratingPlaybackNotifications() // TODO: Simplify
    
    //Notification center add observer for and then reload MPMusicPlayerControllerNowPlayingItemDidChangeNotification
  }
  
  override func viewWillDisappear(animated: Bool) {
    cuePointManager.mediaPlayerInformationProvider.systemMusicPlayer.endGeneratingPlaybackNotifications() // TODO: Simplify
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func setupView(){
    styleTheAddCuepointButton()
    trackNameLabel.text = cuePointManager.titleOfNowPlayingItem()
    artistNameLabel.text = cuePointManager.artistOfNowPlayingItem()
    addCuepointButton.setBackgroundImage(cuePointManager.artworkOfNowPlayingItem(), forState: .Normal)
    addCuepointButton.setBackgroundImage(nil, forState: .Selected)
    
    /*let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = self.addCuepointButton.bounds
    addCuepointButton.insertSubview(blurView, atIndex: 0)*/
  }
  
  private func styleTheAddCuepointButton(){
    addCuepointButton.layer.cornerRadius = 10
    addCuepointButton.clipsToBounds = true
  }
  
  @IBAction func addCuepointPressed(sender: AnyObject) {
    cuePointManager.addCuePoint()
    
    
    
    /*UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
    self.addCuepointButton.frame.size.height = self.addCuepointButton.frame.size.height-20.0
    self.addCuepointButton.frame.size.height = self.addCuepointButton.frame.size.width-20.0
    }) { (done) -> Void in
    self.addCuepointButton.frame.size.height = self.addCuepointButton.frame.size.height+20.0
    self.addCuepointButton.frame.size.height = self.addCuepointButton.frame.size.width+20.0
    }*/
  }
}
