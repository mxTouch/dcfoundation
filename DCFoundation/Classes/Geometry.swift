//
//  DCFoundation
//

import Foundation

public struct Point: Hashable {
    
    public var x: Double = 0
    public var y: Double = 0
    
    public init() {}
    
    public init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    public var hashValue: Int {
        return "\(x),\(y)".hashValue
    }
    
}

public func == (lhs: Point, rhs: Point) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

public func + (lhs: Point, rhs: (x: Int, y: Int)) -> Point {
    return Point(lhs.x + rhs.x.toDouble(), lhs.y + rhs.y.toDouble())
}

public func + (lhs: Point, rhs: (x: Double, y: Double)) -> Point {
    return Point(lhs.x + rhs.x, lhs.y + rhs.y)
}

public struct Size {
    
    public var width: Double = 0
    public var height: Double = 0
    
    public init() {}
    
    public init(_ width: Double, _ height: Double) {
        self.width = width
        self.height = height
    }
    
}

public struct Rect {
    
    public var origin   = Point()
    public var size     = Size()
    
    public init() {}
    
    public struct Points {
        public var topLeft = Point()
        public var topRight = Point()
        public var bottomLeft = Point()
        public var bottomRight = Point()
    }
    
    public var points: Points {
        var points = Points()
        points.topLeft = origin
        points.topRight = origin + (size.width, 0)
        points.bottomLeft = origin + (0, size.height)
        points.bottomRight = origin + (size.width, size.height)
        return points
    }
    
    public init(_ origin: Point, _ size: Size) {
        self.origin = origin
        self.size = size
    }
    
    public init(_ x: Double, _ y: Double, _ size: Size) {
        origin = Point(x, y)
        self.size = size
    }
    
    public init(_ origin: Point, _ width: Double, _ height: Double) {
        self.origin = origin
        size = Size(width, height)
    }
    
    public init(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        origin = Point(x, y)
        size = Size(width, height)
    }
    
}
