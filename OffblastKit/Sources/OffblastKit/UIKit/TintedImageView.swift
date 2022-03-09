//
//  TintedImageView.swift
//  OffblastKit
//
//  Created by Ryan Renna on 2014-11-13.
//  Copyright (c) 2014 Offblast Softworks. All rights reserved.
//

import UIKit

public class TintedImageView: UIView
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
    
    @IBInspectable var bordered : Bool = true
    @IBInspectable var crossedOut : Bool = false
    
    //
    private var imageView : UIImageView!
    
    
    public override func awakeFromNib()
    {
        self.setup()
    }
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        //
        if(bordered)
        {
            self.layer.cornerRadius = self.frame.height / 2
        }
    }
    
    public override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if(crossedOut)
        {
            context.setStrokeColor(self.tintColor.cgColor)
            context.setLineWidth(2)
            context.move(to: CGPoint(x: 4, y: 4))
            context.addLine(to: CGPoint(x: 100, y: 100))
            context.drawPath(using: .stroke)
        }
    }
    
    /// MARK: Private Methods
    private func setup()
    {
        var insetRect = self.bounds
        
        if(bordered)
        {
            insetRect = insetRect.insetBy(dx: 6, dy: 6)
            self.layer.borderWidth = 2.0
            self.layer.borderColor = self.tintColor.cgColor //UIColor.lightGrayColor().CGColor
        }
        
        imageView = UIImageView(frame: insetRect)
        self.addSubview(imageView)
        
        //Makes button a templated image - tintable
        if let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        {
            self.image = templateImage
        }
        
        //self.content
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
    }
}
