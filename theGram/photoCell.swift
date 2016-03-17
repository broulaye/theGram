//
//  photoCell.swift
//  theGram
//
//  Created by macbookair11 on 3/15/16.
//  Copyright © 2016 Broulaye Doumbia. All rights reserved.
//

import UIKit
import Parse


class photoCell: UITableViewCell {

  
    @IBOutlet weak var photoView: UIImageView!
    
    
    @IBOutlet weak var captionLabel: UILabel!

    var feed: PFObject? {
        
        didSet {
            
            let photo = feed!["media"] as? PFFile
            var image: UIImage?
            //let profileImage = feed!.valueForKeyPath("media") as! PFFile
            do
            {
            let profile = try photo!.getData()
            image = UIImage(data: profile)
            
            }
            catch
            {
            print(" error ")
            }
          
            
            
            self.photoView.image = image
            //self.photoView.loadInBackground()
            
            
            
         
            
            let caption = feed!["caption"] as? String
            if caption != nil {
                captionLabel.text = feed!["caption"] as? String
                
            } else {
                captionLabel.hidden = true
            }
            
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
