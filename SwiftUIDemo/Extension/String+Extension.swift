//
//  String+Extension.swift
//  SwiftUIDemo
//
//  Created by Rahul Chaurasia on 28/07/23.
//

import Foundation
/*
 let requiredFormat = currDate.toDateString(inputDateFormat: "yyyy-MM-dd", ouputDateFormat:
     "dd-MM-yyyy")

     self.endobTf.text! = requiredFormat
     self.strPosp_DOB  = currDate

     print("POSP Date Display",requiredFormat)
     
      self.endobTf.text? = currDate
 */

extension String
{
    func toDateString( inputDateFormat inputFormat  : String,  ouputDateFormat outputFormat  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date!)
        
        
    }
    
    //without removing spaces between words
    var removeSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ !$0.isEmpty }).joined(separator: " ")
    }
    
    
    var removeSpecialCharactersWithoutSpace: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).filter({ !$0.isEmpty }).joined()
    }
    
    var digitOnly: String { filter { ("0"..."9").contains($0) } }
}
