//
//  UploadFileViewController.swift
//  Filter-Video
//
//  Created by Noel Obaseki on 03/03/2020.
//  Copyright © 2020 NoelObaseki. All rights reserved.
//

import UIKit
import AVKit
import Photos

class UploadFileViewController: UIViewController {

    var imgPickerViewController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPickerViewController = UIImagePickerController()
        imgPickerViewController.delegate = self
        imgPickerViewController.mediaTypes = ["public.image", "public.movie"]
        imgPickerViewController.allowsEditing = true
    }
    
    @IBAction func uploadBtnClicked(_ sender: Any) {
        imgPickerViewController.sourceType = .photoLibrary
        present(imgPickerViewController, animated: true, completion: nil)
    }
    
}



extension UploadFileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
       }
    
   // func to select video and export it to FilterVideoViewController
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            if let nsURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
                AVAsset.squareCropVideo(inputURL: nsURL, completion: { (sqVideoURL) in
                    let video = AVURLAsset(url: sqVideoURL! as URL)
                    let videoViewController = FilterVideoViewController(video:video)
                    DispatchQueue.main.async {
                        self.present(videoViewController, animated: false, completion: nil)
                    }
            })
        }
    }
}
