//
//  RegisterViewController.swift
//  p24Beta0.1
//
//  Created by Reverside Software Solutions on 2017/07/26.
//  Copyright © 2017 Reverside Software Solutions. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var cell: UITextField!
    

    @IBOutlet weak var avatar1Button: UIButton!
    @IBOutlet weak var avatarButton2: UIButton!
    @IBOutlet weak var avatarButton3: UIButton!
    @IBOutlet weak var avatarButton4: UIButton!
    
    var chosenAvatar = ""
    
    @IBAction func avatar1Clicked(_ sender: UIButton) {
        chosenAvatar = "1"
        avatar1Button.alpha = 1
        avatarButton2.alpha = 0.75
        avatarButton3.alpha = 0.75
        avatarButton4.alpha = 0.75
    }
    
    @IBAction func avatar2Clicked(_ sender: UIButton) {
        chosenAvatar = "2"
        avatarButton2.alpha = 1
        avatar1Button.alpha = 0.75
        avatarButton3.alpha = 0.75
        avatarButton4.alpha = 0.75
        
    }
    @IBAction func avatar3Clicked(_ sender: UIButton) {
        chosenAvatar = "3"
        avatarButton3.alpha = 1
        avatarButton2.alpha = 0.75
        avatar1Button.alpha = 0.75
        avatarButton4.alpha = 0.75
    }
    
   
    @IBAction func avatar4Clicked(_ sender: UIButton) {
        chosenAvatar = "4"
        avatarButton4.alpha = 1
        avatarButton3.alpha = 0.75
        avatarButton2.alpha = 0.75
        avatar1Button.alpha = 0.75
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        registerUser(arg:true,completion:{(success)-> Void in
        
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! ViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        })

        
    }
    
    @IBOutlet weak var agentSwitch: UISwitch!
    
    @IBAction func agentSwitch(_ sender: UISwitch) {
        if(agentSwitch.isOn){
            print("Switch on ")
        }else{
            print("Switch off")
        }
    }
    
    
    func registerUser(arg:Bool, completion:@escaping (NSDictionary)->()){
    
        let username = self.username.text!
        let password = self.password.text!
        let cell = self.cell.text!
        let email = self.email.text!
        var isAdmin : Bool
        
        
      
        User.userName = username
        
        if(agentSwitch.isOn){
            isAdmin = true
        }else{
            isAdmin = false
        }
        
        
        let urlString = "http://localhost:8080/property24RESTService/webresources/entity.user/register?username=\(username)&password=\(password)&cellNumber=\(cell)&email=\(email)&isAdmin=\(isAdmin)"
        
        let url = URL(string:urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error != nil{
                print(error!)
            }else{
                do{
                    
                    if let parseData = try JSONSerialization.jsonObject(with:data!) as? NSDictionary{
                         DispatchQueue.main.async{
                            
                  

                          
            
                            print(parseData)
                            
    
                            completion(parseData)
                        }
                    }
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
            }.resume()
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatar1Button.layer.cornerRadius = 22
        avatar1Button.layer.masksToBounds = true
        
        avatarButton2.layer.cornerRadius = 22
        avatarButton2.layer.masksToBounds = true
        
        avatarButton3.layer.cornerRadius = 22
        avatarButton3.layer.masksToBounds = true
        
        avatarButton4.layer.cornerRadius = 22
        avatarButton4.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
