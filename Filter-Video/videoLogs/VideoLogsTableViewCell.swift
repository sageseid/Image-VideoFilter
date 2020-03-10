//
//  VideoLogsTableViewCell.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 04/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit

class VideoLogsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var VideoThumbnail: UIImageView!
    @IBOutlet weak var VideoTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateViews(title : String, thumbnail :UIImage){
          VideoTitle.text = title
          VideoThumbnail.image = thumbnail
      }
      
}


