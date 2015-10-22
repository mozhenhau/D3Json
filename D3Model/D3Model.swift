//
//  D3Model.swift
//  D3Model
//
//  Created by mozhenhau on 15/2/12.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation

public class D3Model:NSObject{
    required override public init(){}
    //MARK: json转到model
    public class func jsonToModel<T>(dics:AnyObject?)->T!{
        if dics == nil {
            return nil
        }
        var dic:AnyObject!
        if dics is NSArray{
            dic = dics!.lastObject
        }
        else{
            dic = dics
        }
        
        //get mirror
        let obj:AnyObject = self.init() //新建对象
        let properties:Mirror! = Mirror(reflecting: obj)
        
        if dic != nil{
            if let b = AnyBidirectionalCollection(properties.children) {
                for i in b.endIndex.advancedBy(-20, limit: b.startIndex)..<b.endIndex {  //因为是继承NSObject对象的，0是NSObject，所以从1开始
                let pro = b[i]
                let key = pro.0        //pro  name
                let type = pro.1    // pro type

                switch type {
                case is Int,is Int64,is Float,is Double,is Bool,is NSNumber,is NSInteger:  //base type
                    let value: AnyObject! = dic?.objectForKey(key!)
                    if value != nil{
                        obj.setValue(value, forKey: key!)
                    }
                    break
                    
                case is String:
                    let value: AnyObject! = dic?.objectForKey(key!)
                    if value != nil{
                        obj.setValue(value.description, forKey: key!)
                    }
                    break
                    
                case is Array<String>:  //arr string
                    if let nsarray = dic?.objectForKey(key!) as? NSArray {
                        var array:Array<String> = []
                        for el in nsarray {
                            if let typedElement = el as? String {
                                array.append(typedElement)
                            }
                        }
                        obj.setValue(array, forKey: key!)
                    }
                    break
                    
                    
                case is Array<Int>:   //arr int
                    if let nsarray = dic?.objectForKey(key!) as? NSArray {
                        var array:Array<Int> = []
                        for el in nsarray {
                            if let typedElement = el as? Int {
                                array.append(typedElement)
                            }
                        }
                        obj.setValue(array, forKey: key!)
                    }
                    break
                    
                default:     //unknow
                    let otherType = Mirror(reflecting: type).subjectType
                    
                    switch otherType{
                    case is Optional<String>.Type,is Optional<NSNumber>.Type,is Optional<NSInteger>.Type,is Optional<Array<String>>.Type,is Optional<Array<Int>>.Type:
                        obj.setValue(dic?.objectForKey(key!), forKey: key!)
                        break
                    
                    default:
                        let name:NSString = String(otherType)
                        let className = getClassName(name) as String
                        let clz:AnyClass! = NSClassFromString(className)
                        
                        if clz != nil{
                            if let data = dic.objectForKey(key!) as? NSArray{
                                let value = clz.jsonToModelList(data)
                                obj.setValue(value, forKey: key!)
                            }
                            else{
                                let value = dic.objectForKey(key!)
                                obj.setValue((clz as! D3Model.Type).jsonToModel(value),forKey:key!)
                            }
                        }
                        else{
                            print("unknown property")
                        }
                        break
                    }
                }
            }
        }
        }
        else{
            return nil
        }
        return (obj as! T)
    }
    
    //MARK: json转到model list,传入anyobject
    public class func jsonToModelList(data:AnyObject?)->Array<AnyObject>{
        if data == nil{
            return []
        }
        
        var objs:Array<AnyObject> = []
        if let dics = data as? NSArray{
            for(var i = 0 ;i < dics.count;i++){
                let dic:AnyObject = dics[i]
                objs.append(jsonToModel(dic))
            }
        }
        return objs
    }

    
    //从一串Optional<*******>找到类名字符串
    private class func getClassName(name:NSString)->NSString!{
        var range = name.rangeOfString("<.*>", options: NSStringCompareOptions.RegularExpressionSearch)
        if range.location != NSNotFound{
            range.location += 1
            range.length -= 2
            return getClassName(name.substringWithRange(range))
        }
        else{
            return name
        }
    }
}
