//
//  MRCheckBoxButton.swift
//  swift-sample
//
//  Created by Mayank Rikh on 21/03/17.
//  Copyright © 2017 Mayank Rikh. All rights reserved.
//

import UIKit

class MRCheckBoxButton: UIButton {
    
    @IBInspectable var tickColor : UIColor = UIColor.clear{
        
        didSet{
            
            if let tempLayer = searchForLayer(){
                
                tempLayer.strokeColor = tickColor.cgColor
                
                return

            }
        }
    }
    
    @IBInspectable var tickBackgroundFillColor : UIColor = UIColor.clear{
        
        didSet{

            self.layer.backgroundColor = tickBackgroundFillColor.cgColor
        }
    }

    
    @IBInspectable var tickWidth : CGFloat = 2.0{
        
        didSet{
            
            if let tempLayer = searchForLayer(){
                
                tempLayer.lineWidth = tickWidth
                
                return
                
            }
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.clear{
        
        didSet{
            
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable var borderWidth : CGFloat = 0.0{
        
        didSet{
            
            layer.borderWidth = borderWidth
        }
    }

    
    override var isSelected: Bool{
        
        willSet {
            
            if newValue{
                
                fillColor()
                
            }else{
                
                clearColor()
            }
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        //initially it should be clear as did set gets called before and sets it to default color
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        createTick()
    }
    
    override func layoutSubviews() {
        
        if let tempLayer = searchForLayer(){
            
            tempLayer.path = calculatePath().cgPath
        }
        
        super.layoutSubviews()
    }
    
    func createTick(){
        
        let tickLayer = CAShapeLayer()
        
        tickLayer.path = calculatePath().cgPath;
        
        tickLayer.lineWidth = tickWidth
 
        tickLayer.fillColor = UIColor.clear.cgColor
        
        //so that we don't draw it right away
        tickLayer.strokeEnd = 0.0
        
        tickLayer.strokeColor = tickColor.cgColor
        
        tickLayer.setValue(1005, forKey: "animationTag")
        
        layer.addSublayer(tickLayer)
    }
    
    //MARK: Private
    
    private func fillColor(){

        UIView.animate(withDuration: 0.2, animations: {
            
            self.layer.backgroundColor = self.tickBackgroundFillColor.cgColor
            
        }) { (animated) in
            
            self.showTick()
        }
    }
    
    private func clearColor(){
        
        self.clearTick()
        
        UIView.animate(withDuration: 0.2, animations: {

            self.layer.backgroundColor = UIColor.clear.cgColor
        })
    }
    
    private func showTick(){
        
        animating(fromValue: 0, andToValue: 1, andShouldClear: false)
    }
    
    private func clearTick(){
        
        animating(fromValue: 1, andToValue: 0, andShouldClear: true)
    }
    
    private func animating(fromValue from:Int, andToValue to:Int, andShouldClear clear:Bool){
        
        //get our shapeLayer reference
        guard let shapeLayer = searchForLayer() else {
            
            return
        }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = 0.2
        
        animation.fromValue = from
        
        animation.toValue = to
        
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionLinear)
        
        if clear{
            
            if shapeLayer.strokeEnd != 1.0{
                
                return;
            }
            
            shapeLayer.removeAnimation(forKey: "strokeEnd")
            
            shapeLayer.strokeEnd = 0.0
            
        }else{
            
            if shapeLayer.strokeEnd != 0.0{
                
                return;
            }
            
            shapeLayer.strokeEnd = 1.0
        }
        
        // Do the actual animation
        shapeLayer.add(animation, forKey: "strokeEnd")
    }
    
    private func searchForLayer() -> CAShapeLayer?{
        
        var shapeLayer : CAShapeLayer?
        
        guard let subLayers = layer.sublayers else{
            
            return shapeLayer
        }
        
        for layer in subLayers{
            
            guard let value =  layer.value(forKey: "animationTag"), let intValue = value as? Int else {
                
                continue
            }
            
            if intValue == 1005{
                
                shapeLayer = layer as? CAShapeLayer
                
                break
            }
        }
        
        return shapeLayer
    }
    
    private func calculatePath() -> UIBezierPath{

        let path = UIBezierPath()
        
        let wholeButtonWidth = bounds.size.width
        
        let wholeButtonHeight = bounds.size.height
        
        let firstPoint = CGPoint(x: wholeButtonWidth/2.0 - wholeButtonWidth/4.0, y: wholeButtonHeight/2.0)
        
        let secondPoint = CGPoint(x:firstPoint.x + wholeButtonWidth/8.0, y: firstPoint.y + wholeButtonHeight/4.0)
        
        let thirdPoint = CGPoint(x: secondPoint.x + wholeButtonWidth/2.0, y:secondPoint.y - wholeButtonHeight/2.0)
        
        path.move(to: firstPoint)
        
        path.addLine(to: secondPoint)
        
        path.addLine(to: thirdPoint)
        
        return path
    }
}
