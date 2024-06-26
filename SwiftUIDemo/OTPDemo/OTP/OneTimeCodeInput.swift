//
//  OneTimeCodeInput.swift
//  SwiftUIDemo
//
//  Created by Rahul Chaurasia on 31/01/24.
//

import Foundation
import UIKit
import SwiftUI
 
struct OneTimeCodeInput : UIViewRepresentable {
    
    typealias UIViewType = UITextField
    
    
    let index : Int
    @Binding var codeDict :[Int : String]
    @Binding var firstResponderIndex : Int
    var oncommit : (() -> Void)?
    
    // MARK : Internal Type
    class Coordinator: NSObject, UITextFieldDelegate {
        
        let index : Int
        @Binding var codeDict :[Int : String]
        @Binding var firstResponderIndex : Int
        
        init(index: Int, codeDict: Binding<[Int:String]>,firstResponderIndex : Binding<Int>) {
            self.index = index
            self._codeDict = codeDict
            self._firstResponderIndex = firstResponderIndex
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText)else{ return false }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            //deleting
            if string.isBackspace {
                
                codeDict.updateValue("", forKey: index)
                firstResponderIndex = max(0, index - 1)
                return false
            }
            
            //typing
            //pasting
            
            for i in index..<min(codeDict.count, index + string.count){
                
                codeDict.updateValue(string.stringAt(index: i - index), forKey: i)
                firstResponderIndex = min(codeDict.count - 1, index + string.count)
            }
            
              
            
            
            return false
        }
        
        
    }
    
    class BackspaceTextField : UITextField {
        
        var onDelete: (()-> Void)?
        
        init(onDelete: ( () -> Void)? = nil) {
            self.onDelete = onDelete
            
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func deleteBackward() {
           
            super.deleteBackward()
            
            onDelete?()
        }
    }
   
    func makeCoordinator() -> Coordinator {
        .init(index: index, codeDict: $codeDict, firstResponderIndex: $firstResponderIndex)
    }
    
    func makeUIView(context: Context) -> UITextField {
        
       // let tf = UITextField()
        let tf = BackspaceTextField {
            firstResponderIndex = max(0, index - 1)
        }
        tf.delegate = context.coordinator
        //.numberPad
        tf.keyboardType =  .asciiCapableNumberPad
        tf.textContentType = .oneTimeCode
        tf.font = .preferredFont(forTextStyle: .largeTitle)
        tf.textAlignment = .center
        return tf
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        uiView.text = codeDict[index]
        
        if index == firstResponderIndex {
           
            uiView.becomeFirstResponder()
        }
        
//Note : here our index when reach the last index of OTP
//bec we set logic firstResponderIndex = min(codeDict.count - 1, index + string.count)
// mean firstResponderIndex at the end set last codeDict
        if index == firstResponderIndex, codeDict.values.filter({!$0.isEmpty}).count == codeDict.count {
            
            print("Done \(firstResponderIndex)")
            oncommit?()
        }
        
    }
    
    
  
    
   
}
