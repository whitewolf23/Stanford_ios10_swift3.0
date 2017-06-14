//
//  FaceExpression.swift
//  standford_view
//
//  Created by Myeongjin kyeong on 2017. 6. 14..
//  Copyright © 2017년 Myeongjin kyeong. All rights reserved.
//

import Foundation

struct FacialExpression {
    
    let eyes: Eyes
    let mouth : Mouth
    
    
    enum Eyes : Int{
        case open
        case closed
        case squinting
    }
    
    
    
    
    enum Mouth : Int{
        case frown
        case smirk
        case netrual
        case grin
        case smile
        
        var sadder : Mouth{
            return Mouth(rawValue : rawValue - 1) ?? .frown
        }
        
        var happier : Mouth{
            return Mouth(rawValue : rawValue + 1) ?? .smile
        }
    }
    
    
    
    
    var sadder: FacialExpression{
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier: FacialExpression{
        return FacialExpression(eyes: self.eyes, mouth: self.mouth.happier)
    }
    
    
    
    
    
    
}




