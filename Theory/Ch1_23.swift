// Optional Chaining
struct Developer {
    let name: String
}

struct Company {
    let name: String
    // 옵셔널 변수
    var developer: Developer?
}

var company = Company(name: "NKLKB", developer: nil)
company.developer   // nil

var developer = Developer(name: "Kim Sang Woo")
company.developer = developer
print(company.developer)
// -> Optional(__lldb_expr_72.Developer(name: "Kim Sang Woo"))

// print(company.developer.name) -> 옵셔널을 벗기지 않았기 때문에 오류 !

// 이럴때 옵셔널 체이닝이 필요 (물론 옵셔널 바인딩으로 할 수도 있음)
print(company.developer?.name)  // Optional("Kim Sang Woo")
print(company.developer!.name)  // Kim Sang Woo

// 옵셔널 체이닝으로 출력을 하면 Optional()이 묶인 채로 출력됨.
// 옵셔널을 아예 벗겨내고 싶다면 옵셔널 바인딩을 사용해야함.

// if let 옵셔널 바인딩
if let result = company.developer?.name {
    print("if let")
    print(result)   // KimSangWoo
}
else {
    print("nil")
}

// guard let else 옵셔널 바인딩
func optionalBinding(result: Any?) {
    guard let result = company.developer?.name else {
        print("nil")
        return
    }
    print("guard let")
    print(result)
}

optionalBinding(result: company.developer?.name)
