//
//  File.swift
//  ScaleKit
//
//  Created by 김동현 on 4/19/25.
//

import CoreGraphics

@MainActor
public extension Double {
    var scaled: CGFloat {
        return DynamicSize.scaledSize(CGFloat(self))
    }
}

@MainActor
public extension Float {
    var scaled: CGFloat {
        return DynamicSize.scaledSize(CGFloat(self))
    }
}

@MainActor
public extension Int {
    var scaled: CGFloat {
        return DynamicSize.scaledSize(CGFloat(self))
    }
}
