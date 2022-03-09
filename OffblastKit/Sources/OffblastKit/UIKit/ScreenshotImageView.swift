//
//  ScreenshotImageView.swift
//  OffblastKit
//
//  Created by Ryan Renna on 2015-09-30.
//  Copyright © 2015 Offblast Softworks. All rights reserved.
//

import UIKit

class ScreenshotImageView: UIView
{
    @IBInspectable var image : UIImage! {
        
        willSet(newImage)
        {
            if(imageView != nil)
            {
                imageView.image = newImage
            }
        }
    }
    //
    private var imageView : UIImageView!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib()
    {
        imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        imageView.image = self.image
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
    }
    override func layoutSubviews()
    {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 15.0
    }
}
