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
        let defaultCell = tableView.cellForRowAtIndexPath(indexPath)
        let documentCell = tableView.cellForRowAtIndexPath(indexPath) as! DocumentCell!
    
//        let documentPartCell = tableView.cellForRowAtIndexPath(indexPath) as! DocumentPartCell
        if defaultCell == documentCell {
            documentCell.document!.isExpanded = !documentCell.document!.isExpanded
            
            updateDocumentsAndParts(indexPath.section)
            
//            let numberOfParts = criteria[indexPath.section].documents[indexPath.row].subdocuments.count
            let numberOfParts = documentsAndDocumentParts[indexPath.section].count
            if documentCell.document!.isExpanded {
                insertRows(indexPath.row + 1, y: indexPath.row + numberOfParts, section: indexPath.section)
            } else {
                deleteRows(indexPath.row + 1, y: indexPath.row + numberOfParts, section: indexPath.section)
            }
        }
//        else if defaultCell == documentPartCell {
//            print("haha")
//        }
        
      
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
}


extension ViewController2: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return criteria.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return criteria[section].title
    }
    
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

