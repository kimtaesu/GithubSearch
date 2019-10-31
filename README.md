


 ## 적용 범위    
* iOS 11 ~ 최신    
* iPhone    

 ## 환경    
* XCode 11.1
* Swift5    

 ## Languages, libraries and tools used    

 * [Swift](https://developer.apple.com/kr/swift/)    
* [RxSwift](https://github.com/ReactiveX/RxSwift)    
* [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)    
* [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources)    
* [SwiftLint](https://github.com/realm/SwiftLint)    
* [SwiftGen](https://github.com/SwiftGen/SwiftGen)
* [SnapKit](https://github.com/SnapKit/SnapKit)
* [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver)    
* [Then](https://github.com/devxoul/Then)
* [Cuckoo](https://github.com/Brightify/Cuckoo)


## Layer

![Layer](/Screenshot/Diagram.png)

### Requests (Data)
Network 를 통해 user 리스트를 검색하고 Domain Layer 에게 전달합니다.

### GithubService (Domain)
여러 Data Source (Network, Database) 등을 추상화합니다. 

Data Layer 로 부터 전달받은 데이터를 Presentation Layer 에 전달합니다.

### SearchUserViewModel (Presentation)
Domain Layer 로 부터 전달받은 데이터를 가공하여  User Interface Layer 에 전달합니다.

또, User Interface 가 어떻게 보여줘야 하는지? 행위를 담당하는 책임을 가지고 있습니다. 

### GithubSearchViewController (User Interface)
사용자에게 보여질 UI 를 표시합니다. 

Presentation Layer 로 부터 전달받은 데이터를 수신하고 UI 에 표시합니다. 

