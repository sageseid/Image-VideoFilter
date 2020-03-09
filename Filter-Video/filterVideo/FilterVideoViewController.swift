//
//  FilterVideoViewController.swift
//  InstagramFilter
//
//  Created by James Fong on 2018-01-05.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit
import AVKit
import CoreData

public protocol FilterVideoViewControllerDelegate {
    func saveAVURLAsset(video: AVURLAsset)
    func filterVideoViewControllerVideoDidFilter(video: AVURLAsset)
    func filterVideoViewControllerDidCancel()
}



class FilterVideoViewController: FiilterViewController {
    
public var delegate: FilterVideoViewControllerDelegate?
    
    @IBOutlet weak var videoView: UIView!
    //video player
    fileprivate var avpController: AVPlayerViewController!
    fileprivate var avVideoComposition: AVVideoComposition!
    fileprivate var playerItem: AVPlayerItem!
    fileprivate var videoPlayer:AVPlayer!
    fileprivate var video: AVURLAsset?
    fileprivate var originalImage: UIImage?
    
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
    
    override open func loadView() {
        if let view = UINib(nibName: "FilterVideoViewController", bundle: Bundle(for: self.classForCoder)).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
            if let image = self.image {
                imageView?.image = image
                smallImage = resizeImage(image: image)
            }
        }
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
    
    override func applyFilter() { 
        let filterName = filterNameList[filterIndex]
        if let video = self.video {
            self.playVideo(video:video, filterName:filterNameList[filterIndex])
        }
    }
    
    override func createFilteredImage(filterName: String, image: UIImage) -> UIImage {
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
   
    @IBAction func closeButtonTapped() {
        if let delegate = self.delegate {
            delegate.filterVideoViewControllerDidCancel()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtontapped() {
        if avVideoComposition != nil {
        video?.exportFilterVideo(videoComposition: avVideoComposition , completion: { (url) in
           //let convertedVideo = AVURLAsset(url: url! as URL)
           self.save(name: url! as URL)
        })
        }
            
        dismiss(animated: true, completion: nil)
    }
    
    
    func save(name: URL) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let managedContext =
        appDelegate.persistentContainer.viewContext
      let entity =
        NSEntityDescription.entity(forEntityName: "Video",
                                   in: managedContext)!
      
      let videoUrl = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      videoUrl.setValue(name, forKeyPath: "videoAsset")
      do {
        try managedContext.save()
        videoArray.append(videoUrl)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
}
