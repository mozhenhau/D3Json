# D3Json
通过swift的反射特性，把json数据转换为model对象,本类最主要是解决了其他一般json转换类不能转换自定义对象的问题
只有一个文件：D3Json.swfit
扩展写在addExtension。可以参照扩展


例子在D3Json的Project里面，写了两个测试，一个是json转单model，一个是转model的list
在playgroud里面也有两个例子，但是playgroud里面，alloc自己定义的model时直接出错，可能是playgroud的bug

只需要一句代码：
var user:User = D3Json.jsonToModel(json, clazz: User.self, objc: User())就可以把json数据转换成User类

转成list对象:
var user:Array<User> = D3Json.jsonToModelList(jsons, clazz: User.self, objc: User())就可以把json数据转换成Array<User>类

存在问题:
1.不处理optional类型，建议写model类时先初始化
2.为什么要传clazz同时传过model的实体类？因为反射reflect(User.self.alloc())的时候存在自定义对象反射失败....
但是反射reflect(User())则没有问题.
3.尝试使用NSClassFromString写扩展，更方便
