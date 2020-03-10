//
//  FilterCollectionViewCell.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 03/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit

//collection view cells that show the variety of filters

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filterNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var initialLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureImageView()
    }
    
    func configureImageView() {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurredEffectView = UIVisualEffectView(effect: blur)
        blurredEffectView.alpha = 0.4
        blurredEffectView.frame = self.imageView.bounds
        self.imageView.addSubview(blurredEffectView)
    }

}
