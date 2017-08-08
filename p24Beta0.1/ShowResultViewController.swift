//
//  ShowResultViewController.swift
//  p24Beta0.1
//
//  Created by Reverside Software Solutions on 2017/07/20.
//  Copyright © 2017 Reverside Software Solutions. All rights reserved.
//

import UIKit
import SDWebImage


class ShowResultViewController: UITableViewController{
    

   
    struct Property{
        var shortDesc : Any
        var price : Int
    }
    
    
    
    var itemsTest : [String] = ["We", "Heart", "Swift"]
    var json:[NSDictionary] = []
    var imageArray:[UIImage] = []
    
    var bedrooms = 0
    var bathrooms = 0
    var minPrice = 0
    var maxPrice = 0
    var toLet = true

    @IBOutlet var out: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            print("\(bedrooms)")
            print("\(bathrooms)")
            print("\(minPrice)")
            print("\(maxPrice)")
            print("Received image:\(imageArray)")
     
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier:"propertyCell")
        
    
        }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = self.out.dequeueReusableCell(withIdentifier: "propertyCell")!
        let cell:PropertyResultTableViewCell = self.out.dequeueReusableCell(withIdentifier: "PropertyResultTableViewCell", for:indexPath) as! PropertyResultTableViewCell
        
   
        //cell.textLabel?.text = self.itemsTest[indexPath.row]
        
        
                let shortDesc = json[indexPath.row]["shortDescription"]
                let longDesc = json[indexPath.row]["longDescription"]
                let price = json[indexPath.row]["price"]
        
        
        let bedrooms = json[indexPath.row]["bedrooms"] as! Int
        let bedroomsString = String(describing: bedrooms)
        cell.bedroomsLabel.text = bedroomsString
        
        let bathrooms = json[indexPath.row]["bathrooms"] as! Int
        let bathroomsString = String(describing: bathrooms)
        cell.bathroomsLabel.text = bathroomsString
        
        let garages = json[indexPath.row]["garages"] as! Int
        let garageString = String(describing: garages)
        cell.garagesLabel.text = garageString
        
        
        cell.label1.text = shortDesc as? String
       
        if let itemName = cell.label2{
            itemName.text = shortDesc as? String
        }
        
       //getImage(url:"sdfs",completion:{(success)-> Void in
         //  print("hIT")
          //cell.imageView?.image = imageArray[0]
        
        let imageView = cell.imageOutlet
        

        
        let shortUrl = json[indexPath.row]["thumbnailRef"] as! String
        
         let imageUrl:URL? = URL(string:"http://localhost:8080/property24RESTService/webresources/entity.property/image/test?image=\(shortUrl)")
        
    
        
        if imageUrl != nil{
          
             imageView?.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "tempHouse"), options: SDWebImageOptions.highPriority)
            
        }
        
        
        
        
       // })

                //cell.label2.text = shortDesc as? String
        
                
                print(shortDesc!)
                print(longDesc!)
                print(price!)
        
        
    
       // cell.textLabel?.text = (self.mutubleArray[indexPath.row] as! String)
        
        return cell
    }

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row)")
        
         let viewController = self.storyboard?.instantiateViewController(withIdentifier:"PropertyDetailViewController") as! PropertyDetailViewController
        
             viewController.property = json[indexPath.row]
        
         self.navigationController?.pushViewController(viewController, animated: true)
        
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
