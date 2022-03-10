//
//  BottomBorderToolbar.swift
//  Imperium
//
//  Created by Ryan Renna on 2014-11-05.
//  Copyright (c) 2014 Offblast Softworks. All rights reserved.
//

import UIKit

public class BottomBorderToolbar: UIToolbar
{
    // Private
    private var _bottomLineView : LineView
    
    public required init?(coder aDecoder: NSCoder)
    {
        _bottomLineView = LineView(frame: .zero)
        super.init(coder: aDecoder)
    }
    public override init(frame: CGRect)
    {
        _bottomLineView = LineView(frame: .zero)
        super.init(frame: frame)
    }
    public convenience init()
    {
        self.init(frame:CGRect.zero)
        _bottomLineView = LineView(frame: .zero)
    }
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        //
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1)
        
        if #available(iOS 13.0, *) {
            _bottomLineView.tintColor = .separator
        } else {
            _bottomLineView.tintColor = .darkGray
        }
        _bottomLineView.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        self.addSubview(_bottomLineView)
    }
}
