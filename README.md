# D3Json
通过swift的反射特性，把json数据转换为model对象

例子在D3Json的Project里面，写了两个测试，一个是json转单model，一个是转model的list
在playgroud里面也有两个例子，但是playgroud里面，alloc自己定义的model时会出错，可能是playgroud的bug


扩展写在addExtension。可以参照扩展

只有一个文件：D3Json.swfit
var user:User = D3Json.jsonToModel(json, clazz: User.self, objc: User())就可以把json数据转换成User类
