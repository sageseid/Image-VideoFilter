//
//  FilterVideoViewController.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 03/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit
import AVKit

class FilterVideoViewController: UIViewController {
    
    public var delegate: FilterVideoViewControllerDelegate?

    @IBOutlet weak var videoView: UIView!    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    fileprivate var avpController: AVPlayerViewController!
    fileprivate var avVideoComposition: AVVideoComposition!
    fileprivate var playerItem: AVPlayerItem!
    fileprivate var videoPlayer:AVPlayer!
    fileprivate var video: AVURLAsset?
    fileprivate var originalImage: UIImage?
    
 //-------------------------------------------------
    var image: UIImage?
    var filterIndex = 0
    let context = CIContext(options: nil)
    
    let filterNameList = [
        "No Filter",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CILinearToSRGBToneCurve",
        "CISRGBToneCurveToLinear"
    ]
    
     let filterDisplayNameList = [
        "Normal",
        "Chrome",
        "Fade",
        "Instant",
        "Mono",
        "Noir",
        "Process",
        "Tonal",
        "Transfer",
        "Tone",
        "Linear"
    ]
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let video = self.video {
    self.playVideo(video:video, filterName: self.filterNameList[0])
            }
    }
    
    
    
    public init(video: AVURLAsset) {
        super.init(nibName: nil, bundle: nil)
        self.video = video
        self.image = video.videoToUIImage()
        self.originalImage = self.image
    }
    
     required public init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    
    func playVideo(video:AVURLAsset, filterName:String){
           let avPlayerItem = AVPlayerItem(asset: video)
           if(filterIndex != 0){
               avVideoComposition = AVVideoComposition(asset: self.video!, applyingCIFiltersWithHandler: { request in
                   let source = request.sourceImage.clampedToExtent()
                   let filter = CIFilter(name:filterName)!
                   filter.setDefaults()
                   filter.setValue(source, forKey: kCIInputImageKey)
                   let output = filter.outputImage!
                   request.finish(with:output, context: nil)
               })
               avPlayerItem.videoComposition = avVideoComposition
           }
           if self.videoPlayer == nil {
               self.videoPlayer = AVPlayer(playerItem: avPlayerItem)
               self.avpController = AVPlayerViewController()
               self.avpController.player = self.videoPlayer
               self.avpController.view.frame = self.videoView.bounds
               self.addChild(avpController)
               self.videoView.addSubview(avpController.view)
               videoPlayer.play()
           }
           else {
               videoPlayer.replaceCurrentItem(with: avPlayerItem)
               videoPlayer.play()
           }
       }
    
    
     func applyFilter() {
        let filterName = filterNameList[filterIndex]
        if let video = self.video {
            self.playVideo(video:video, filterName:filterNameList[filterIndex])
        }
    }
    
     func createFilteredImage(filterName: String, image: UIImage) -> UIImage {
        if(filterName == filterNameList[0]){
            return self.image!
        }
        let sourceImage = CIImage(image: image)
        let filter = CIFilter(name: filterName)
        filter?.setDefaults()
        filter?.setValue(sourceImage, forKey: kCIInputImageKey)
        let outputCGImage = context.createCGImage((filter?.outputImage!)!, from: (filter?.outputImage!.extent)!)
        let filteredImage = UIImage(cgImage: outputCGImage!, scale: image.scale, orientation: image.imageOrientation)
        
        return filteredImage
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.filterVideoViewControllerDidCancel()
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveToFireBaseBtnClicked(_ sender: Any) {
        video?.exportFilterVideo(videoComposition: avVideoComposition , completion: { (url) in
            if let delegate = self.delegate {
                let convertedVideo = AVURLAsset(url: url! as URL)
                delegate.filterVideoViewControllerVideoDidFilter(video: convertedVideo)
            }
        })
        dismiss(animated: true, completion: nil)
    }
}

public protocol FilterVideoViewControllerDelegate {
    func filterVideoViewControllerVideoDidFilter(video: AVURLAsset)
    func filterVideoViewControllerDidCancel()
}
