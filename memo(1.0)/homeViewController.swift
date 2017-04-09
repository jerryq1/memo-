//
//  homeViewController.swift
//  memo(1.0)
//
//  Created by jerry on 2017/2/10.
//  Copyright © 2017年 jerry. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {
    



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        imageView.frame = self.view.frame
        imageView.image = UIImage(named: "导航页1")
        self.view.addSubview(imageView)
        

        UIApplication.shared.isStatusBarHidden = true
        
        self.perform(#selector(presentView), with: nil, afterDelay: 3)

        // Do any additional setup after loading the view.
    }
    
    func presentView(){
        let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
        let firstPage = mainStoryboard.instantiateViewController(withIdentifier: "tabbar1")
        self.present(firstPage, animated: false, completion: nil)
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
