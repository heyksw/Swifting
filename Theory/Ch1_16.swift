// Value Type Struct 와 Reference Type Class 의 차이점

class SomeClass {
    var count: Int = 0
}

struct SomeStruct {
    var count: Int = 0
}

var class1 = SomeClass()
var class2 = class1
var class3 = class1

class3.count = 2
class1.count       // 2

var struct1 = SomeStruct()
var struct2 = struct1
var struct3 = struct1

struct3.count = 2

