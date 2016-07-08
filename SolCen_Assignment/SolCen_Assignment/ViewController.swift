//
//  ViewController.swift
//  SolCen_Assignment
//
//  Created by Saranyan Mahadevan on 07/07/16.
//  Copyright © 2016 saran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var submitButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.submitButton.enabled = false
        self.title = "Welcome"
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        self.view.backgroundColor = UIColor.lightGrayColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        submitButton.backgroundColor = UIColor.blackColor()
        submitButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        submitButton.layer.cornerRadius = 5.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitAction(sender: AnyObject)
    {
        
        
        let documentsPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let jsonPath: String = (documentsPath as NSString).stringByAppendingPathComponent("json")
        
        if (!NSFileManager.defaultManager().fileExistsAtPath(jsonPath)) {

                
                var postDictionary: Dictionary<String, String> = [:]
                postDictionary["emailId"] = self.emailTextField.text!
                
                
                do {
                    let jsonToSend = try NSJSONSerialization.dataWithJSONObject(postDictionary, options: NSJSONWritingOptions(rawValue: 0))
                    
                    
                    let url: NSURL = NSURL(string:"http://surya-interview.appspot.com/list")!
                    let urlRequest = NSMutableURLRequest(URL: url)
                    urlRequest.HTTPMethod = "POST"
                    urlRequest.HTTPBody = jsonToSend
                    
                    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
                    let session = NSURLSession(configuration: config)
                    
                    let task = session.dataTaskWithRequest(urlRequest, completionHandler: {(data, response, error) in
                        
                        guard error == nil
                            else
                        {
                            return
                        }
                        self.processData(data!)
                        self.navigateToList()
                    });
                    task.resume()
                    
                } catch {
                }
            
        }
        else
        {
            self.navigateToList()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let validEmailTest = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return validEmailTest.evaluateWithObject(testStr)
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var text:NSString = textField.text! as NSString
        text = text.stringByReplacingCharactersInRange(range, withString: string)
        if isValidEmail(text as String)
        {
            self.submitButton.enabled = true
        }
        else
        {
            self.submitButton.enabled = false
        }
        
        return true
    }
    
    func processData(data: NSData) {

        do
        {
            if let json : AnyObject? = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            {
                let documentsPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
                let jsonPath: String = (documentsPath as NSString).stringByAppendingPathComponent("json")
                json!.writeToFile(jsonPath, atomically: true)
            
            }
        }
        catch
        {
            
        }
    }
    
    func navigateToList()
    {
        dispatch_async(dispatch_get_main_queue()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LeadersTableViewControllerID") as! LeadersTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

