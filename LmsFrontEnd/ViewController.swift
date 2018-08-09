//
//  ViewController.swift
//  LmsFrontEnd
//
//  Created by Rohan on 06/08/18.
//  Copyright © 2018 Infogain. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    static let firstname = "firstName"
    static let message = "message"
    static let lastname = "lastName"
    var t : String = ""
    var s: Int = 1

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         checkget()
    
        

}

    

    func checkget()
    {

        Alamofire.request("http://172.18.81.141:9091/api/viewAll").responseJSON(completionHandler:{
            (response) in
            print(response)
            print("****")
            print(response.result)
            if let array = response.result.value as? [[String: Any]] {
                //If you want array of task id you can try like
                let taskArray = array.flatMap { $0[ViewController.firstname] as? String }
                let taskArray1 = array.flatMap{ $0[ViewController.lastname] as? String }
                print(taskArray)
                print(taskArray1)
            }
        })



    }

 
    @IBOutlet weak var enter: UILabel!
    @IBAction func status(_ sender: Any) {
        
    }
    
    
    func validUser(message: String)
    {
            if message == "Employee does not exist"
            {
                let alertController = UIAlertController(title: "Invalid Data", message: "Please enter valid credentials", preferredStyle: .alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil) //You can use a block here to handle a press on this button
                
                alertController.addAction(actionOk)
                
                self.present(alertController, animated: true, completion: nil)
        }
        
    }
   
    
    @IBAction func valids(_ sender: Any) {
        
        let url:String = "http://172.18.81.141:9091/api1/loginUserName"
        print(user.text!)
        if(user.text! != "")
        {
            let parameters:[String:Any] =
                [
                    "userName": "\(user.text!)"
                    
            ]
            Alamofire.request(url,method:.post,parameters:parameters,encoding:JSONEncoding.default,headers:nil).responseJSON{
                response in
                print(response)
                print("******")
                print(response.result)
                if let array = response.result.value  {
                    //If you want array of task id you can try like
                    let loguser:Dictionary = array as! Dictionary<String,Any>
                    let message:String = loguser[ViewController.message] as! String
                    self.t = message
                    self.enter.text = message
                    self.user.text = ""
                    
                    self.validUser(message: message)
                    
                    print(self.t)
                }else{
                    print("Not Working")
                    
                }
                
            }
            
        }
        else
        {
            self.enter.text = "Enter Username"
        }
        
    }
    
    
    
}




