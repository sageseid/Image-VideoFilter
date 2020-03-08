//
//  VideoLogsViewController.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 04/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

var videoArray = [AVURLAsset]()


class VideoLogsViewController: UIViewController {
    
 
    
    @IBOutlet weak var VideoLogsTableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        VideoLogsTableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VideoLogsTableview.reloadData()
        VideoLogsTableview.dataSource = self
        VideoLogsTableview.delegate = self
    }
    
    
  
}

extension VideoLogsViewController:  UITableViewDataSource, UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoLogsTableViewCellID") as? VideoLogsTableViewCell{
                       let videoItem = videoArray[indexPath.row]

                      let text_title   = "Video Clip \(indexPath.row + 1) "
                      let image_thumbnail =   videoItem.videoToUIImage()
                       cell.updateViews(title: text_title, thumbnail: image_thumbnail)
                       return cell
                   }else {
                       return  VideoLogsTableViewCell()
                   }
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("its Clicked")
        let videoDetail = videoArray[indexPath.row]
        performSegue(withIdentifier: "DetailedSegue", sender: videoDetail)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if  let TestVc = segue.destination as? VideoDetailsViewController {
            assert(sender as? AVURLAsset != nil)
                 TestVc.getVideoDetails(videoDetails: sender as! AVURLAsset )
             }
                 
    }
    
    }
    
    
    
    


