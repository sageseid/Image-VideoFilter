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
//VideoLogsTableViewCellID
    
    @IBOutlet weak var VideoLogsTableview: UITableView!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("trigger vc")
        VideoLogsTableview.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("check video array")
        print(videoArray)
        VideoLogsTableview.dataSource = self 
        VideoLogsTableview.reloadData()
    }
    
    
  
}

extension VideoLogsViewController:  UITableViewDataSource, UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoLogsTableViewCellID") as? VideoLogsTableViewCell{
                       let videoItem = videoArray[indexPath.row]
                      let text_title   = "Video Clip \(indexPath.row + 1)"
                      print("text title")
                      print(text_title)
                      let image_thumbnail =   videoItem.videoToUIImage()
                       print("image title")
                       print(image_thumbnail)
                       cell.updateViews(title: text_title, thumbnail: image_thumbnail)
                       return cell
                   }else {
                       return  VideoLogsTableViewCell()
                   }
        }
    
    
    }
    
    
    
    


