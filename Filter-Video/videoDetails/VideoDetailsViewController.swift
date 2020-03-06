//
//  VideoDetailsViewController.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 06/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit

class VideoDetailsViewController: UIViewController {

    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    
    @IBOutlet weak var viewMetaBtn: UIButton!
    @IBOutlet weak var saveMetaBtn: UIButton!
    

    @IBOutlet weak var metaDataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  

}
