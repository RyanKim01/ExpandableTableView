//
//  DocumentPart.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/20/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//

import Foundation

class DocumentPart {
    
    var title: String
    var partNumber: Int?
    var progress: String?
    
    init(dict: [String: AnyObject]) {
        self.title = dict["Title"] as! String
    }
}