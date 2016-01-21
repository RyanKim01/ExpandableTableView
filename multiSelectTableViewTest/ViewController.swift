//
//  ViewController.swift
//  multiSelectTableViewTest
//
//  Created by Ryan Kim on 1/19/16.
//  Copyright © 2016 RKProduction. All rights reserved.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {
    
    var result: [Criterion]! = []
    var keychain: Keychain!
    var allCriteria: [Criterion]! = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keychain = Keychain(service: "example")
        result = Array()
        
        let critPlist: String = NSBundle.mainBundle().pathForResource("critToDoc", ofType: "plist")!
        let criteria = NSArray(contentsOfFile: critPlist)!
        
        for criterionDict in criteria {
            if let criterionDict = criterionDict as? [String : AnyObject] {
                let criterion = Criterion(dict: criterionDict)
                allCriteria.append(criterion)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
         self.performSegueWithIdentifier("toNewVC", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toNewVC") {
            let svc = segue.destinationViewController as! ViewController2
            svc.criteria = result
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("selected  \(allCriteria[indexPath.row])")
        result.append(allCriteria[indexPath.row])
        print(result)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.selected {
                cell.accessoryType = .Checkmark
            }
        }
        
//        if let sr = tableView.indexPathsForSelectedRows {
//            print("didDeselectRowAtIndexPath selected rows:\(sr)")
//        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("deselected  \(allCriteria[indexPath.row])")
       result = result.filter ({$0 != allCriteria[indexPath.row] })
        print(result)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .None
        }
        
//        if let sr = tableView.indexPathsForSelectedRows {
//            print("didDeselectRowAtIndexPath selected rows:\(sr)")
//        }
    }
}




extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCriteria.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.accessoryType = .None
        cell.textLabel?.text = allCriteria[indexPath.row].title
        
        return cell
    }
}
    
    
    
