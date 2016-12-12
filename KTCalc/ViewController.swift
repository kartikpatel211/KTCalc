//
//  ViewController.swift
//  KTCalc
//
//  Created by Kartik Patel on 12/9/16.
//  Copyright © 2016 Kartik Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var val1 = "0"
    var val2 = "0"
    var oper = ""
    var txtCalc = "0"
    var cellReusableIdentifier = "cell"
    
    var sections = 5
    var columns = 4
    let sectionInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    
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
        txtCalc = arrCalcButtons[(indexPath.section * columns) + indexPath.row]
        print(txtCalc)
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
