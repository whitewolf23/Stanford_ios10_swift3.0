//
//  ViewController.swift
//  standford_view
//
//  Created by Myeongjin kyeong on 2017. 6. 14..
//  Copyright © 2017년 Myeongjin kyeong. All rights reserved.
//

import UIKit

class ViewController : UIViewController{
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            
            
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappniess))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappniess))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            
            updateUI()
        }
    }
    
    func increaseHappniess(){
        expression = expression.happier
    }
    
    func decreaseHappniess(){
        expression = expression.sadder

    }
    
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended{
            let eyes : FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    var expression = FacialExpression(eyes: .open, mouth: .grin){
        didSet{
            updateUI()
        }
    }
    
    
    
    private func updateUI(){
        switch expression.eyes {
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
     
        }
    faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    
    }

    
    private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5 , .frown: -1.0, .smile:1.0, .netrual:0.0, .smirk:-0.5]

    
    
}
