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

class VideoLogsViewController: UIViewController {

    @IBOutlet weak var VideoLogsTableview: UITableView!
    
    var videoArray = [AVURLAsset]()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        VideoLogsTableview.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
  
}

extension VideoLogsViewController:  UITableViewDataSource, UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
}

