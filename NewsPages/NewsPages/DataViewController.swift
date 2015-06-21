//
//  DataViewController.swift
//  NewsPages
//
//  Created by Marko Wallin on 21.6.2015.
//  Copyright (c) 2015 Rule of tech. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: News?

    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "tableCell"
	var tableData = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView!.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: News = dataObject {
            self.dataLabel!.text = obj.title
            println("obj.title=\(obj.title)")
            
            getDataFromFileWithSuccess(obj.title) { (data) -> Void in
                var parseError: NSError?
                let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions.AllowFragments, error:&parseError)
            
                if let response = parsedObject as? NSDictionary {
					//println("response=\(response)")
					if let responseData = response["responseData"] as? NSDictionary {
					if let feed = responseData["feed"] as? NSDictionary {
						//println("feed=\(feed)")
						if let entries = feed["entries"] as? NSArray {
							//println("entries=\(entries)")
							
							dispatch_async(dispatch_get_main_queue(), {
								self.tableData = entries
								self.tableView!.reloadData()
							})

						}
                    }
					}
                }
            }
        } else {
            self.dataLabel!.text = ""
        }
    }

	func getDataFromFileWithSuccess(source: String, success: ((data: NSData) -> Void)) {
		//println("getDataFromFileWithSuccess, source=\(source)")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let filePath = NSBundle.mainBundle().pathForResource(source, ofType:"json")
        
            var readError:NSError?
            if let data = NSData(contentsOfFile:filePath!,
                options: NSDataReadingOptions.DataReadingUncached, error:&readError) {
                success(data: data)
            }
        })
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.tableData.count
    }
    
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		//let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: self.cellIdentifier)
		let cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
		
		let highfiEntry : NSMutableDictionary = self.tableData[indexPath.row] as! NSMutableDictionary
		//        println("highfiEntry: \(highfiEntry)")
		
		if let title = highfiEntry["title"] as? String {
			cell.textLabel!.text = title
		}
		if let desc = highfiEntry["publishedDateJS"] as? String {
			cell.detailTextLabel?.text = desc
		}
		
		return cell
	}
	
}

