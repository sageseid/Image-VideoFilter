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
    var Titleholder: String!
    var video:AVURLAsset!
    var metaItem:AVMetadataItem!
    var videoURl:URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideUiComponents()
        videoImage.image = ImageHolder
    }
    
    
    func hideUiComponents(){
        activityLoader.isHidden = true
        downloadUrlBtn.isHidden = true
    }
    
    func showUiComponents(){
           activityLoader.isHidden = false
           activityLoader.startAnimating()
    }
    
    
    
    func getVideoDetails(videoDetails: URL){
        videoURl = videoDetails
        let  videoDetail = AVURLAsset(url: videoDetails as URL)
        video = videoDetail
        ImageHolder = videoDetail.videoToUIImage()
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
        
            showUiComponents()
            let videoName = "VIDEO , ID : \(NSUUID().uuidString) "
            let storageReference = Storage.storage().reference().child(videoName)
            let localFile =  videoURl!
        
            let metadata = StorageMetadata()
        
        storageReference.putFile(from: localFile as URL, metadata: metadata, completion: { (metadata, error) in
                 if error == nil {
                     print("Successful video upload")
                    storageReference.downloadURL(completion: { (url, error) in
                        
                        self.downloadUrlBtn.setTitle(url?.absoluteString,for: .normal)
                        self.activityLoader.stopAnimating()
                        self.activityLoader.isHidden = true
                        self.downloadUrlBtn.isHidden = false
                    })
                     } else {
                     print(error?.localizedDescription)
                 }
             })
        

            
    }
    
    
    
    @IBAction func downloadUrlBtnClicked(_ sender: Any) {
       
        if let text = downloadUrlBtn.titleLabel?.text {
               guard let url = URL(string: text) else { return }
                UIApplication.shared.open(url)
        }
    
    }
    
}


 

