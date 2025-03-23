//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors.
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

public typealias ArduinoString = String

extension ArduinoString: CustomStringConvertible {
  public var description: Swift.String {
    let size = self.length() + 1
    let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: Int(size))
    self.getBytes(buffer, size)
    let result = Swift.String(cString: UnsafePointer<CChar>(buffer))
    buffer.deallocate()
    return result
  }
}

extension ArduinoString: Equatable {
  public static func == (lhs: ArduinoString, rhs: ArduinoString) -> Bool {
    lhs.equals(rhs)
  }

  public static func == <RHS: StringProtocol>(lhs: ArduinoString, rhs: RHS)
    -> Bool
  {
    lhs.equals(String(Swift.String(rhs)))
  }

  public static func == <LHS: StringProtocol>(lhs: LHS, rhs: ArduinoString)
    -> Bool
  {
    rhs.equals(String(Swift.String(lhs)))
  }
}

extension ArduinoString: Comparable {
  public static func < (lhs: ArduinoString, rhs: ArduinoString) -> Bool {
    lhs.compareTo(rhs) < 0
  }

  public static func < <RHS: StringProtocol>(lhs: ArduinoString, rhs: RHS)
    -> Bool
  {
    lhs.compareTo(String(Swift.String(rhs))) < 0
  }

  public static func < <LHS: StringProtocol>(lhs: LHS, rhs: ArduinoString)
    -> Bool
  {
    lhs < rhs.description
  }
}

extension ArduinoString: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(description)
  }
}

extension ArduinoString: ExpressibleByStringLiteral {
  public init(stringLiteral value: Swift.String) {
    let cString = Array(value.utf8CString)
    self = ArduinoString(cString)
  }
}

// MARK: - Operators (+, +=)

extension ArduinoString {
  public static func + (lhs: ArduinoString, rhs: ArduinoString) -> ArduinoString
  {
    var newString = lhs
    _ = newString.concat(rhs)
    return newString
  }

  /// ComputesArduinoString + SomeString (e.g. String, Substring, etc.)
  public static func + <RHS: StringProtocol>(lhs: ArduinoString, rhs: RHS)
    -> ArduinoString
  {
    ArduinoString(lhs.description + Swift.String(rhs))
  }

  /// Computes SomeString + ArduinoString.
  public static func + <LHS: StringProtocol>(lhs: LHS, rhs: ArduinoString)
    -> ArduinoString
  {
    ArduinoString(Swift.String(lhs) + rhs.description)
  }

  /// Computes ArduinoString += ArduinoString.
  public static func += (lhs: inout ArduinoString, rhs: ArduinoString) {
    lhs = lhs + rhs
  }

  /// ComputesArduinoString += SomeString.
  public static func += <RHS: StringProtocol>(
    lhs: inout ArduinoString, rhs: RHS
  ) {
    lhs = lhs + rhs
  }
}

extension Swift.String {
  public static func += (lhs: inout Swift.String, rhs: ArduinoString) {
    lhs.append(contentsOf: rhs.description)
  }
}

extension ArduinoString {
  // Access the underlying Swift.String's StringProtocol properties
  public var utf8: Swift.String.UTF8View { self.description.utf8 }
  public var utf16: Swift.String.UTF16View {
    self.description.utf16
  }

  public var unicodeScalars: Swift.String.UnicodeScalarView {
    self.description.unicodeScalars
  }

  // Common StringProtocol methods
  public func hasPrefix(_ prefix: Swift.String) -> Bool {
    self.description.hasPrefix(prefix)
  }

  public func hasSuffix(_ suffix: Swift.String) -> Bool {
    self.description.hasSuffix(suffix)
  }

  public func contains(_ other: Swift.Character) -> Bool {
    self.description.contains(other)
  }

  // Index-based access
  public subscript(position: Swift.String.Index) -> Character {
    self.description[position]
  }

  public subscript(bounds: Range<Swift.String.Index>) -> Swift.Substring {
    self.description[bounds]
  }

  public var startIndex: Swift.String.Index {
    self.description.startIndex
  }

  public var endIndex: Swift.String.Index {
    self.description.endIndex
  }

  public func index(after i: Swift.String.Index) -> Swift.String.Index {
    self.description.index(after: i)
  }

  public func index(before i: Swift.String.Index) -> Swift.String.Index {
    self.description.index(before: i)
  }
}
