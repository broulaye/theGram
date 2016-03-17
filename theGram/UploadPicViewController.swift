//
//  UploadPicViewController.swift
//  theGram
//
//  Created by macbookair11 on 3/16/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit
import Parse

class UploadPicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.captionTextField.delegate = self
        
        self.photoView.image = UIImage(named: "placeholder.png")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onSubmit(sender: AnyObject) {
        Post.postUserImage(image, withCaption: captionTextField.text,withCompletion: nil)
        performSegueWithIdentifier("toHome", sender: self)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        self.image = resize(editedImage, newSize: CGSizeMake(750, 750))
        self.photoView.image = self.image
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    
    @IBAction func upload(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
