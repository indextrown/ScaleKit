# 📐 ScaleKit

`ScaleKit`은 다양한 기기 화면 크기에 따라 텍스트, 여백, 뷰 크기를 자동으로 스케일링해주는 Swift Package입니다.  
**iPhone 15 Pro Max**를 기준으로, 다른 기기에서도 일관된 UI 비율을 유지할 수 있도록 도와줍니다.

---

## 🚀 주요 기능

- 디바이스 화면 대각선 기준으로 스케일 계산  
- `CGFloat`, `Double`, `Int`, `Float`에 `.scaled` 확장 제공  
- SwiftUI / UIKit 모두 지원  
- `@MainActor` 기반으로 concurrency-safe

---

## 📦 설치 방법

### Swift Package Manager (SPM)

Xcode →  
`File > Add Packages` →  
`https://github.com/indextrown/ScaleKit.git` 입력 후 추가

---

## ✅ 사용 방법

### SwiftUI

```swift
// App.swift
import SwiftUI
import ScaleKit

@main
struct TestApp: App {

    init() {
        // App 시작 시 단 1회 호출
        // 1. 기본값: iPhone 15 Pro Max 기준
        DynamicSize.setScreenSize(UIScreen.main.bounds)
        
        // 2. 명시적으로 다른 기준 사용
        DynamicSize.setScreenSize(UIScreen.main.bounds, baseDevice: .iPhone14ProMax)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

```swift
// ContentView.swift
import SwiftUI
import ScaleKit

struct ContentView: View {
    var body: some View {
        Text("시작하기")
            .font(.system(size: 18.scaled))     // Int
            .padding(12.0.scaled)               // Double
            .frame(width: 100.scaled, height: 50.scaled)
    }
}
```

---

### UIKit

```swift
import UIKit
import ScaleKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. 현재 화면 크기 설정 (App 시작 시 단 1회)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        DynamicSize.setScreenSize(windowScene.screen.bounds)
        
        // 2. 이후 UIKit 전역에서 .scaled 사용 가능
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.scaled)
        label.layer.cornerRadius = 12.scaled
    }
}
```

---

## ⚠️ 주의 사항

- 반드시 앱 시작 시점에 아래 메서드를 호출하세요:

```swift
DynamicSize.setScreenSize(UIScreen.main.bounds)
```

- SwiftUI라면 `App`, UIKit이라면 `SceneDelegate` 또는 `AppDelegate`에서 호출

---

## 🧠 계산 방식

> 기준 기기: **iPhone 15 Pro Max (430 x 932pt)**

스케일 계산 공식:

```
scaleFactor = √(현재기기 width² + height²) / √(430² + 932²)
scaledSize = baseSize × scaleFactor
```

---

## 🔧 내부 구조

- `DynamicSize`: 기준 디바이스 설정 및 스케일 계산  
- `.scaled`: `Int`, `Double`, `Float`, `CGFloat`에 확장 제공

---

## 📂 폴더 구조

```
Sources/
└── ScaleKit/
    ├── DynamicSize.swift               # 스케일 계산 및 기본 화면 크기 관리
    ├── DynamicSize+BaseDevice.swift    # BaseDevice enum 및 명시적 기준 디바이스 설정
    └── Scaled+Extensions.swift         # .scaled 확장 (CGFloat, Int, Float, Double)
```

---

## 📄 라이선스

MIT License

Copyright (c) 2025 김동현

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

---

Made with 💻 by [@donghyeon-kim](https://github.com/indextrown)
