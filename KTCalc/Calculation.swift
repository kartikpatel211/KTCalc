//
//  Calculation.swift
//  KTCalc
//
//  Created by Paresh Patel on 12/10/16.
//  Copyright © 2016 Kartik Patel. All rights reserved.
//

import UIKit

class Calculation: NSObject {

    var val1 = "0"
    var val2 = "0"
    var oper = ""
    var txtCalc = "0"
    
    func calcResult(val1: String, oper : String, val2 : String)-> String{
        var res = ""
        
        if isIntValue(val: val1) && isIntValue(val: val2) {
            // perform Int Operation
            
            switch oper {
            case "+":
                res = "\( ((val1 as NSString).intValue) + ((val2 as NSString).intValue))"
            case "-":
                res = "\( ((val1 as NSString).intValue) - ((val2 as NSString).intValue))"
            case "*":
                res = "\( ((val1 as NSString).intValue) * ((val2 as NSString).intValue))"
            case "/":
                res = "\( ((val1 as NSString).intValue) / ((val2 as NSString).intValue))"
            default:
                res = ""
            }
        } else {
            // perform Double Operation
            
            switch oper {
            case "+":
                res = "\( ((val1 as NSString).doubleValue) + ((val2 as NSString).doubleValue))"
            case "-":
                res = "\( ((val1 as NSString).doubleValue) - ((val2 as NSString).doubleValue))"
            case "*":
                res = "\( ((val1 as NSString).doubleValue) * ((val2 as NSString).doubleValue))"
            case "/":
                res = "\( ((val1 as NSString).doubleValue) / ((val2 as NSString).doubleValue))"
            default:
                res = ""
            }
        }
        return res
    }
    
    func isIntValue(val : String) -> Bool {
        return (val as NSString).doubleValue.truncatingRemainder(dividingBy: 1) == 0
    }
    
    func plus(){
        val1 = txtCalc
        oper = "+"
        txtCalc = "0"
    }
    func minus(){
        val1 = txtCalc
        oper = "-"
        txtCalc = "0"
    }
    func multiply(){
        val1 = txtCalc
        oper = "*"
        txtCalc = "0"
    }
    func division(){
        val1 = txtCalc
        oper = "/"
        txtCalc = "0"
    }
    
    func isEqualCalc(){
        val2 = txtCalc
        
        txtCalc = calcResult(val1: val1, oper: oper, val2: val2)
    }
    func clear(){
        val1 = "0"
        val2 = "0"
        oper = ""
        txtCalc = "0"
    }
    func plusMinus(){
        if isIntValue(val: txtCalc) {
            txtCalc = "\((txtCalc as NSString).intValue * -1)"
        } else {
            txtCalc = "\((txtCalc as NSString).doubleValue * -1)"
        }
    }
    func percentage(){
        
        if (val1 as NSString).intValue != 0 {
            /*if isIntValue(val: txtCalc) {
             txtCalc = "\((val1 as NSString).intValue * (txtCalc as NSString).intValue / 100)"
             } else {*/
            txtCalc = "\((val1 as NSString).doubleValue * (txtCalc as NSString).doubleValue / 100)"
            /*}*/
        } else {
            if isIntValue(val: txtCalc) {
                txtCalc = "\((txtCalc as NSString).intValue / 100)"
            } else {
                txtCalc = "\((txtCalc as NSString).doubleValue / 100)"
            }
        }
    }
}
