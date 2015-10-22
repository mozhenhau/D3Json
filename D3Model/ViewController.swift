//
//  ViewController.swift
//  D3Json
//
//  Created by bmind on 15/8/26.
//  Copyright (c) 2015年 d3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let json = [
            "name": "ok",
            "age":1,
            "job": [
                "name":"ios开发"
            ],
            "say":["1","2","3"],
            "skills":[
                ["name":"swift"],
                ["name":"objc"]
            ]
        ]
        let user:User = User.jsonToModel(json)
        let userDescription = "name:\(user.name),age:\(user.age),job:\(user.job.name),skills:\(user.skills[0].name),\(user.skills[1].name)"
        print(userDescription)
        label.text = userDescription
        
        
        let jsonArr = [
            [
                "name": "ok",
                "age":1,
                "job": [
                    "name":"ios开发"
                ],
                "skills":[
                    ["name":"swift"],
                    ["name":"objc"]
                ]
            ],
            [
                "name": "ok2",
                "age":2,
                "job": [
                    "name":"ios开发1"
                ],
                "skills":[
                    ["name":"swift1"],
                    ["name":"objc1"]
                ]
            ]
        ]
        let users = User.jsonToModelList(jsonArr) as! Array<User>
        print(users)
    }
}




@objc(Job)   //不加的话NSClassFromString会返回nil
class Job:D3Model{
    var name = ""
}

@objc(User)
class User:D3Model{
    var name:String!
    var age:Int = 0           //基础类型需要初始化
    var job:Job!
    var say:Array<String>!
    var skills:Array<Job>!
}