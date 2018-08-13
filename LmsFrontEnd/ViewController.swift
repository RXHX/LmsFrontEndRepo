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
    
    // admin view
    
    @IBOutlet weak var adminname: UILabel!
    
    @IBOutlet weak var adminbutt: UIButton!
    
    @IBOutlet weak var GO: UIButton!
    
    @IBOutlet weak var goyo: UIButton!
    @IBOutlet weak var enterpass: UILabel!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var nextButton: UIButton!

     @IBOutlet weak var enter: UILabel!
   
    
    // sign up outlets
    
    
    @IBOutlet weak var first: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var last: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    
    @IBOutlet weak var mess: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkget()
        
        
    }
    
    
    
    @IBAction func log(_ sender: Any) {
        
        let url:String = "http://34.226.210.225:8080/LMS/api1/loginPassword"
        print(pass.text!)
        if(pass.text! != "")
        {
            let parameters:[String:Any] =
                [
                    "password": "\(pass.text!)"
                    
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
                    self.enterpass.text = message
                    print(self.t)
                    if(self.enterpass.text == "Admin")
                    {
                        self.goyo.setTitle("Login", for: UIControlState.normal)
                    }
                    else if(self.enterpass.text == "User"){
                        self.adminbutt.setTitle("Login", for: UIControlState.normal)
                    }
                    else{
                        self.pass.text = ""
                        print(self.t)
                    }
                }else{
                    print("Not Working")
                    
                }
                
            }
            
        }
        else
        {
            self.enterpass.text = "Enter Password"
        }
        }
    
    
    @IBAction func valids(_ sender: Any) {
        
        let url:String = "http://34.226.210.225:8080/LMS/api1/loginUserName"
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
                    if(self.enter.text == "Employee exist")
                    {
                        self.GO.setTitle("Next", for: UIControlState.normal)
                        //        self.y = self.user.text!
                    }
                    else{
                        self.user.text = ""
                        print(self.t)
                    }
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
    @IBAction func signup(_ sender: Any) {
        
        let url:String = "http://34.226.210.225:8080/LMS/api/add"
        print("First Name: \(first.text! )")
        
        
        if(first.text != "" && last.text != "" && username.text != "" && password.text != "")
        {
            let parameters:[String:Any] =
                [
                    "firstName" : "\(first.text!)",
                    "lastName" : "\(last.text!)",
                    "userName" : "\(username.text!)",
                    "password" : "\(password.text!)"
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
                    self.mess.text = message
                    if(self.mess.text == "User already registered")
                    {
                        self.mess.text = "Enter Unique Username"
                    }
                    else{
                        self.mess.text = ""
                        print(self.t)
                    }
                
                    if(self.mess.text != "Enter Unique Username")
                    {
                    let alert = UIAlertController(title: "Congratulation", message: "Successful SignUp", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.present(alert, animated: true, completion: nil)
                    self.first.text = ""
                    self.last.text = ""
                    self.username.text = ""
                    self.password.text = ""
                    
                
                    }
                
                
                
                }else{
                    print("Not Working")
                    
                }
                
            }
            
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Credentials are missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    



    

    func checkget()
    {
      
        Alamofire.request("http://34.226.210.225:8080/LMS/api/viewAll").responseJSON(completionHandler:{
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


}

   
    

    







