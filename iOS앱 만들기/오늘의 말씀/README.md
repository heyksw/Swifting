## 앱 실행 화면

<img src="https://user-images.githubusercontent.com/61315014/139661062-6937b561-d0c6-4bea-a617-75cf9c346415.gif" width = "30%">


## 개발 정보

앱 제목 : 오늘의 말씀

프로그래밍 언어 : Swift   
개발 환경 : XCode, Story Board

활용 기술 :
1. AutoLayout
2. UILabel
3. UIButton
4. MVC 패턴
5. swift 구조체


## 비판적 클론코딩 

- UIView 의 모서리 : 직각 -> 둥글게
layer.cornerRadius 에 대한 공부

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        title2.text = "랜덤 성경 명언"
        contentView.layer.cornerRadius = 20
        
        refreshButton.layer.cornerRadius = 10
        //quoteLabel.text = "test"
        
    }
```

