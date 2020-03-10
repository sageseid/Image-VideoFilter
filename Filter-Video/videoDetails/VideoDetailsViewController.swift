//
//  VideoDetailsViewController.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 06/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit
import AVKit
import Firebase


class VideoDetailsViewController: UIViewController {

    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var downloadUrlBtn: UIButton!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    
    var ImageHolder: UIImage!
    var video:AVURLAsset!
    var videoHolderUrl:URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideUiComponents()
        videoImage.image = ImageHolder
    }
    
    
    func hideUiComponents(){
        activityLoader.isHidden = true
        downloadUrlBtn.isHidden = true
    }
    
    func showActivityLoader(){
        activityLoader.isHidden = false
        activityLoader.startAnimating()
    }
    
    func showDownloadLinkButton (){
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
        downloadUrlBtn.isHidden = false
    }
    
    
    func getVideoDetails(videoDataUrl: URL){
        videoHolderUrl = videoDataUrl
        let videoData = AVURLAsset(url: videoDataUrl as URL)
        video = videoData
        ImageHolder = video.videoToUIImage()
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
        
        showActivityLoader()
        // create a unique id to name the video file on firebase
        let videoName = "VIDEO , ID : \(NSUUID().uuidString) "
        
        // create reference to firebase storage
        let storageReference = Storage.storage().reference().child(videoName)
       
        //get metadata of video file
        let metadata = StorageMetadata()
        
        //perform upload operation of video file and its metadata to firebase storage
        storageReference.putFile(from: videoHolderUrl as URL, metadata: metadata, completion: { (metadata, error) in
                 if error == nil {
                    
        // get link to video on firebase storage
        storageReference.downloadURL(completion: { (url, error) in
            
        // set link to title of button
        self.downloadUrlBtn.setTitle(url?.absoluteString,for: .normal)
        self.showDownloadLinkButton()
                  })
        } else {
        print(error?.localizedDescription)
        }
     })
    }
    
    
    // func to open link in safari
    @IBAction func downloadUrlBtnClicked(_ sender: Any) {
        if let text = downloadUrlBtn.titleLabel?.text {
               guard let url = URL(string: text) else { return }
                UIApplication.shared.open(url)
        }
    }
    
}


 

