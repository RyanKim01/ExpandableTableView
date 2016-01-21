//
//  Document.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/20/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//

import Foundation

class Document {
    
    var subdocuments: [DocumentPart] = []
    var title: String
    var description: String
 
    // this makes some tableview silliness easier, but is kinda gross to put here :/
    var isExpanded: Bool = false
    
    init(dict: [String:AnyObject]) {
        // parse dict to generate a bunch of documents, add them to self.documents
        self.title = dict["Title"] as! String
        self.description = dict["Description"] as! String
        
        let documentPartsDicts = dict["Parts"] as! [Dictionary<String,AnyObject>]
        
        for dictionary in documentPartsDicts {
            let documentPart = DocumentPart(dict: dictionary)
            self.subdocuments.append(documentPart)
        }
    }
    
}

extension Document: Equatable {
    
}

func ==(lhs: Document, rhs: Document) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}