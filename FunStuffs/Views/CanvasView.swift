//
//  CanvasView.swift
//  FunStuffs
//
//  Created by Hemrom, Sheetal Swati on 5/9/18.
//  Copyright © 2018 Hemrom, Sheetal Swati. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var path:UIBezierPath!
    var startingPoint:CGPoint!
    var touchPoint:CGPoint!
    
    override func layoutSubviews() {
        clipsToBounds = true
        isMultipleTouchEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startingPoint = touches.first?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoint = touches.first?.location(in: self)
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        drawPathLayer()
    }
    
    func drawPathLayer(){
        
        let shapelayer = CAShapeLayer()
        shapelayer.path = path.cgPath
        shapelayer.lineWidth = 5
        shapelayer.strokeColor = UIColor.white.cgColor
        shapelayer.fillColor = UIColor.red.cgColor
        layer.addSublayer(shapelayer)
        setNeedsDisplay()
    }
    
    func clearPaths(){
        path = nil
        layer.sublayers = nil
        setNeedsDisplay()
    }
    
}
