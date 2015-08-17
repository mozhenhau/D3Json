//
//  D3json.swift
//  D3Json
//
//  Created by mozhenhau on 15/2/12.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation

public class D3Json{
    public class func jsonToModel<T>(dics:AnyObject?,objc:AnyObject?)->T!{
        return jsonToModel(dics, clazz: nil, objc: objc)
    }
    
    
    public class func jsonToModel<T>(dics:AnyObject?,clazz:AnyClass?)->T!{
        return jsonToModel(dics, clazz: clazz, objc: nil)
    }
    
    
    //MARK: json转到model
    private class func jsonToModel<T>(dics:AnyObject?,clazz:AnyClass?,objc:AnyObject?)->T!{
        if dics == nil{
            return nil
        }
        
        var obj:AnyObject!
        var properties:MirrorType!
        if objc != nil{
            obj = objc!.classForCoder.alloc() //新建对象
            properties = reflect(objc!)
        }
        else if clazz != nil{
            obj = clazz!.alloc()
            properties = reflect(obj)
        }
        else{
            return nil
        }
        
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
                    
                case _ as String.Type:
                    var value: AnyObject! = dic?.objectForKey(key)
                    if value != nil{
                        obj.setValue(value.description, forKey: key)
                    }
                    
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
                    
                default:     //unknow
                    addExtension(key,type:type,obj:obj,dic:dic)   //自己扩展自定义类
                }
                
            }
        }
        else{
            return nil
        }
        return (obj as! T)
    }
    
    //MARK: json转到model list,传入anyobject
    public class func jsonToModelList<T>(data:AnyObject?,objc:AnyObject)->Array<T>{
        if data == nil{
            return []
        }
        
        var objs:Array<T> = []
        if let dics = data as? NSArray{
            for(var i = 0 ;i < dics.count;i++){
                var dic:AnyObject = dics[i]
                objs.append(jsonToModel(dic,objc:objc))
            }
        }
        return objs
    }
    
    
    /**
    上面只实现了基本类型的，如果是自己定义的model，在此处做扩展.此处作例子，不需要可清除。
    如有自己的User类，则增加：
    case _ as User.Type:
    obj.setValue(jsonToModel(dic.objectForKey(key), clazz: User.self, objc: User()),forKey:key)
    如有自己的Job类，则把User改成Job则可
    
    :param: key  属性名
    :param: type 属性的类型
    :param: obj  要赋值的对象
    :param: dic  json对象
    */
    private class func addExtension(key:String,type:Any.Type,obj:AnyObject,dic:AnyObject){
        switch type {
        case _ as User.Type:
            obj.setValue(jsonToModel(dic.objectForKey(key), objc: User()),forKey:key)
            
        case _ as Job.Type:
            obj.setValue(jsonToModel(dic.objectForKey(key), objc: Job()),forKey:key)
            
        case _ as Array<Job>.Type:
            var value:Array<Job> = jsonToModelList((dic.objectForKey(key) as? NSArray), objc: Job())
            obj.setValue(value, forKey: key)
            
        default:     //unknow
            println("key:\(key),unknow,sure that you hava init")
        }
    }
    
}