//
//  D3JsonTests.swift
//  D3JsonTests
//
//  Created by mozhenhau on 15/2/12.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import UIKit
import XCTest

class D3JsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        textExampleJsonList()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        var json = [
            "name": "ok",
            "age":1,
            "job": [
                "name":"swift"
            ]
        ]
        var user:User = D3Json.jsonToModel(json, clazz: User.self, objc: User())
        println(user)
    }
    
    
    func textExampleJsonList(){
        var json2 = [
            [
                "name": "ok",
                "age":1,
                "job": [
                    "name":"swift"
                ]
            ],
            [
                "name": "no ok",
                "age":2,
                "job": [
                    "name":"obc"
                ]
            ]
        ]
        var users:Array<User> = D3Json.jsonToModelList(json2, clazz: User.self, objc: User())
        println(users)
    }
}

class Job:NSObject{
    var name = ""
}

class User:NSObject{
    var name = ""
    var age = 0
    var job = Job()
}
