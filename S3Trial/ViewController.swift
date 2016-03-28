//
//  ViewController.swift
//  S3Trial
//
//  Created by Aya on 3/15/16.
//  Copyright © 2016 Aya. All rights reserved.
//

import UIKit
import AWSS3




class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imgview: UIImageView!
    var imageToupload: UIImage?
    let imagepicker = UIImagePickerController()
    
    var uploadRequest : AWSS3TransferManagerUploadRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         imagepicker.delegate = self
        
        
    }

    @IBAction func btn_upload_Pressed(sender: UIButton)
    {
        if let img = imageToupload
        {
            var imagename = "\(NSDate()).jpg"
            imagename = imagename.stringByReplacingOccurrencesOfString(" ", withString: "" )
            imagename = imagename.stringByReplacingOccurrencesOfString(":", withString: "" )
            imagename = imagename.stringByReplacingOccurrencesOfString("+", withString: "" )
            print (imagename)
            
            //first compress the image
            let imagedata = UIImageJPEGRepresentation(img, 0.2)
            // create local path for the image to be used for upload at s3
            let imgpath = NSTemporaryDirectory().stringByAppendingString(imagename)
            // write the image to this image path
            imagedata?.writeToFile(imgpath, atomically: true)
            
            uploadRequest = AWSS3TransferManagerUploadRequest()
            uploadRequest?.bucket = S3_BUCKET_NAME
            uploadRequest?.ACL = AWSS3ObjectCannedACL.PublicRead
            uploadRequest?.key = "\(imagename)"
            uploadRequest?.contentType = "image/JPEG"
            uploadRequest?.body = NSURL(fileURLWithPath: imgpath)
            
            let transferManager = AWSS3TransferManager.defaultS3TransferManager()
           
            transferManager.upload(uploadRequest).continueWithBlock({ task -> AnyObject? in
                
                if task.error != nil
                {
                    print("Error: \(task.error.debugDescription)")
                }
                else
                {
                  let url = NSURL(string: "https:/s3.amazonaws.com/\(S3_BUCKET_NAME)/\(imagename)")!
                    print (url)
                }
                return "uploaded"
            })
        }
        else
        {
            print("Select image to be uploaded")
        }
    }
    
    @IBAction func img_selection_pressed(sender: AnyObject)
    {
        presentViewController(imagepicker, animated: true , completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)
        imgview.image = image
        imageToupload = image
    }
    
}

