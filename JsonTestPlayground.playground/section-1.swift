// Playground - noun: a place where people can play

import UIKit




@objc(Job)
class Job:NSObject{
    var name = ""
}


@objc(User)
class User:NSObject{
    var name = ""
    var age = 0
    var job:Job!
    var jobArr:Array<Job>!
}

class D3Json{
    //MARK: json转到model
    class func jsonToModel<T>(dics:AnyObject?,clazz:AnyClass)->T!{
        if dics == nil{
            return nil
        }
        
        var obj:AnyObject!
        var properties:MirrorType!
        obj = clazz.alloc() //新建对象
        properties = reflect(obj!)
        
        var dic:AnyObject!
        if dics is NSArray{
            dic = dics!.lastObject
        }
        else{
            dic = dics
        }
        
        
        if dic != nil{
            for(var i:Int = 1;i < properties.count;i++){  //因为是继承NSObject对象的，0是NSObject，所以从1开始
                let pro = properties[i]
                let key = pro.0        //pro  name
                let type = pro.1.valueType    // pro type
                
                switch type {
                case _ as Int.Type,_ as Int64.Type,_ as Float.Type,_ as Double.Type,_ as Bool.Type:  //base type
                    var value: AnyObject! = dic?.objectForKey(key)
                    if value != nil{
                        obj.setValue(value, forKey: key)
                    }
                    break
                    
                case _ as String.Type:
                    var value: AnyObject! = dic?.objectForKey(key)
                    if value != nil{
                        obj.setValue(value.description, forKey: key)
                    }
                    break
                    
                case _ as Array<String>.Type:  //arr string
                    if let nsarray = dic?.objectForKey(key) as? NSArray {
                        var array:Array<String> = []
                        for el in nsarray {
                            if let typedElement = el as? String {
                                array.append(typedElement)
                            }
                        }
                        obj.setValue(array, forKey: key)
                    }
                    break
                    
                    
                case _ as Array<Int>.Type:   //arr int
                    if let nsarray = dic?.objectForKey(key) as? NSArray {
                        var array:Array<Int> = []
                        for el in nsarray {
                            if let typedElement = el as? Int {
                                array.append(typedElement)
                            }
                        }
                        obj.setValue(array, forKey: key)
                    }
                    break
                    
                default:     //unknow
                    var clz: AnyClass! = swiftClassFromString(String(stringInterpolationSegment: type))
                    if var data = dic.objectForKey(key) as? NSArray{
                        var value = jsonToModelList(data, clazz: clz)
                        obj.setValue(value, forKey: key)
                    }
                    else{
                        obj.setValue(jsonToModel(dic.objectForKey(key), clazz: clz),forKey:key)
                    }
                }
                
            }
        }
        else{
            return nil
        }
        return obj as! T
    }
    
    //MARK: json转到model list,传入anyobject
    class func jsonToModelList(data:AnyObject?,clazz:AnyClass)->Array<AnyObject>{
        if data == nil{
            return []
        }
        
        var objs:Array<AnyObject> = []
        if let dics = data as? NSArray{
            for(var i = 0 ;i < dics.count;i++){
                var dic:AnyObject = dics[i]
                objs.append(jsonToModel(dic,clazz:clazz))
            }
        }
        return objs
    }
    
    
    // create a static method to get a swift class for a string name
    private class func swiftClassFromString(className: NSString) -> AnyClass! {
        println(className)
        // get the project name
        var clazz:AnyClass! = NSClassFromString(className as String)
        if clazz == nil{    //swift
//            var appName:String?  = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String?
            //FIXME playground的不同...
            var appName:String? = "__lldb_expr_"
            //swift 的model需要转过才能NSClassFromString
            var range = className.rangeOfString("<\(appName!).*?>", options: NSStringCompareOptions.RegularExpressionSearch)
            if range.location != NSNotFound{
                if className.containsString(appName!){
                    range.location += 4 + count(appName!)  //< .
                    range.length -= 5 + count(appName!)  // < . >
                }
                else{
                    range.location += 1
                    range.length -= 2
                }
                
                var clazzName = className.substringWithRange(range)
                clazz = NSClassFromString(className.substringWithRange(range))
            }
        }
        return clazz;
    }
}


//
var json = [
    "name": "ok123",
    "age":1,
    "job": [
        "name":"ios1"
    ],
    "jobArr":[
        ["name":"swift"],
        ["name":"objc"]
    ]
]

var user:User = D3Json.jsonToModel(json, clazz: User.self)
user.jobArr
//
//
//var json2 = [
//    [
//        "name": "ok",
//        "age":1,
//        "job": [
//            "name":"swift"
//        ]
//    ],
//    [
//        "name": "no ok",
//        "age":2,
//        "job": [
//            "name":"obc"
//        ]
//    ]
//]
//var users:Array<User> = D3Json.jsonToModelList(json2, clazz: User.self, objc: User())
//
//

//var json = [
//    "products": [
//    [
//    "name": "方大同",
//    "filename": "menu_1.png"
//    ],
//    [
//    "name": "mm",
//    "filename": "DSC_1186.JPGt"
//    ],
//    [
//    "name": "測試",
//    "filename": "DSC_1198.JPGt"
//    ]
//    ],
//    "success": 2
//]
//
//class Product:NSObject{
//    var name = ""
//    var filename = ""
//}
//
//var lists:Array<Product> =  D3Json.jsonToModelList(json.objectForKey("products"), objc: Product())





