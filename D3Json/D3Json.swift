//
//  D3json.swift
//  D3Json
//
//  Created by mozhenhau on 15/2/12.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//

import Foundation

public class D3Json{
    //MARK: json转到model
    public class func jsonToModel<T>(dics:AnyObject?,clazz:AnyClass?)->T!{
        if dics == nil || clazz == nil{
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
        let obj:AnyObject = ObjectUtil.ObjFromClass(clazz!) //新建对象
        let properties:Mirror! = Mirror(reflecting: obj)
        
        if dic != nil{
            if let b = AnyBidirectionalCollection(properties.children) {
                for i in b.endIndex.advancedBy(-20, limit: b.startIndex)..<b.endIndex {  //因为是继承NSObject对象的，0是NSObject，所以从1开始
                let pro = b[i]
                let key = pro.0        //pro  name
                let type = pro.1    // pro type

                switch type {
                case _ as Int,_ as Int64,_ as Float,_ as Double,_ as Bool:  //base type
                    let value: AnyObject! = dic?.objectForKey(key!)
                    if value != nil{
                        obj.setValue(value, forKey: key!)
                    }
                    break
                    
                case _ as String:
                    let value: AnyObject! = dic?.objectForKey(key!)
                    if value != nil{
                        obj.setValue(value.description, forKey: key!)
                    }
                    break
                    
                case _ as Array<String>:  //arr string
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
                    
                    
                case _ as Array<Int>:   //arr int
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
//                    let clz: AnyClass! = swiftClassFromString(String(stringInterpolationSegment: type))
                    let name:NSString = String(Mirror(reflecting: type).subjectType)
                    let clz:AnyClass! = NSClassFromString(getClassName(name) as String)
                    
                    if clz != nil{
                        if let data = dic.objectForKey(key!) as? NSArray{
                            let value = jsonToModelList(data, clazz: clz)
                                obj.setValue(value, forKey: key!)
                        }
                        else{
                            obj.setValue(jsonToModel(dic.objectForKey(key!), clazz: clz),forKey:key!)
                        }
                    }
                    else{
                        print("unknown property")
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
    public class func jsonToModelList(data:AnyObject?,clazz:AnyClass)->Array<AnyObject>{
        if data == nil{
            return []
        }
        
        var objs:Array<AnyObject> = []
        if let dics = data as? NSArray{
            for(var i = 0 ;i < dics.count;i++){
                let dic:AnyObject = dics[i]
                objs.append(jsonToModel(dic,clazz:clazz))
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
