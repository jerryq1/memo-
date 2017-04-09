//
//  RestaurantTableViewController.swift
//  memo(1.0)
//
//  Created by jerry on 16/11/30.
//  Copyright © 2016年 jerry. All rights reserved.
//

import UIKit
import CoreData





class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate ,UISearchResultsUpdating{
    
    
    var frcr:NSFetchedResultsController<NSFetchRequestResult>!
    
    var restaurant:Restaurant!
    
    var restaurants:[Restaurant] = []
    
    //定义一个搜索控制器变量
    var sc:UISearchController!
    
    //定义一个空餐馆数组，以保存搜索结果
    var searchRestaurants:[Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //创建一个实例，参数为搜索结果的控制器；如果是nil，则结果显示搜索条所在的视图中。
        //如果需要不同的搜索结果样式，需要指定一个新的。如果是nil，则和所在视图(如列表的单元格样式相同)
        sc = UISearchController(searchResultsController: nil)
        
        //搜索结果更新者为当前控制器
        sc.searchResultsUpdater = self
        //搜索时背景不变暗
        sc.dimsBackgroundDuringPresentation = false
        //去除searchbar边框线
        sc.searchBar.searchBarStyle = UISearchBarStyle.minimal
        //将列表的页眉视图指定为搜索条
        tableView.tableHeaderView = sc.searchBar
        
        //更改背景颜色
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        //移除空行的分割线
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //更改分割线颜色
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        //隐藏主页返回按钮字的，仅留剪头"<"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //memoTableView背景
        self.tableView.backgroundColor = UIColor.clear
        let imgback = UIImage(named:"壁纸1")
        let imgbackV = UIImageView(image: imgback)
        self.tableView.backgroundView = imgbackV
        


        
        
        
//        数据库空值则预加载内容()
        取回数据()
        
    }
    


    func refreshViewDidRefresh(_ refreshView: BreakOutToRefreshView) {
        // this code is to simulage the loading from the internet
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(NSEC_PER_SEC * 3)) / Double(NSEC_PER_SEC), execute: { () -> Void in
            refreshView.endRefreshing()
        })
    }
    //添加一个筛选器方法，返回包含搜索字符串的所有餐馆
    //Swift中数组自带filter方法，参数是一个闭包。筛选符合条件的元素，组成一个新数组返回。
    //containsString检测一个字符串是否包含另一个字符串
    func searchFilter(_ textToSearch:String){
        searchRestaurants = restaurants.filter({ (r) -> Bool in
            return r.name.contains(textToSearch) || r.location.contains(textToSearch) || r.type.contains(textToSearch)
        })
    }
    
    //当用户点搜索条，或者更改搜索文字，这个方法会被调用
    //通过实现这个方法，我们让搜索控制器显示搜索结果。
    func updateSearchResults(for searchController: UISearchController) {
        //获取搜索栏中的文字，筛选餐馆然后刷新列表
        if var textToSearch = sc.searchBar.text{
            //加空格正常搜索
            textToSearch = textToSearch.trimmingCharacters(in: CharacterSet.whitespaces)
            searchFilter(textToSearch)
            tableView.reloadData()
        }
    }
    
