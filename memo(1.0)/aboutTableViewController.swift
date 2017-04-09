//
//  aboutTableViewController.swift
//  memo(1.0)
//
//  Created by jerry on 17/1/24.
//  Copyright © 2017年 jerry. All rights reserved.
//

import UIKit


class aboutTableViewController: UITableViewController,BreakOutToRefreshDelegate {
    
    var refreshView: BreakOutToRefreshView!
    var sectionTitle = ["评分和反馈","感谢"]
    var sectionContent = [["在App Stroe上给我评分","反馈意见请发邮箱"],["邮箱地址:      jerry_q1@sina.com","下拉有彩蛋"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "aboutCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshView = BreakOutToRefreshView(scrollView: tableView)
        refreshView.refreshDelegate = self
        tableView.addSubview(refreshView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        refreshView.removeFromSuperview()
        refreshView = nil
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshView.scrollViewDidScroll(scrollView)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        refreshView.scrollViewWillBeginDragging(scrollView)
    }
    
    func refreshViewDidRefresh(_ refreshView: BreakOutToRefreshView) {
        // this code is to simulage the loading from the internet
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(NSEC_PER_SEC * 3)) / Double(NSEC_PER_SEC), execute: { () -> Void in
            refreshView.endRefreshing()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath)
        
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        // Configure the cell...
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section{
        //Safari跳转
//        case 0:
//            if indexPath.row == 0{
//                if let url = NSURL(string: "http://www.baidu.com"){
//                    UIApplication.sharedApplication().openURL(url)
//                }
//                
//            }
        //WebView跳转
//        case 1:
//            if indexPath.row == 1{
//                performSegue(withIdentifier: "goWeb", sender: self)
//            }
        //SFSafariViewController跳转
//        case 2:
//            if let url = NSURL(string: "http://www.baidu.com"){
//                let sfVC = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
//                presentViewController(sfVC, animated: true, completion: nil)
//            }
//        default:break
//            }
            tableView.deselectRow(at: indexPath, animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
