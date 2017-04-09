//
//  RestaurantDeatilTableViewController.swift
//  memo(1.0)
//
//  Created by jerry on 16/12/4.
//  Copyright © 2016年 jerry. All rights reserved.
//

import UIKit
import CoreData

class RestaurantDetailTableViewController: UITableViewController {


    @IBOutlet weak var rantingBtn: UIButton!
    
    @IBOutlet weak var DetailImage: UIImageView!
    

    
    var restaurant:Restaurant!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        DetailImage.image = UIImage(data: restaurant.photo! as Data)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //更改背景颜色
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        //移除空行的分割线
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //更改分割线颜色
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        title = restaurant.name
        
        
        //估算行需求高
        tableView.estimatedRowHeight = 50
        
        //自动进行调整
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let rangtingimage = restaurant.rating{

        rantingBtn.setImage(UIImage(named: rangtingimage), for: UIControlState())
        
        }else{
            rantingBtn.setImage(UIImage(named: "评价"), for: UIControlState())
        }
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailRestaurantCell", for: indexPath) as! DetailCellTableViewCell
        
        switch indexPath.row{
        case 0:
            cell.detailkey.setFAText(prefixText: "", icon: FAType.FAHome, postfixText: "名字", size: 20)
            cell.detailValue.text = restaurant.name
        case 1:
            cell.detailkey.setFAText(prefixText: "", icon: FAType.FACutlery, postfixText: " 类别", size: 19)
            cell.detailValue.text = restaurant.type
        case 2:
            cell.detailkey.setFAText(prefixText: "", icon: FAType.FAMapMarker, postfixText: "  地址", size: 20)
            cell.detailValue.text = restaurant.location
        case 3:
            cell.detailkey.setFAText(prefixText: "", icon: FAType.FAComment, postfixText: "备注", size: 18)
            cell.detailValue.text = restaurant.memo
        default :
            cell.detailkey.text = ""
            cell.detailValue.text = ""
        }
        // Configure the cell...
        //单元格变透明
            cell.backgroundColor = UIColor.clear
        return cell
    }
    
    @IBAction func backtoRestaurantDetail(_ segue:UIStoryboardSegue){
        
        if let reviewVC = segue.source as? reviewViewController{
            if let rating = reviewVC.rating{
                self.restaurant.rating = rating
                self.rantingBtn.setImage(UIImage(named: rating), for: UIControlState())
                
                
                    let mocdetailRestaurant = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
                    
                
                    
                    do{
                        try mocdetailRestaurant?.save()
                    }catch{
                        print(error)
                        return
                    }
            }
            
        }
        
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//        if segue.identifier == "showReview"{
//            let reviewVC = segue.destinationViewController as! reviewViewController
//            
//            reviewVC.restaurants = self.restaurants
//            
//            reviewVC.indexNumberReview = indexNumber
//        
//        }
        if segue.identifier == "showMap"{
            let mapViewVC = segue.destination as! MapViewController
            mapViewVC.restaurant = self.restaurant
            
    }
  }


}
