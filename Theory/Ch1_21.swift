// 1. 연산 프로퍼티 익스텐션
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

26.isEven   // true
29.isEven   // false

// 2. 메서드 익스텐션
extension String {
    func show() {
        print(self)
    }
}

"Hello".show()

// 3. 이니셜라이저
extension String {
    init(number: Int) {
        self = "\(number)"
    }
}

let six: String = String(6)
six     // "6"

// 클래스 타입은 편의 이니셜라이저만 익스텐션 할 수 있다.
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

extension Person {
    convenience init() {
        self.init(name: "Default")
    }
}

let someone: Person = Person()
someone.name    // -> Default

// 4. 서브 스크립트
// 타입에 서브 스크립트 익스텐션 하기
extension String {
    subscript(value: String) -> String {
        return self + value
    }
    
    subscript(repeatCount: Int) -> String {
        var str: String = ""
        for _ in 1...repeatCount {
            str += self
        }
        return str
    }
}

print("abc"["def"])     //abcdef
print("abc"[3])         //abcabcabc





// 서브 스크립트 연습
struct Student {
    var number: Int
    var name: String
}

class School {
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(number: self.number, name: name)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudent(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    
    
    subscript(index: Int = 0) -> Student? {
        if index < self.number {
            return self.students[index]
        }
        return nil
    }
}
