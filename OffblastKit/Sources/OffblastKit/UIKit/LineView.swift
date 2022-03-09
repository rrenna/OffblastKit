//
//  LineView.swift
//  OffblastKit
//
//  Created by Ryan Renna on 2014-11-05.
//  Copyright (c) 2014 Offblast Softworks. All rights reserved.
//

import UIKit

public class LineView: UIView
{
    var horizontal : Bool
    {
        didSet { self.setNeedsDisplay() }
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        self.horizontal = true
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public override init(frame: CGRect)
    {
        self.horizontal = true
        super.init(frame: frame)
        self.setup()
    }
    
    public override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.setShouldAntialias(false)
        var colour : UIColor!
        
        if self.responds(to: #selector(getter: UIView.tintColor))
        {
            colour = self.tintColor
        }
        else
        {
            colour = .lightGray
        }
        
        ctx.setFillColor(colour.cgColor)
        
        if(self.horizontal)
        {
            ctx.fill(CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 0.5))
        }
        else
        {
            ctx.fill(CGRect(x:0,y: 0,width: 0.5,height: self.bounds.size.height))
        }
        
        super.draw(rect)
    }

    // MARK: Private
    
    private func setup()
    {
        self.backgroundColor = .clear
    }
}
