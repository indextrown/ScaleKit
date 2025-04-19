# 📐 ScaleKit

> 🇰🇷 [한국어 설명 보기](README_KR.md)

**ScaleKit** is a lightweight Swift Package that automatically scales UI components such as fonts, paddings, and view sizes based on the screen size of various iPhone devices.  
The default base device is **iPhone 15 Pro Max**, and you can explicitly choose other base devices.

---

## 🚀 Features

- Screen-diagonal-based dynamic scaling
- `.scaled` extensions for `CGFloat`, `Double`, `Int`, and `Float`
- Works seamlessly with both SwiftUI and UIKit
- Concurrency-safe using `@MainActor`

---

## 📦 Installation

### Swift Package Manager (SPM)

Xcode →  
`File > Add Packages` →  
Enter: `https://github.com/indextrown/ScaleKit.git`

---

## ✅ Usage

### SwiftUI

```swift
// App.swift
import SwiftUI
import ScaleKit

@main
struct TestApp: App {

    init() {
        // 1. Set screen size once at app launch
        DynamicSize.setScreenSize(UIScreen.main.bounds)

        // 2. Or explicitly set a different base device
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
        Text("Start")
            .font(.system(size: 18.scaled))
            .padding(12.0.scaled)
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
        guard let windowScene = (scene as? UIWindowScene) else { return }
        DynamicSize.setScreenSize(windowScene.screen.bounds)

        let label = UILabel()
        label.font = .systemFont(ofSize: 18.scaled)
        label.layer.cornerRadius = 12.scaled
    }
}
```

---

## ⚠️ Important

Make sure to call the following method once at app launch:

```swift
DynamicSize.setScreenSize(UIScreen.main.bounds)
```

In SwiftUI, call it inside the `App` struct’s `init()`.  
In UIKit, call it in `SceneDelegate` or `AppDelegate`.

---

## 🧠 Scaling Formula

> Default Base Device: **iPhone 15 Pro Max (430 x 932pt)**

```
scaleFactor = √(screenWidth² + screenHeight²) / √(430² + 932²)
scaledSize = baseSize × scaleFactor
```

---

## 🔧 Structure

- `DynamicSize`: Sets screen size and calculates scale factor
- `.scaled`: Extensions for `Int`, `Double`, `Float`, and `CGFloat`

---

## 📂 Folder Structure

```
Sources/
└── ScaleKit/
    ├── DynamicSize.swift
    ├── DynamicSize+BaseDevice.swift
    └── Scaled+Extensions.swift
```

---

## 📄 License

MIT License

Copyright (c) 2025 Donghyeon Kim

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...

---

Made with 💻 by [@donghyeon-kim](https://github.com/indextrown)
