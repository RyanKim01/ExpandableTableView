//
//  ViewController2.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/19/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//




import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var criteria: [Criterion]! {
        didSet {
            for _ in 0..<criteria.count {
                documentsAndDocumentParts.append([])
            }
        }
    }
    
    var documentsAndDocumentParts:[[AnyObject]!] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for section in 0..<criteria.count {
            updateDocumentsAndParts(section)
        }
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertRows(x: Int, y: Int, section: Int) {
        var indexPaths: [NSIndexPath] = []
        for index in x...y {
            indexPaths.append(NSIndexPath(forRow: index, inSection: section))
        }
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func deleteRows(x: Int, y: Int, section: Int) {
        var indexPaths: [NSIndexPath] = []
        for index in x...y {
            indexPaths.append(NSIndexPath(forRow: index, inSection: section))
        }
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func updateDocumentsAndParts(section: Int) {
        var sectionArray: [AnyObject] = []
        let documentsArray = criteria[section].documents
        
        for document in documentsArray {
            sectionArray.append(document)
            if document.isExpanded {
                for subdocument in document.subdocuments {
                    sectionArray.append(subdocument)
                }
            }
        }
        
        documentsAndDocumentParts[section] = sectionArray
    }
    
}


extension ViewController2: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // this needs to be updated to work with DocumentCell and DocumentPartCell
        if documentsAndDocumentParts[indexPath.section][indexPath.row].dynamicType == Document.self {
            let documentCell = tableView.cellForRowAtIndexPath(indexPath) as! DocumentCell
            documentCell.document!.isExpanded = !documentCell.document!.isExpanded
            
            updateDocumentsAndParts(indexPath.section)

            let document =  documentsAndDocumentParts[indexPath.section][indexPath.row] as! Document
            let numberOfParts = document.subdocuments.count
           
            
            
            if documentCell.document!.isExpanded {
                insertRows(indexPath.row + 1, y: indexPath.row + numberOfParts, section: indexPath.section)
            } else {
                deleteRows(indexPath.row + 1, y: indexPath.row + numberOfParts, section: indexPath.section)
            }
        } else if documentsAndDocumentParts[indexPath.section][indexPath.row].dynamicType == DocumentPart.self {
            let documentPart = documentsAndDocumentParts[indexPath.section][indexPath.row] as! DocumentPart
            print("\(documentPart.title)")
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = criteria[section]
        
        let headerView = UIView(frame: CGRectMake(0,0, tableView.frame.size.width, 60))
        headerView.backgroundColor = UIColor.cyanColor()
        headerView.layer.borderColor = UIColor.redColor().CGColor
        headerView.layer.borderWidth = 1.0;
        
        let headerLabel = UILabel(frame: CGRectMake(5,2, tableView.frame.size.width - 5, 18))
        headerLabel.text = model.title
        headerLabel.textAlignment = NSTextAlignment.Center
//        headerLabel.textColor = [UIColor whiteColor];
//        headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
//        headerLabel.text = @"This is the custom header view";
//        headerLabel.textAlignment = NSTextAlignmentLeft;
//        
        headerView.addSubview(headerLabel)
        
        return headerView
        
        
        
        
        
//        let  headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! CustomHeaderCell
//         let model = criteria[section]
//        
//        switch(section) {
//        case section:
//            if let criterion = model as? Criterion {
//                headerCell.criterion = criterion
//            }
//            break
//        default:
//            break
//        }
//       
//        
//        return headerCell
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
    
    
    
}
      

    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! DocumentCell!
//        cell.document!.isExpanded = false
//        
//        updateDocumentsAndParts(indexPath.section)
//        
//        let numberOfParts = criteria[indexPath.section].documents[indexPath.row].subdocuments.count
//        deleteRows(indexPath.row + 1, y: indexPath.row + numberOfParts, section: indexPath.section)
//    }



extension ViewController2: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return criteria.count
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return criteria[section].title
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentsAndDocumentParts[section].count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = documentsAndDocumentParts[indexPath.section][indexPath.row]
        var cell: UITableViewCell!
        
        if let document = model as? Document {
            let documentCell = tableView.dequeueReusableCellWithIdentifier("documentCell", forIndexPath: indexPath) as! DocumentCell
            documentCell.document = document
            cell = documentCell
        } else if let documentPart = model as? DocumentPart {
            let documentPartCell = tableView.dequeueReusableCellWithIdentifier("documentPartCell", forIndexPath: indexPath) as! DocumentPartCell
            documentPartCell.documentPartTitle.text = documentPart.title
            cell = documentPartCell
        }
        
        return cell
    }
}

