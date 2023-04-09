//
//  String+ToHTML.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf16) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
