//
//  addRestaurantTableViewController.swift
//  memo(1.0)
//
//  Created by jerry on 16/12/27.
//  Copyright © 2016年 jerry. All rights reserved.
//

import UIKit
import CoreData

class addRestaurantTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    var restaurant:Restaurant!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var memoField: UITextField!
    
    
    func 储存数据(){
        //Application(应用),managedObjectContext(托管缓冲区)
        //mocAddRestaurant托管缓存区命名
        let mocAddRestaurant = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
        //"Restaurant"实体名称,Restaurant为实体类
        restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: mocAddRestaurant!) as! Restaurant
        
        restaurant.name = nameField.text!
        restaurant.type = typeField.text!
        restaurant.location = addressField.text!
        restaurant.memo = memoField.text
        //存储为NSData类型的图片(png类型)
        if let image = 相片.image{
            restaurant.photo = UIImagePNGRepresentation(image)
        }
        
        do{
            try mocAddRestaurant?.save()
        }catch{
            print(error)
            return
        }
        
        
        
    }
    
    @IBAction func 保存按钮(_ sender: UIBarButtonItem) {
        
        let textAlert = UIAlertController(title: "提示", message: "🐷主人麻烦输入完整的信息哦", preferredStyle: .alert)
        let textAlertButton = UIAlertAction(title: "嗯好", style: .cancel, handler: nil)
        let textAlertButton1 = UIAlertAction(title: "嗯我是🐷", style: .destructive, handler: nil)
        textAlert.addAction(textAlertButton)
        textAlert.addAction(textAlertButton1)
        if nameField.text == ""{
            self.present(textAlert, animated: true, completion: nil)
        }else if typeField.text == ""{
            self.present(textAlert, animated: true, completion: nil)
        }else if addressField.text == ""{
            self.present(textAlert, animated: true, completion: nil)
        }else{
            储存数据()
            performSegue(withIdentifier: "unwindtoemomo", sender: sender)
        }

        
    }
    //这里的属性位置放回上去
    @IBOutlet weak var 相片: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //移除空行的分割线
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }
    


    //点击行时发生
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //当点击第一行时
        if indexPath.row == 0{
            
        //建立底部弹出框
        let 拍照源 = UIAlertController(title: "choice your photo source", message: "照片来源", preferredStyle: .actionSheet)
        
            //建立弹出框事件
            let 相册 = UIAlertAction(title: "从手机相册选择", style: .default, handler: {aciton in
            //检测是否获取权限（相册),如果有即调回相关函数
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            //不要忘记在相册选择视图初始化后，将代理设为当前视图控制器
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            //present；出现，提出
            self.present(imagePicker, animated: true, completion: nil)
            
            }
        })
            //建立弹出框事件
            let 即拍 = UIAlertAction(title: "拍照📷", style: .default, handler: { ation in
            //检测是否获取权限（相机),如果有即调回相关函数
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker1 = UIImagePickerController()
                    //不要忘记在拍照选择视图初始化后，将代理设为当前视图控制器
                    imagePicker1.delegate = self
                    imagePicker1.allowsEditing = false
                    imagePicker1.sourceType = .camera
                    
                    self.present(imagePicker1, animated: true, completion: nil)
                    
                }
            })
        
            
        //建立弹出框事件
        let 返回 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        //添加弹出框事件
        拍照源.addAction(相册)
        拍照源.addAction(即拍)
        拍照源.addAction(返回)
        self.present(拍照源, animated: true, completion: nil)
        }
        
        //点击已点选项框取消已点击状态
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //键盘回车
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //从媒体信息这个字典数据中查询“原始图像”字典
        相片.image = info[UIImagePickerControllerOriginalImage]as? UIImage
        //图片填充模式:平铺
        相片.contentMode = .scaleAspectFill
        //超出部分裁边
        相片.clipsToBounds = true
        
        let leftCons = NSLayoutConstraint(item: 相片, attribute: .leading, relatedBy: .equal, toItem: 相片.superview, attribute: .leading, multiplier: 1, constant: 0)
        let rightCons = NSLayoutConstraint(item: 相片, attribute:.trailing , relatedBy: .equal, toItem: 相片.superview, attribute: .trailing, multiplier: 1, constant: 0)
        
        let topCons = NSLayoutConstraint(item: 相片, attribute:.top, relatedBy: .equal, toItem: 相片.superview, attribute: .top, multiplier: 1, constant: 0)
        
        let bottomCons = NSLayoutConstraint(item: 相片, attribute:.bottom , relatedBy: .equal, toItem: 相片.superview, attribute: .bottom, multiplier: 1, constant: 0)
        
        leftCons.isActive = true
        rightCons.isActive = true
        topCons.isActive = true
        bottomCons.isActive = true
        
        //让相册选择视图退场
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
