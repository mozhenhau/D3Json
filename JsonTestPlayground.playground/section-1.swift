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
    var job:Job?
    var jobArr:Array<Job> = []
}

sizeof(Int.self)
var pros = reflect(User.self.alloc())
String(stringInterpolationSegment: pros[3].1.valueType)
Job.self
Array<Job>.self
NSArray.self

NSClassFromString("Array")
//
//object_getClassName(User()).getMirror().valueType
//var s:String = String(stringInterpolationSegment: pros[3].1.valueType)
//Job.self
//
//Array<Job>.self
//pros[4].1.valueType
//String(stringInterpolationSegment: pros[4].1.valueType)
//
//NSClassFromString(String(stringInterpolationSegment: pros[4].1.valueType))
//let string = "Hello"
//let name = String.self


//NSClassFromString(s)




//class D3Json{
//    class func jsonToModel<T>(dics:AnyObject?,objc:T?)->T!{
//        return jsonToModel(dics, clazz: nil, objcT: objc)
//    }
//    
//    
//    class func jsonToModel<T>(dics:AnyObject?,clazz:AnyClass?)->T!{
//        return jsonToModel(dics, clazz: clazz, objcT: nil)
//    }
//    
//    
//    //MARK: json转到model
//    private class func jsonToModel<T>(dics:AnyObject?,clazz:AnyClass?,objcT:T?)->T!{
//        if dics == nil{
//            return nil
//        }
//        
//        var obj:AnyObject!
//        var properties:MirrorType!
//        var objc: AnyObject! = objcT as! AnyObject
//        
//        if objc != nil{
//            obj = objc!.classForCoder.alloc() //新建对象
//            properties = reflect(objc!)
//        }
//        else if clazz != nil{
//            obj = clazz!.alloc()
//            properties = reflect(obj)
//        }
//        else{
//            return nil
//        }
//        
//        var dic:AnyObject!
//        if dics is NSArray{
//            dic = dics!.lastObject
//        }
//        else{
//            dic = dics
//        }
//        
//        
//        if dic != nil{
//            for(var i:Int = 1;i < properties.count;i++){  //因为是继承NSObject对象的，0是NSObject，所以从1开始
//                let pro = properties[i]
//                let key = pro.0        //pro  name
//                let type = pro.1.valueType    // pro type
//                
//                switch type {
//                case _ as Int.Type,_ as Int64.Type,_ as Float.Type,_ as Double.Type,_ as Bool.Type:  //base type
//                    var value: AnyObject! = dic?.objectForKey(key)
//                    if value != nil{
//                        obj.setValue(value, forKey: key)
//                    }
//                    break
//                    
//                case _ as String.Type:
//                    var value: AnyObject! = dic?.objectForKey(key)
//                    if value != nil{
//                        obj.setValue(value.description, forKey: key)
//                    }
//                    break
//                    
//                case var clazz as T.Type:
//                    obj.setValue(jsonToModel(dic.objectForKey(key), objc: clazz),forKey:key)
//                    break
//                    
//                    
////                case _ as Array<T>.Type:
////                    var value:Array<AnyObject> = jsonToModelList((dic.objectForKey(key) as? NSArray), objc: T.self)
////                    obj.setValue(value, forKey: key)
////                    break
//                    
//                case _ as Array<String>.Type:  //arr string
//                    if let nsarray = dic?.objectForKey(key) as? NSArray {
//                        var array:Array<String> = []
//                        for el in nsarray {
//                            if let typedElement = el as? String {
//                                array.append(typedElement)
//                            }
//                        }
//                        obj.setValue(array, forKey: key)
//                    }
//                    break
//                    
//                    
//                case _ as Array<Int>.Type:   //arr int
//                    if let nsarray = dic?.objectForKey(key) as? NSArray {
//                        var array:Array<Int> = []
//                        for el in nsarray {
//                            if let typedElement = el as? Int {
//                                array.append(typedElement)
//                            }
//                        }
//                        obj.setValue(array, forKey: key)
//                    }
//                    break
//                    
//                default:     //unknow
//                    println("no")
////                    addExtension(key,type:type,obj:obj,dic:dic)   //自己扩展自定义类
//                }
//                
//            }
//        }
//        else{
//            return nil
//        }
//        return (obj as! T)
//    }
//    
//    //MARK: json转到model list,传入anyobject
//    class func jsonToModelList<T>(data:AnyObject?,objc:T?)->Array<T>{
//        if data == nil{
//            return []
//        }
//        
//        var objs:Array<T> = []
//        if let dics = data as? NSArray{
//            for(var i = 0 ;i < dics.count;i++){
//                var dic:AnyObject = dics[i]
//                objs.append(jsonToModel(dic,objc:objc))
////                objs.append()
//            }
//        }
//        return objs
//    }
//    
//    
//    /**
//    上面只实现了基本类型的，如果是自己定义的model，在此处做扩展.此处作例子，不需要可清除。
//    如有自己的User类，则增加：
//    case _ as User.Type:
//    obj.setValue(jsonToModel(dic.objectForKey(key), clazz: User.self, objc: User()),forKey:key)
//    如有自己的Job类，则把User改成Job则可
//    
//    :param: key  属性名
//    :param: type 属性的类型
//    :param: obj  要赋值的对象
//    :param: dic  json对象
//    */
//    private class func addExtension(key:String,type:Any.Type,obj:AnyObject,dic:AnyObject){
//        switch type {
//        case _ as User.Type:
//            obj.setValue(jsonToModel(dic.objectForKey(key), objc: User()),forKey:key)
//            
//        case _ as Job.Type:
//            obj.setValue(jsonToModel(dic.objectForKey(key), objc: Job()),forKey:key)
//            
//        case _ as Array<Job>.Type:
//            var value:Array<Job> = jsonToModelList((dic.objectForKey(key) as? NSArray), objc: Job())
//            obj.setValue(value, forKey: key)
//            
//        default:     //unknow
//            println("key:\(key),unknow,sure that you hava init")
//        }
//    }
//    
//}
//
////
//var json = [
//    "name": "ok123",
//    "age":1,
//    "job": [
//        "name":"swif1"
//    ] 
//]
//
//var user:User = D3Json.jsonToModel(json, clazz: User.self, objcT: User())
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





