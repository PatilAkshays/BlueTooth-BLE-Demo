//
//  ViewController.swift
//  TREEL
//
//  Created by Treel Mobility  on 22/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit
import AVKit

@available(iOS 11.0, *)
class ViewController: BaseViewController {
    @IBOutlet weak var videoView: UIView!
    
    //For video
    var avplayer = AVPlayer()
    var avplayerviewController : AVPlayerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
       //14
        Timer.scheduledTimer(withTimeInterval: 14, repeats: true, block: { _ in
            self.loadVideo()
//            self.performSegue(withIdentifier: "MasterView", sender: self)
        })
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationItem.leftBarButtonItem?.image = UIImage(named: "back")
        BLEManager.sharedManager.findBLE(true)
    }
    func loadVideo(){
        var videoURL = NSURL()
        videoURL = Bundle.main.url(forResource: "treelVideo", withExtension: "mp4")! as NSURL
        self.avplayer = AVPlayer.init(url: videoURL as URL)
        avplayerviewController.view.frame = videoView.frame
        avplayerviewController.view.backgroundColor = .black
        avplayerviewController.player = self.avplayer
        avplayerviewController.showsPlaybackControls = false
        avplayerviewController.player?.play()
     
                let xAxis = (ScreenSize.SCREEN_WIDTH / 2) - (videoView.frame.size.width / 2)
                let yAxis = (ScreenSize.SCREEN_HEIGHT / 2) - (videoView.frame.size.height / 2)
                avplayerviewController.view.frame = CGRect(x: xAxis, y: yAxis + 100, width: videoView.frame.size.width, height: videoView.frame.size.height);
        self.view.addSubview(avplayerviewController.view)

        
    }

    
    @IBAction func pressKnowUsBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"KnowUsVC") as! KnowUsVC
        self.navigationController?.pushViewController(masterViewController, animated: true)

    }
    @IBAction func pressKnowProductBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"KnowProductVC") as! KnowProductVC
        self.navigationController?.pushViewController(masterViewController, animated: true)
    }
    @IBAction func pressDemoBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"MasterViewController") as! MasterViewController
        self.navigationController?.pushViewController(masterViewController, animated: true)
        
    }
}


