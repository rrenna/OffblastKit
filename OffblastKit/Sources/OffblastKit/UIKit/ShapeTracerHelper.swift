//
//  ShapeTracerHelper.swift
//  OffblastKit
//
//  Created by Ryan Renna on 2015-01-09.
//  Copyright (c) 2015 Offblast Softworks. All rights reserved.
//

import UIKit

public enum ShapeType
{
    case Triangle, Square, Rectangle, Circle, Hexagon, Pentagon
}

public class ShapeTracerHelper: NSObject {
   
    public class func trace(shape:ShapeType, inFrame frame:CGRect)
    {
        trace(shape, filledWithColour: nil, inFrame: frame)
    }
 
    public class func trace(_ shape:ShapeType, filledWithColour fillColour:UIColor!, inFrame frame:CGRect)
    {
        trace(shape, filledWithColour: fillColour, tracedWithColour: .lightGray, withWidth: 1.0, inFrame: frame)
    }
    
    public class func trace(_ shape:ShapeType, filledWithColour fillColour: UIColor!, tracedWithColour traceColour:UIColor!, withWidth traceWidth:Double!, inFrame frame:CGRect)
    {
        if(shape == .Triangle)
        {
            traceTriangle(filledWithColour:fillColour, tracedWithColour:traceColour, withWidth:traceWidth, inFrame: frame)
        }
        else if(shape == .Rectangle)
        {
            traceRectangle(filledWithColour:fillColour, tracedWithColour:traceColour, withWidth:traceWidth, inFrame: frame)
        }
        else if(shape == .Circle)
        {
            traceCircle(filledWithColour:fillColour,tracedWithColour:traceColour, withWidth:traceWidth, inFrame: frame)
        }
        else if(shape == .Hexagon)
        {
            traceHexagon(filledWithColour:fillColour, tracedWithColour:traceColour, withWidth:traceWidth, inFrame: frame)
        }
        else if(shape == .Square)
        {
            traceSquare(filledWithColour:fillColour, tracedWithColour:traceColour, withWidth:traceWidth, inFrame: frame)
        }
        else
        {
            tracePentagon(filledWithColour:fillColour, tracedWithColour:traceColour, withWidth:traceWidth, inFrame: frame)
        }
    }
    
    // MARK: Private Methods
    class private func traceRectangle(filledWithColour colour:UIColor!, tracedWithColour traceColour:UIColor!, withWidth traceWidth:Double!, inFrame frame:CGRect)
    {
        var insetFrame = frame
        
        let dy = floor(frame.height * 0.25)
        insetFrame = insetFrame.insetBy(dx: 4.0, dy: dy)
        let context = UIGraphicsGetCurrentContext()!
        
        context.move(to: CGPoint(x: insetFrame.minX, y: insetFrame.minY))
        context.addLine(to: CGPoint(x: insetFrame.maxX, y: insetFrame.minY))
        context.addLine(to: CGPoint(x: insetFrame.maxX, y: insetFrame.maxY))
        context.addLine(to: CGPoint(x: insetFrame.minX, y: insetFrame.maxY))
        context.closePath()
        
        if(colour != nil)
        {
            context.setFillColor(colour.cgColor)
            context.fillPath()
        }
        
        if(traceColour != nil && traceWidth != nil)
        {
            context.setLineWidth(traceWidth)
            context.setStrokeColor(traceColour.cgColor)
            context.strokePath()
        }
        
    }
    class private func traceSquare(filledWithColour colour:UIColor!,tracedWithColour traceColour:UIColor!, withWidth traceWidth:Double!, inFrame frame:CGRect)
    {
        var insetFrame = frame
        insetFrame = insetFrame.insetBy(dx: 6, dy: 6)
        let context = UIGraphicsGetCurrentContext()!
        
        context.move(to: CGPoint(x: insetFrame.minX, y: insetFrame.minY))
        context.addLine(to: CGPoint(x: insetFrame.maxX, y: insetFrame.minY))
        context.addLine(to: CGPoint(x: insetFrame.maxX, y: insetFrame.maxY))
        context.addLine(to: CGPoint(x: insetFrame.minX, y: insetFrame.maxY))
        context.closePath()
        
        if(colour != nil)
        {
            context.setFillColor(colour.cgColor)
            context.fillPath()
        }
        
        if(traceColour != nil && traceWidth != nil)
        {
            context.setLineWidth(CGFloat(traceWidth))
            context.setStrokeColor(traceColour.cgColor)
            context.strokePath()
        }

    }
    class private func traceCircle(filledWithColour colour:UIColor!, tracedWithColour traceColour:UIColor!, withWidth traceWidth:Double!, inFrame frame:CGRect)
    {
        var insetFrame = frame
        insetFrame = insetFrame.insetBy(dx: 2, dy: 2)
        let context = UIGraphicsGetCurrentContext()!
        
        var center = CGPoint()
        
        let radius : CGFloat = min(CGFloat(insetFrame.size.width), CGFloat(insetFrame.size.height)) / 2
        center.x = insetFrame.origin.x + insetFrame.size.width / 2.0
        center.y = insetFrame.origin.y + insetFrame.size.height / 2.0
        context.saveGState()
        
