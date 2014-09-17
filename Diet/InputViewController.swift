//
//  InputViewController.swift
//  Diet
//
//  Created by mriddi on 16.09.14.
//  Copyright (c) 2014 Crocodev. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var foodTableViewController: FoodTableViewController = FoodTableViewController()
        var foodTableView: FoodTableView = FoodTableView(frame: self.view.frame)
        foodTableView.delegate = foodTableViewController
        foodTableView.dataSource = foodTableViewController
        foodTableViewController.view = foodTableView
        
        foodTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
//        self.addChildViewController(foodTableViewController)
//        self.view.addSubview(foodTableViewController.view)
        self.presentViewController(foodTableViewController, animated: true, completion: nil)
        println (self.presentedViewController.description)

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
