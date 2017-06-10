//
//  ViewController.swift
//  Stanford_1
//
//  Created by Myeongjin kyeong on 2017. 6. 7..
//  Copyright © 2017년 Myeongjin kyeong. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var display: UILabel!
    
    
    var userIsInTheMiddleOfTyping = false
    
    @IBAction func touchDigit(_ sender : UIButton){
        
        let digit = sender.currentTitle!
        
        if  userIsInTheMiddleOfTyping{
            let textCurrentInDisplay = display!.text!
            display!.text = textCurrentInDisplay + digit
        }else{
            display!.text = digit
            userIsInTheMiddleOfTyping = true
        }
        
        
        print("\(digit) 클릭 됨 " )
        
    }
    
    var displayValue : Double{
        get{
            return Double(display.text!)!
        }
        
        set{
            display.text = String(newValue)
        }
    }
    
    
    
    @IBAction func performOperation(_ sender: UIButton){
        userIsInTheMiddleOfTyping = false
        if let mathematicalSymbol = sender.currentTitle{
            switch mathematicalSymbol{
                case "∏":
//                display!.text = String(Double.pi)
                displayValue = Double.pi

                case "√":
//                    let operand = Double(display!.text!)!
//                    display!.text = String(sqrt(operand))
                displayValue = sqrt(displayValue)
 
            default:
                break
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    
    
}