        if(colour != nil)
        {
            context.setFillColor(colour.cgColor)
            context.fillPath()
        }
        
        context.addArc(center: CGPoint(x: insetFrame.midX, y: insetFrame.midY), radius: radius, startAngle: CGFloat(0.0), endAngle: .pi * CGFloat(2), clockwise: true)
        
        //CGContextAddArc(context,insetFrame.midX,insetFrame.midY,radius,CGFloat(0.0), CGFloat(M_PI) * CGFloat(2),1);
        
        if(traceColour != nil && traceWidth != nil)
        {
            context.setLineWidth(CGFloat(traceWidth))
            context.setStrokeColor(traceColour.cgColor)
            context.strokePath()
        }
    }
    class private func traceTriangle(filledWithColour colour:UIColor!, tracedWithColour traceColour:UIColor!, withWidth traceWidth:Double!, inFrame frame:CGRect)
    {   
        let bounds = frame
        let triangleShape = UIBezierPath()
        
        triangleShape.move(to: CGPoint(x: 2, y: (bounds.height * 0.85) - 2 ))
        triangleShape.addLine(to: CGPoint(x: bounds.midX, y: 2))
        triangleShape.addLine(to: CGPoint(x: bounds.maxX - 2, y: (bounds.height * 0.85) - 2 ))
        triangleShape.close()
        
        if(colour != nil)
        {
            colour.setFill()
            triangleShape.fill()
        }
        
        if(traceColour != nil && traceWidth != nil)
        {
            triangleShape.lineWidth = CGFloat(traceWidth)
            traceColour.setStroke()
            triangleShape.stroke()
        }
    }
    
    class private func traceHexagon(filledWithColour colour:UIColor!, tracedWithColour traceColour:UIColor!, withWidth traceWidth:Double!, inFrame frame:CGRect)
    {
        let hexRect: CGRect = CGRect(x: frame.minX + floor(frame.width * 0.00980 + 0.5), y: frame.minY + floor(frame.height * 0.07548 + 0.1) + 0.4, width: floor(frame.width * 0.99020 + 0.5) - floor(frame.width * 0.00980 + 0.5), height: floor(frame.height * 0.92452 - 0.1) - floor(frame.height * 0.07548 + 0.1) + 0.21)
        
        //// hexRect
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: hexRect.minX + 0.73000 * hexRect.width,y: hexRect.minY + 0.04000 * hexRect.height))
        bezierPath.addLine(to: CGPoint(x: hexRect.minX + 0.27000 * hexRect.width, y: hexRect.minY + 0.04000 * hexRect.height))
        bezierPath.addLine(to: CGPoint(x: hexRect.minX + 0.04000 * hexRect.width, y: hexRect.minY + 0.50000 * hexRect.height))
        bezierPath.addLine(to: CGPoint(x: hexRect.minX + 0.27000 * hexRect.width, y: hexRect.minY + 0.96000 * hexRect.height))
        bezierPath.addLine(to: CGPoint(x: hexRect.minX + 0.73000 * hexRect.width, y: hexRect.minY + 0.96000 * hexRect.height))
        bezierPath.addLine(to: CGPoint(x: hexRect.minX + 0.96000 * hexRect.width, y: hexRect.minY + 0.50000 * hexRect.height))
        bezierPath.addLine(to: CGPoint(x: hexRect.minX + 0.73000 * hexRect.width, y: hexRect.minY + 0.04000 * hexRect.height))
        bezierPath.close()

        if(colour != nil)
        {
            colour.setFill()
            bezierPath.fill()
        }
        
        if(traceColour != nil && traceWidth != nil)
        {
            bezierPath.lineWidth = CGFloat(traceWidth)
            traceColour.setStroke()
            bezierPath.stroke()
        }
    }
    
    class private func tracePentagon(filledWithColour colour:UIColor!, tracedWithColour traceColour:UIColor!, withWidth traceWidth:Double!, inFrame frame:CGRect)
    {
        //// Polygon Drawing
        let polygonPath = UIBezierPath()
        polygonPath.move(to: CGPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.02000 * frame.height))
        polygonPath.addLine(to: CGPoint(x: frame.minX + 0.99455 * frame.width, y: frame.minY + 0.37931 * frame.height))
        polygonPath.addLine(to:CGPoint(x: frame.minX + 0.80565 * frame.width, y: frame.minY + 0.96069 * frame.height))
        polygonPath.addLine(to:CGPoint(x: frame.minX + 0.19435 * frame.width, y: frame.minY + 0.96069 * frame.height))
        polygonPath.addLine(to: CGPoint(x: frame.minX + 0.00545 * frame.width, y: frame.minY + 0.37931 * frame.height))
        polygonPath.close()
        
        if(colour != nil)
        {
            colour.setFill()
            polygonPath.fill()
        }
        
        if(traceColour != nil && traceWidth != nil)
        {
            polygonPath.lineWidth = CGFloat(traceWidth)
            traceColour.setStroke()
            polygonPath.stroke()
        }

    }
}
