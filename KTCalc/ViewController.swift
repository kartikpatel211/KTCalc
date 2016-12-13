//
//  ViewController.swift
//  KTCalc
//
//  Created by Kartik Patel on 12/9/16.
//  Copyright © 2016 Kartik Patel. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //var arrInputs = [String]()
    
    var val1 = "0"
    var val2 = "0"
    var oper = ""
    var cellReusableIdentifier = "cell"
    
    var sections = 5
    var columns = 4
    let sectionInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    var lastKey = ""
    
    
    @IBOutlet weak var txtCalcVal: UITextField!
    @IBOutlet weak var cvCalc: UICollectionView!
    
    var lblHeight = 0.0
    
    
    var arrCalcButtons = ["AC", "C", "%", "/", "7", "8", "9", "*", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "+-", "="]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cvCalc.reloadData()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        print(sections)
        return sections
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("section: \(section) - numberOfItemsInSection: \(columns)")
        return columns
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(columns + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(columns)
        lblHeight = Double(widthPerItem)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReusableIdentifier, for: indexPath)
        
        let lbl = UILabel(frame: CGRect.init(x: 0 , y: 0, width:  lblHeight, height: lblHeight))
        lbl.text = arrCalcButtons[(indexPath.section * columns) + indexPath.row]
        lbl.textAlignment = .center
        print("indexPath - section - row: \(indexPath.section),\(indexPath.row) val: \(lbl.text)")
        
        cell.addSubview(lbl)
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let txtCalc = arrCalcButtons[(indexPath.section * columns) + indexPath.row]
        print(txtCalc)
        
        /*switch txtCalc {
        //case "7", "8", "9", "4", "5", "6", "1", "2", "3", "0":
            //setResultText(result: txtCalcVal.text! + txtCalc)
        //case ".", "+-":
            //setResultText(result: txtCalcVal.text! + txtCalc)
        case "+", "-", "*", "/", "%":
            arrInputs.append(txtCalcVal.text!)
            arrInputs.append(txtCalc)
        case "=":
            if lastKey == "=" {
                arrInputs.removeLast()
            }
            arrInputs.append(txtCalcVal.text!)
        case "C":
            arrInputs.removeLast()
        case "AC":
            arrInputs.removeAll()
        default:
            break
        }*/
        
        switch txtCalc {
        case "7", "8", "9", "4", "5", "6", "1", "2", "3", "0":
            if ["+", "-", "*", "/", "%", "="].contains(lastKey) {
                setResultText(result: txtCalc)
            } else {
                setResultText(result: txtCalcVal.text! + txtCalc)
            }
        case "+":
            if lastKey == "+" {
                return
            }
            plus()
        case "-":
            if lastKey == "-" {
                return
            }
            minus()
        case "*":
            if lastKey == "*" {
                return
            }
            multiply()
        case "/":
            if lastKey == "/" {
                return
            }
            division()
        case "=":
            isEqualCalc()
        case "+-":
            plusMinus()
        case ".":
            dcimalPoint()
        case "C":
            clear()
        case "AC":
            allClear()
        case "%":
            percentage()
        default:
            break
        }
        
        //print(arrInputs)
        lastKey = txtCalc
    }
    func isIntValue(val : String) -> Bool {
        return (val as NSString).doubleValue.truncatingRemainder(dividingBy: 1) == 0
    }
    func plus(){
        isEqualCalc() // to perform cosicutive operand operation like 1+2+3+4...
        val1 = txtCalcVal.text!
        oper = "+"
    }
    func minus(){
        isEqualCalc() // to perform cosicutive operand operation like 1-2-3-4...
        val1 = txtCalcVal.text!
        oper = "-"
    }
    func multiply(){
        isEqualCalc() // to perform cosicutive operand operation like 1*2*3*4...
        val1 = txtCalcVal.text!
        oper = "*"
    }
    func division(){
        isEqualCalc() // to perform cosicutive operand operation like 1/2/3/4...
        val1 = txtCalcVal.text!
        oper = "/"
    }
    func isEqualCalc(){
        val2 = txtCalcVal.text!
        setResultText(result: calcResult(val1: val1, oper: oper, val2: val2))
    }
    func calcResult(val1: String, oper : String, val2 : String)-> String{
        var res = ""
        
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
            res = txtCalcVal.text!
        }
        return res
    }
    func clear(){
        setResultText(result: "0")
    }
    func allClear(){
        val1 = "0"
        val2 = "0"
        oper = ""
        setResultText(result: "0")
    }
    func plusMinus(){
        if isIntValue(val: txtCalcVal.text!) {
            setResultText(result: "\((txtCalcVal.text! as NSString).intValue * -1)")
        } else {
            setResultText(result: "\((txtCalcVal.text! as NSString).doubleValue * -1)")
        }
    }
    func percentage(){
        
        if (val1 as NSString).intValue != 0 {
            /*if isIntValue(val: txtCalc) {
             txtCalc = "\((val1 as NSString).intValue * (txtCalc as NSString).intValue / 100)"
             } else {*/
            setResultText(result: "\((val1 as NSString).doubleValue * (txtCalcVal.text! as NSString).doubleValue / 100)")
            /*}*/
        } else {
            if isIntValue(val: txtCalcVal.text!) {
                setResultText(result: "\((txtCalcVal.text! as NSString).intValue / 100)")
            } else {
                setResultText(result: "\((txtCalcVal.text! as NSString).doubleValue / 100)")
            }
        }
    }
    func dcimalPoint(){
        if txtCalcVal.text!.contains(".") {
            return
        }
        txtCalcVal.text = txtCalcVal.text! + "."
    }
    func setResultText(result : String){
        if isIntValue(val: result) {
            txtCalcVal.text = "\((result as NSString).intValue)"
        } else {
            txtCalcVal.text = "\((result as NSString).doubleValue)"
        }
    }
}
