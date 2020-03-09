//
//  VideoDetailsViewController.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 06/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit
import AVKit


class VideoDetailsViewController: UIViewController {

    
    @IBOutlet weak var videoImage: UIImageView!
        

    @IBOutlet weak var TitleLabel: UILabel!
 
    
    var ImageHolder: UIImage!
    var Titleholder: String!
    var video:AVURLAsset!
    var metaItem:AVMetadataItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoImage.image = ImageHolder
        TitleLabel.text = "Title : \(String(describing: Titleholder))"
    }
    
    
    func getVideoDetails(videoDetails: AVURLAsset){
        video = videoDetails
        ImageHolder = videoDetails.videoToUIImage()
        Titleholder = String(videoDetails.url.lastPathComponent)
        }
    
    
    
    @IBAction func playBtnClicked(_ sender: Any) {
        let avPlayerItem = AVPlayerItem(asset: video)
        let player = AVPlayer(playerItem: avPlayerItem)
        player.allowsExternalPlayback = false
        let playerViewController = AVPlayerViewController()
        playerViewController.allowsPictureInPicturePlayback = true
        playerViewController.player = player
        present(playerViewController, animated: true) {
               playerViewController.player!.play()
             }
    }
    
  
    @IBAction func uploadFirebaseBtn(_ sender: Any) {
    }
    

}


