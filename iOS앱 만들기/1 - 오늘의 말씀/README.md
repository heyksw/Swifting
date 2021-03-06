## [오늘의 말씀] 앱 실행 화면 gif

<img src="https://user-images.githubusercontent.com/61315014/140076686-1a4c074e-2616-4b1d-9e15-ced1aa3e6c63.gif" width = "20%">

- 첫 iOS 개인 앱 프로젝트
- 리프레쉬 버튼을 누를 때마다 랜덤한 성경 말씀을 출력하는 앱.  
- 블로그 링크 : https://velog.io/@heyksw/아이폰-앱-랜덤-성경-말씀-앱

## 개발 정보

<pre>

- 프로그래밍 언어 : Swift   
- 개발 환경 : XCode, Story Board

- 활용 기술
  1. AutoLayout
  2. UILabel
  3. UIButton
  4. MVC 패턴
  5. swift 구조체
</pre>


## 비판적 클론코딩 

### 1. UIView 의 모서리 : 뷰의 모서리를 직각이 아닌, 둥글게 설정   
layer.cornerRadius 에 대한 공부

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        title2.text = "랜덤 성경 명언"
        
        // layer.cornerRadius 의 수치로 얼마나 둥글게 할 것인지 설정
        contentView.layer.cornerRadius = 20
        refreshButton.layer.cornerRadius = 10
        
    }
```

### 2. 버튼을 클릭할 때, 색상이 살짝 변경되었다가 돌아오도록 설정   
Button Touch Down, Touch Up Inside 의 차이점에 대해 공부

```swift
    // Touch Down 이벤트
    @IBAction func tapButtonTouchDown(_ sender: Any) {
        // 버튼 색상 변경
        self.refreshButton.backgroundColor = UIColor.darkGray
    }
    
    // Touch Up Inside 이벤트
    @IBAction func tapQuoteGeneratorButton(_ sender: Any) {
        let random = Int(arc4random_uniform(8))
        let quote = quotes[random]
        
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
        // 버튼 색상 변경
        self.refreshButton.backgroundColor = UIColor.lightGray
    }
```

### 3. Custom Font 변경

```swift
// 폰트 목록에 Gowun Batang 이 없으면 제대로 들어가지 않은 것
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        
        // guard 문으로 폰트가 잘 추가 되었는지 에러 체크
        guard let gowun = UIFont(name: "Gowun Batang", size: 18) else {
            print("Gowun Batang is not in UIFont")
            return
        }
        
        myTitle.font = gowun
        quoteLabel.font = gowun
        nameLabel.font = gowun
        madeBy.font = gowun

```
