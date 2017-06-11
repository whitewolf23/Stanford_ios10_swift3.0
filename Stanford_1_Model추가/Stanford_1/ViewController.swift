//
//  ViewController.swift
//  Stanford_1
//
//  Created by Myeongjin kyeong on 2017. 6. 7..
//  Copyright © 2017년 Myeongjin kyeong. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var display: UILabel!
    
    //사용자가 입력중에 잇는 상태값 
    //어딘 가의 저장
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
    
    //자동으로 디스플레이 안에 뭐가 있는 지 추적 
    //연산 프로퍼티
    var displayValue : Double{
        //가져오기
        //diplayValue값을 가져오기 위한 코드 
        get{
            return Double(display.text!)!
        }
        
        //설정하기 
        //누군가 변수를 설정할때 실행되는 코드
        set{
            display.text = String(newValue)
        }
    }
    
    
    private var brain = CalculatorBrain()
    
    
    @IBAction func performOperation(_ sender: UIButton){
        //사용자가 미입력시 해당
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
       
        
        //수학기호를 인식한다면
        //calculatorbrain 에서 모델 작업
        if let mathematicalSymbol = sender.currentTitle{
         brain.performOperation(mathematicalSymbol)
        }
        
        if let result = brain.result{
            displayValue = result
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    
    
}

