//
//  Criteria.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/20/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//
import Foundation

class Criterion {

    var documents: [Document] = []
    var title: String
    var description: String
    
    init(dict: [String:AnyObject] ) {
        // parse dict to generate a bunch of documents, add them to self.documents
        self.title = dict["Title"] as! String
        self.description = dict["Description"] as! String
        
        let documentsDicts = dict["Documents"] as! [Dictionary<String,AnyObject>]
        
        for dictionary in documentsDicts {
            let document = Document(dict: dictionary)
            self.documents.append(document)
        }
    }

}

extension Criterion: Equatable {

}

func ==(lhs: Criterion, rhs: Criterion) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}