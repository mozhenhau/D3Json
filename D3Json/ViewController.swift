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
        var json = [
            "name": "ok",
            "age":1,
            "job": [
                "name":"ios开发"
            ],
            "skills":[
                ["name":"swift"],
                ["name":"objc"]
            ]
        ]
        var user:User = D3Json.jsonToModel(json, clazz: User.self)
        var userDescription = "name:\(user.name),age:\(user.age),job:\(user.job.name),skills:\(user.skills[0].name),\(user.skills[1].name)"
        println(userDescription)
        label.text = userDescription
        
        
        var jsonArr = [
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
        var users = D3Json.jsonToModelList(jsonArr, clazz: User.self) as! Array<User>
        println(users)
    }
}




@objc(Job)
class Job:NSObject{
    var name = ""
}

@objc(User)
class User:NSObject{
    var name = ""
    var age = 0            //基础类型需要初始化
    var job:Job! = Job()   //reflect有个bug。如果自定义类型不弄成Optional类型，会读取不了属性
    var skills:Array<Job>!
}