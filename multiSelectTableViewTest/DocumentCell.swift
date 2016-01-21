//
//  documentCell.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/20/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//

import UIKit

class DocumentCell: UITableViewCell {
    var isExpanded: Bool = false
    var document: Document? {
        didSet {
            if let document = document {
                documentTitle.text = document.title
            }
        }
    }
    
    @IBOutlet weak var documentTitle: UILabel!
}
