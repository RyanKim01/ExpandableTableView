//
//  DocumentPartCell.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/20/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//

import UIKit

class DocumentPartCell: UITableViewCell {

    @IBOutlet weak var documentPartTitle: UILabel!
    var documentPart: DocumentPart? {
        didSet {
            if let documentPart = documentPart {
                documentPartTitle.text = documentPart.title
            }
        }
    }
    

}