//    func 数据库空值则预加载内容(){
//        
//            
//            //添加默认数据
//            
//            //Application(应用),managedObjectContext(托管缓冲区)
//            let mocrestaurant = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
//        
//            if restaurants.isEmpty == true && restaurants.count == 0{
//            restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: mocrestaurant!) as! Restaurant
//            
//            restaurant.name = "咖啡胡同"
//            restaurant.location = "香港上环德辅道西78号G/F圣诞节哈数据库多哈时间快点好"
//            restaurant.type = "咖啡 & 茶店"
//            restaurant.isImportant = false
//            restaurant.rating = "rating"
//            
//            
//            do{
//                try mocrestaurant?.save()
//            }catch{
//                print(error)
//                return
//            }
//            tableView.reloadData()
//            
//            print("有\(restaurants.count)个数组)")
//            
//            取回数据()
//            
//        }else if restaurants.isEmpty == false{
//            取回数据()
//        }
//    }

    func 取回数据(){
 
        //取回数据
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        
        //指定取回数据结果如何排序,ascending升降序
        let sd = NSSortDescriptor(key: "isImportant", ascending: false)
        request.sortDescriptors = [sd]
        
        let mocrestaurant = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
        frcr = NSFetchedResultsController(fetchRequest: request, managedObjectContext: mocrestaurant!, sectionNameKeyPath: nil, cacheName: nil)
        frcr.delegate = self
        
        do{
            try frcr.performFetch()
            restaurants = frcr.fetchedObjects as! [Restaurant]
        }catch{
            print(error)
            }
        
    }

    /*当数据库内容发生变化时，NSFetchedResultsControllerDelegate协议的以下方法会被调用:
    
    //当控制器开始处理内容变化时
    controllerWillChangeContent(_:)
    
    //内容发生变更时
    controller(_:didChangeObject:atIndexPath:forChangeType:newIndexPath:)
    
    //当控制器已经处理完内容变更时
    controllerDidChangeContenet(_:)
    */
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case.insert:
            if let _newIndexPath = newIndexPath{
                tableView.insertRows(at: [_newIndexPath], with: .automatic)
            }
        case.delete:
            if let _indexPath = indexPath{
                tableView.deleteRows(at: [_indexPath], with: .automatic)
            }
        case.update:
            if let _indexPath = indexPath{
                tableView.reloadRows(at: [_indexPath], with: .automatic)
            }
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as! [Restaurant]
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
        //当搜索控制器活动时，显示搜索结果的条数
        return sc.isActive ? searchRestaurants.count : restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let 分享菜单 = UITableViewRowAction(style: .default, title: "分享") { (action, indexPath) -> Void in
//            let 分享行为 = UIAlertController(title: "分享", message: "你需要分享到", preferredStyle: .actionSheet)
//            let qq = UIAlertAction(title: "qq空间", style: .default, handler: nil)
//            let weixin = UIAlertAction(title: "微信朋友圈", style: .default, handler: nil)
//            let renren = UIAlertAction(title: "人人网", style: .default, handler: nil)
//            let 返回 = UIAlertAction(title: "返回", style: .cancel, handler: nil)
//            分享行为.addAction(qq)
//            分享行为.addAction(weixin)
//            分享行为.addAction(renren)
//            分享行为.addAction(返回)
//            self.present(分享行为, animated: true, completion: nil)}
        let 删除行为 = UITableViewRowAction(style: .normal, title: "🗑Del") { (action, IndexPath) -> Void in
            
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
            
            let restaurantstoDel = self.frcr.object(at: indexPath) as! Restaurant
            
            moc?.delete(restaurantstoDel)
            
            do{
                try moc?.save()
            }catch{
                print(error)
            }
            
            tableView.reloadData()
        }
        
        删除行为.backgroundColor = UIColor(red: 242/255, green: 116/255, blue: 119/255, alpha: 1)
    
        return [删除行为]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ememoCell", for: indexPath) as! RestaurantTableViewCell
        
        let r = sc.isActive ? searchRestaurants[indexPath.row] : restaurants[indexPath.row]

        cell.restaurantName.text = r.name
        cell.restaurantLocation.text = r.location
        cell.restaurantType.text = r.type
        cell.restaurantView.image = UIImage(data:r.photo! as Data)
        cell.restaurantView.layer.cornerRadius = cell.restaurantView.frame.size.width/2
        cell.restaurantView.clipsToBounds = true
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        if let ratingImage = r.rating{
            cell.restaurantImage.image = UIImage(named: ratingImage)
        }else{
            cell.restaurantImage.image = UIImage(named: "评价")
        }

        return cell
    }



    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
//        if sc.active == true{
//            return false
//        }else{
//            return true
//        }
        
        return !sc.isActive
        
    }
  

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showRestaurantDetail"{
            let destVC = segue.destination as! RestaurantDetailTableViewController
            destVC.restaurant = sc.isActive ? searchRestaurants[(tableView.indexPathForSelectedRow!.row)] : restaurants[(tableView.indexPathForSelectedRow!.row)]
            
            //当转场进入后一个场景时隐藏tabbar
            destVC.hidesBottomBarWhenPushed = true
            
            //搜索完成后搜索控制器退场
            sc.isActive = false
//            destVC.restaurants = self.restaurants
//            let number1 = tableView.indexPathForSelectedRow!.row as Int
//            destVC.indexNumber = number1
//            print(number1)
            
    }
  
    }
    
    @IBAction func unwindtoememo(_ segue:UIStoryboardSegue){
        
    }
}
