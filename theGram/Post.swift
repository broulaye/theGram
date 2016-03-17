//
//  Post.swift
//  theGram
//
//  Created by macbookair11 on 3/15/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    /**
     * Other methods
     */
     
     /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)

    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    class func fetchData(caption: String?, completion: (instagrams: [PFObject]?, error: NSError? ) -> ()){
        var query: PFQuery
        
        if caption != nil {
            let predicate = NSPredicate(format: caption!)
            query = PFQuery(className: "Post", predicate: predicate)
        } else {
            query = PFQuery(className: "Post")
        }
        
        
        
        query.orderByDescending("_created_at")
        query.includeKey("author")
        query.limit = 20
        
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let gotmedia = media {
                print("media recieved 1")
                completion(instagrams: gotmedia, error: nil)
                
                
            } else {
                print(error?.localizedDescription)
                completion(instagrams: nil, error: error)
            }
        }
        
    }
    
}
