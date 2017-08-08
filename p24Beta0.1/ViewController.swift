//
//  ViewController.swift
//  p24Beta0.1
//
//  Created by Reverside Software Solutions on 2017/07/20.
//  Copyright © 2017 Reverside Software Solutions. All rights reserved.
//

import UIKit
import SDWebImage

class SingletonPropertyList{
    
    var price : Int = 0
    static let sharedInstance = SingletonPropertyList()
    private init(){}
}


class ViewController: UIViewController {
    
    @IBOutlet weak var nodataLabel: UILabel!
    @IBOutlet weak var leftHouse: UIImageView!
    @IBOutlet weak var rightHouse: UIImageView!
    
    @IBOutlet weak var avatar: UIImageView!
    
    struct Property{
        var shortDesc : Any
        var price : Int
    }
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var loggedInLabel: UILabel!
    var mutubleArray : NSMutableArray = []
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        let UIImageLeft:UIImage = UIImage(named: "houseIconRight")!
        let UIImageRight = UIImage(named: "houseIconLeft")!
        
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            finalToLet = true
            leftHouse.image = UIImageLeft
            rightHouse.image = nil
        case 1:
            finalToLet = false
            rightHouse.image = UIImageRight
            leftHouse.image = nil
        default:
            break;
        }
        
       
        
        print(finalToLet)
    }
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var finalMinPrice : Int = 0
    var finalMaxPrice : Int = 14500
    var finalToLet : Bool = true
    
    
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        let bedrooms = "\(Int(stepper.value))"
        bedroomOutput.text = "\(bedrooms)"
    }
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var bedroomOutput: UILabel!
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nodataLabel.text = ""
        
        let username = User.userName
        self.loggedInLabel.text = "Logged in as: \(username)"
        profilePic.layer.cornerRadius = 17
        profilePic.layer.masksToBounds = true
    
          }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var bathroomsOutput: UILabel!
    @IBOutlet weak var bathStepper: UIStepper!

    @IBAction func bathStepperChanged(_ sender: UIStepper) {
        let bathrooms = "\(Int(bathStepper.value))"
        bathroomsOutput.text = "\(bathrooms)"
    }
    
    
    @IBOutlet weak var minPriceOutput: UILabel!
    
    @IBAction func minPriceSliderChanged(_ sender: UISlider) {
      
        finalMinPrice = Int(sender.value)
        minPriceOutput.text = "R \(finalMinPrice)"
    }
    
    @IBAction func maxPriceSliderChanged(_ sender: UISlider) {
        finalMaxPrice = Int(sender.value)
        maxPriceOutput.text = "R \(finalMaxPrice)"
    }
    
    @IBAction func changeView(_ sender: UIButton) {
        testJSONResult(arg:true,completion:{(success)-> Void in
               print("hit")
            })
        
      

    }
    
    
    func getImage(url:String,completion:@escaping (UIImage)->()){
        print(url)
        let url = URL(string: "http://localhost:8080/property24RESTService/webresources/entity.property/image/test?image=\(url)")
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            DispatchQueue.main.async{
                
                if error != nil {
                    print("some error!")
                } else {
                    if let bach = UIImage(data: data!) {
                        
                        
                        //self.image.image = bach
                        print(bach)
                        completion(bach)
                    }
                }
            }
        })
        task.resume()
        
    }

    
    @IBOutlet weak var maxPriceOutput: UILabel!
    @IBOutlet weak var minPriceSlider: UISlider!
    @IBOutlet weak var maxPriceSlider: UISlider!
    
    func testJSONResult(arg:Bool, completion:@escaping ([NSDictionary])->()){
        
        let bedrooms = "\(bedroomOutput.text!)"
        let bathrooms = "\(bathroomsOutput.text!)"

        
        let urlString = "http://localhost:8080/property24RESTService/webresources/entity.property/search?toLet=\(finalToLet)&bedrooms=\(bedrooms)&bathrooms=\(bathrooms)&minPrice=\(self.finalMinPrice)&maxPrice=\(self.finalMaxPrice)"
        
        print(urlString)
       
        let url = URL(string:urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error != nil{
                print(error!)
            }else{
                do{
                    
                    if let parseData = try JSONSerialization.jsonObject(with:data!) as? [NSDictionary]{
                        DispatchQueue.main.async{
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowResultViewController") as! ShowResultViewController
                            
                            viewController.json = parseData
                            
                            
                            //for set in parseData{
                               // var thumb = set["thumbnailRef"] as! String
                                
                           // self.getImage(url:thumb,completion:{(success)-> Void in
                                //print("hIT getImage")
                                //viewController.imageArray.append(success)
                                
                                //cell.imageView?.image = success
                                
                            
                            //viewController.bedrooms = Int(bedrooms)!
                           // viewController.bathrooms = Int(bathrooms)!
                            //viewController.minPrice = self.finalMinPrice
                            //viewController.maxPrice = self.finalMinPrice
                           // viewController.toLet = self.finalToLet
                            
                                            //               })
                           // }
                            if(parseData.count > 0){
                                self.nodataLabel.text = ""
                                
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }else{
                                print("*** Oops, no data returned")
                                self.nodataLabel.text = "*No data"
                                
                            }
                            
                            
                      
                               // self.navigationController?.pushViewController(viewController, animated: true)
                       

                        }
                    }
                    
                    
                   // let resultSize = parseData.count
                    //print("Results: " + "\(resultSize)")
                    
                    
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
}

