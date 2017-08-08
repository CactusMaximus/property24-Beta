//
//  PropertyDetailViewController.swift
//  p24Beta0.1
//
//  Created by Reverside Software Solutions on 2017/07/25.
//  Copyright © 2017 Reverside Software Solutions. All rights reserved.
//

import UIKit
import SDWebImage

class PropertyDetailViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UITextView!
    
    @IBOutlet weak var bedroomsLabel: UILabel!
    @IBOutlet weak var garagesLabel: UILabel!
    @IBOutlet weak var bathroomsLabel: UILabel!
    @IBOutlet weak var favouriteStar: UIImageView!
    
    @IBAction func addToFavourites(_ sender: UIButton) {
        addFavourite(completion:{(success)-> Void in
            
        })
        //self.buttonLabel.setTitle("Added", for: .normal)
        favouriteStar.image = UIImage(named: "afterStar")
        
        UIView.perform(UISystemAnimation.delete, on: [self.favouriteStar], options:UIViewAnimationOptions.transitionFlipFromLeft, animations: {}, completion: {finished in
            
        })

        
    }
    
    func addFavourite(completion:@escaping (NSDictionary)->()){
        
        let propertyId = property["id"] as! Int
        let userId = User.userId
        
        
        let urlString = "http://localhost:8080/property24RESTService/webresources/entity.userProperty/addToFavourites?propertyId=\(propertyId)&userId=\(userId)"
        
        let url = URL(string:urlString)
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            if error != nil{
                print(error!)
            }else{
                do{
                    
                    if let parseData = try JSONSerialization.jsonObject(with:data!) as? NSDictionary{
                        DispatchQueue.main.async{
                            
                            completion(parseData)
                        }
                    }
                    
                }catch _ as NSError{
                    
                }
            }
            
            }.resume()
        
        
        
    }

    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var property : NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let price = property["price"] as! Int
        let pricestring = String(describing: price)
        priceLabel.text = "R \(pricestring)"
       
        let bedrooms = property["bedrooms"] as! Int
        let bedroomsString = String(describing: bedrooms)
        bedroomsLabel.text = bedroomsString
        
        let bathrooms = property["bathrooms"] as! Int
        let bathroomsString = String(describing: bathrooms)
        bathroomsLabel.text = bathroomsString
        
        let garages = property["garages"] as! Int
        let garagesString = String(describing: garages)
        garagesLabel.text = garagesString
        
        
        
        
        
        
        let shortUrl = property["thumbnailRef"] as! String
        
        let imageUrl:URL? = URL(string:"http://localhost:8080/property24RESTService/webresources/entity.property/image/test?image=\(shortUrl)")
        
        if imageUrl != nil{
            imageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "tempHouse"), options: SDWebImageOptions.highPriority)
        }

        
        
        
        longDescriptionLabel.text = property["longDescription"] as! String
        
        
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
