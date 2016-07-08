//
//  LeadersTableViewController.swift
//  SolCen_Assignment
//
//  Created by Saranyan Mahadevan on 07/07/16.
//  Copyright © 2016 saran. All rights reserved.
//

import UIKit

class LeadersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var leaders:Array = [NSMutableDictionary]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let documentsPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let jsonPath: String = (documentsPath as NSString).stringByAppendingPathComponent("json")
        let dict: NSDictionary = NSDictionary.init(contentsOfFile: jsonPath)!
        leaders = dict.valueForKey("items") as! Array
        
        self.tableView!.registerNib(UINib(nibName: "LeadersTableViewCell", bundle: nil), forCellReuseIdentifier: "LeadersTableViewCellID")
        
        self.title = "World Leaders"
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return leaders.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: LeadersTableViewCell = tableView.dequeueReusableCellWithIdentifier("LeadersTableViewCellID") as! LeadersTableViewCell
        cell.leadersDictionary = leaders[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
