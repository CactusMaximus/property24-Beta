//
//  LoginViewController.swift
//  p24Beta0.1
//
//  Created by Reverside Software Solutions on 2017/07/26.
//  Copyright © 2017 Reverside Software Solutions. All rights reserved.
//

import UIKit
import SDWebImage

class User{
    static var userId = 0
    static var userName = ""
    static var favouriteProperty = ""
    static var userAvatar = "1"
    static var avatar:UIImageView?
}

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    var loggedInUser = "empty"
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var invalidLoginLabel: UILabel!
    
    @IBAction func loginButton(_ sender: UIButton) {
        validateLogin(arg:true,completion:{(success)-> Void in
              let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! ViewController
            
            
            
            

            
             self.navigationController?.pushViewController(viewController, animated: true)
        })
        
    }
    

    @IBAction func registerButton(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func validateLogin(arg:Bool, completion:@escaping ([NSDictionary])->()){
        
        let username = self.username.text!
        let password = self.passwordField.text!
        
        let urlString = "http://localhost:8080/property24RESTService/webresources/entity.property/login?username=\(username)&password=\(password)"
        
        let url = URL(string:urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error != nil{
                print(error!)
            }else{
                do{
                    
                    if let parseData = try JSONSerialization.jsonObject(with:data!) as? [NSDictionary]{
                        DispatchQueue.main.async{
                           // let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! ViewControlle
                            
                            let userId = parseData[0]["userId"]
                            let userName = parseData[0]["userName"]
                          //  let avatar = parseData[0]["avatar"]
                            //self.loggedInUser = parseData[0]["username"]
                            //Success, user can log in
                            print(userId!)
                            print(userName!)
                            
                            User.userId = userId as! Int
                            User.userName = userName as! String
                            //User.userAvatar = avatar as! String
                            
                             //self.loggedInUser = parseData[0]["username"]
                            //Success, user can log in
    
                            completion(parseData)
                        }
                    }
               
                }catch _ as NSError{
                    print("Incorrect login details")
                    self.invalidLoginLabel.text = "*Incorrect login details"
                    self.view.setNeedsDisplay()
                    
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
                    
                    viewController.invalidLoginLabel?.text = "incorrect login details"
                    
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            
            }.resume()
        
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
