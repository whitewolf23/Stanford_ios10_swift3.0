//
//  CalculatorModel.swift
//  Stanford_1
//
//  Created by Myeongjin kyeong on 2017. 6. 11..
//  Copyright © 2017년 Myeongjin kyeong. All rights reserved.
//

import Foundation

func changeSign(operand : Double) -> Double{
    return -operand
}


//func multiply(op1: Double, op2:Double) -> Double{
//    return op1 * op2
//}



struct CalculatorBrain{
    
    //private
    //클래스 등이 선언된 영역 내에서만 접근 가능
    private var accumulator : Double?
    
    
    private enum Operation{
        //상수
        case constant(Double)
        //연산기호
        case unaryOperation((Double) -> Double)
        
        //이진연산 -> 사칙연산
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    
    
    //딕셔너리 이용
    private var operations: Dictionary<String, Operation> = [
    "π" : Operation.constant(Double.pi), //double.pi
    "e" : Operation.constant(M_E),//m_e
    "√" : Operation.unaryOperation(sqrt),
    "cos" : Operation.unaryOperation(cos),
    "±" : Operation.unaryOperation({-$0}),

//    "±" : Operation.unaryOperation(changeSign),
    
    "×" : Operation.binaryOperation({$0 * $1}),
    "÷" : Operation.binaryOperation({$0 / $1}),
    "+" : Operation.binaryOperation({$0 + $1}),
    "-" : Operation.binaryOperation({$0 - $1}),

    "=" : Operation.equals
        //    "×" : Operation.binaryOperation(multiply),
        
        //    "×" : Operation.binaryOperation({(op1:Double, op2:Double) -> Double in
        //            return op1 * op2
        //            }
        //        ),
    
    ]
    
    //연산 수행
    mutating func performOperation (_ symbol: String){
        
                //선언한 딕셔너리를 받아와서
        if let operation = operations[symbol]{
            switch operation{
            
            case .constant(let value):
                accumulator = value
            
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
                
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOpertion()
                break
            
            }
        
            
        }
        
    
//        //선언한 딕셔너리를 받아와서
//        if let constant = operations[symbol]{
//           
//            accumulator = constant
//            print(accumulator)
//        }
//        

        
//        switch symbol{
//        case "∏":
//            accumulator = Double.pi
//            
//        case "√":
//            if let operand = accumulator{
//                accumulator = sqrt(operand)
//            }
//            
//        default:
//            break
//            
//        }
    }
    private mutating func performPendingBinaryOpertion(){
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil

        }
    }
    
    
    
    private var pendingBinaryOperation : PendingBinaryOperation?
    
    
    private struct PendingBinaryOperation{
        let function: (Double,Double) -> Double
        let firstOperand : Double
        
        func perform(with secondOperand : Double) -> Double{
            return function(firstOperand , secondOperand)
        }
    }
    
    
    
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    
    
    
    var result: Double?{
        get{
            return accumulator
        }
    }
    
    
}
