//
//  Created by Kai Engelhardt on 21.07.20.
//  Copyright © 2024 Kai Engelhardt. All rights reserved.
//
//  Distributed under the permissive MIT license
//  Get the latest version from here:
//
//  https://github.com/kaiengelhardt/Consti
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#if !os(watchOS)
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

@MainActor
@propertyWrapper
public struct ActiveConstraint<Constraint: ConstraintToggleable> where Constraint: Equatable {
	public var wrappedValue: Constraint {
		didSet {
			guard wrappedValue != oldValue else {
				return
			}
			oldValue.deactivate()
			wrappedValue.activate()
		}
	}

	public init(wrappedValue: Constraint) {
		self.wrappedValue = wrappedValue
		wrappedValue.activate()
	}
}

extension ActiveConstraint where Constraint: NeutralValueProviding {
	public init() {
		wrappedValue = Constraint.neutralValue
	}
}

@MainActor
public protocol ConstraintToggleable {
	func activate()
	func deactivate()
}

// MARK: - NSLayoutConstraint + ConstraintActivatable

extension NSLayoutConstraint: ConstraintToggleable {
	public func activate() {
		isActive = true
	}

	public func deactivate() {
		isActive = false
	}
}

// MARK: - Optional + ConstraintActivatable

extension Optional: ConstraintToggleable where Wrapped: ConstraintToggleable {
	public func activate() {
		self?.activate()
	}

	public func deactivate() {
		self?.deactivate()
	}
}

// MARK: - Optional + DefaultValueProviding

extension Optional: NeutralValueProviding where Wrapped: NSLayoutConstraint {
	public static var neutralValue: Wrapped? {
		return nil
	}
}

// MARK: - Array + ConstraintActivatable

extension Array: ConstraintToggleable where Element: NSLayoutConstraint {
	public func activate() {
		NSLayoutConstraint.activate(self)
	}

	public func deactivate() {
		NSLayoutConstraint.deactivate(self)
	}
}

// MARK: - Array + DefaultValueProviding

extension Array: NeutralValueProviding where Element: NSLayoutConstraint {
	public static var neutralValue: [Element] {
		return []
	}
}
#endif
