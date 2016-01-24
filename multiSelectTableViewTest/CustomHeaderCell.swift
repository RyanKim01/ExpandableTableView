//
//  CustomHeaderCell.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/23/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    
//    var isExpanded: Bool = false
    var criterion: Criterion? {
        didSet {
            if let criterion = criterion {
                headerLabel.text = criterion.title
            }
        }
    }
    
    
    
}
