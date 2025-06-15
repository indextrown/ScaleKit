// The Swift Programming Language
// https://docs.swift.org/swift-book

import CoreGraphics
import UIKit

/**
 🧩 DynamicSize 사용 가이드

 다양한 iPhone 기기에서 화면 크기에 따라
 텍스트, 여백, 뷰 크기 등을 자동으로 스케일링해주는 유틸리티입니다.

 기준 기기: iPhone 15 Pro Max (430 x 932pt)

 📐 내부 계산 공식:
 1. currentDiagonal = √(기기 width² + 기기 height²)
 2. baseDiagonal = √(430² + 932²)
 3. scaleFactor = currentDiagonal / baseDiagonal
 4. 최종 크기 = baseSize × scaleFactor

 ✅ 사용 예시
 UIKit:
     label.font = .systemFont(ofSize: DynamicSize.scaledSize(18))
     view.layer.cornerRadius = DynamicSize.scaledSize(12)

 SwiftUI:
     Text("시작하기")
         .font(.system(size: 18.scaled))
         .padding(16.scaled)
         .frame(height: 50.scaled)

 ✅ 주의
 앱 시작 시 반드시 `setScreenSize(_:)` 호출 필요:
     DynamicSize.setScreenSize(UIScreen.main.bounds)
 */
@MainActor
public struct DynamicSize {
    
    // MARK: - 기준 기기 (iPhone 15 Pro Max)
    private static let baseWidth: CGFloat = 430
    private static let baseHeight: CGFloat = 932
    private static let baseDiagonal: CGFloat = sqrt(baseWidth * baseWidth + baseHeight * baseHeight)

    // MARK: - iPad 기준 기기 (예: iPad Air 10.9인치)
    private static let iPadBaseWidth: CGFloat = 834
    private static let iPadBaseHeight: CGFloat = 1194
    private static let iPadBaseDiagonal: CGFloat = sqrt(iPadBaseWidth * iPadBaseWidth + iPadBaseHeight * iPadBaseHeight)

    // MARK: - 현재 디바이스 화면 bounds
    private static var bounds: CGRect = CGRect(x: 0, y: 0, width: baseWidth, height: baseHeight)

    /// 앱 시작 시 호출: 현재 디바이스의 screen bounds를 설정
    public static func setScreenSize(_ newBounds: CGRect) {
        self.bounds = newBounds
    }

    /// 현재 기기 화면 너비
    public static var screenWidth: CGFloat { bounds.width }

    /// 현재 기기 화면 높이
    public static var screenHeight: CGFloat { bounds.height }

    /// 현재 기기의 전체 bounds
    public static var screenBounds: CGRect { bounds }

    /// 현재 기기의 대각선 기반 스케일 비율
    public static var scaleFactor: CGFloat {
        let currentDiagonal = sqrt(screenWidth * screenWidth + screenHeight * screenHeight)

        if UIDevice.current.userInterfaceIdiom == .pad {
            return currentDiagonal / iPadBaseDiagonal
        } else {
            return currentDiagonal / baseDiagonal
        }
    }

    /// 주어진 값에 스케일 비율을 적용 (동적 크기 계산)
    public static func scaledSize(_ size: CGFloat) -> CGFloat {
        return size * scaleFactor
    }
}
