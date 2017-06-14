//
//  FaceView.swift
//  standford_view
//
//  Created by Myeongjin kyeong on 2017. 6. 11..
//  Copyright © 2017년 Myeongjin kyeong. All rights reserved.
//

import UIKit

//스토리보드에 현재 코딩한 그림을 자동으로 구현
@IBDesignable

class FaceView : UIView{
    
    @IBInspectable
    var scale : CGFloat = 0.9 {didSet {setNeedsDisplay() }}
    
    @IBInspectable
    var eyesOpen : Bool = false {didSet {setNeedsDisplay() }}
    
    //full smile : 1.0
    //full frown : -1.0
    @IBInspectable
    var mouthCurvature :Double = 1.0 {didSet {setNeedsDisplay() }}
    
    @IBInspectable
    var lineWidth :CGFloat = 5.0 {didSet {setNeedsDisplay() }}
    
    
    @IBInspectable
    var color :UIColor = UIColor.blue {didSet {setNeedsDisplay() }}
    
    
    
    func changeScale(byReactingTo pinchRecognizer:  UIPinchGestureRecognizer){
        switch pinchRecognizer.state {
        case .changed, .ended:
            scale *= pinchRecognizer.scale
            print("scale : \(scale)")
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    

    //원의 반지름
    private var skullRadius : CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    //원 정렬
    private var skullCenter : CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private enum Eye{
        case left
        case right
    }
    
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath{
        func centerOfEye(_eye: Eye) -> CGPoint{
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1 ) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(_eye: eye)
        
        let path : UIBezierPath
        if eyesOpen{
           path = UIBezierPath(arcCenter: eyeCenter , radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        }else{
            path = UIBezierPath()
            path.move(to: CGPoint( x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint( x: eyeCenter.x + eyeRadius, y: eyeCenter.y))

        }
        
        
       
        path.lineWidth = lineWidth
        return path
        
    }
    
    
    
    private func pathForMouth() -> UIBezierPath{
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight
        )
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)

        //        let path = UIBezierPath(rect: mouthRect)

        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        
        path.lineWidth = lineWidth
        
        return path

    }
    
    
    
    
    private func pathForSkull() -> UIBezierPath{
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        path.lineWidth = 5
        return path
      
    }
    
    
    //실제 그리는 구동 부분

    override func draw(_ rect: CGRect) {
         color .set()
      
        // 스트로크 : 그리다 로 이해?
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
       
    
    }
    
    
    private struct Ratios{
        static let skullRadiusToEyeOffset : CGFloat = 3
        static let skullRadiusToEyeRadius : CGFloat = 10
        static let skullRadiusToMouthWidth : CGFloat = 1
        static let skullRadiusToMouthHeight : CGFloat = 3
        static let skullRadiusToMouthOffset : CGFloat = 3

    }
    
    
}
