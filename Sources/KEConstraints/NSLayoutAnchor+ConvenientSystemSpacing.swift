//
//  Created by Kai Engelhardt on 23.01.18
//  Copyright © 2018 Kai Engelhardt. All rights reserved.
//
//  Distributed under the permissive MIT license
//  Get the latest version from here:
//
//  https://github.com/kaiengelhardt/KEFoundation
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

@available(macOS 11.0, *)
extension NSLayoutXAxisAnchor {
	public func constraint(equalToSystemSpacingAfter anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return constraint(equalToSystemSpacingAfter: anchor, multiplier: 1)
	}

	public func constraint(greaterThanOrEqualToSystemSpacingAfter anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return constraint(greaterThanOrEqualToSystemSpacingAfter: anchor, multiplier: 1)
	}

	public func constraint(lessThanOrEqualToSystemSpacingAfter anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return constraint(lessThanOrEqualToSystemSpacingAfter: anchor, multiplier: 1)
	}
}

@available(macOS 11.0, *)
extension NSLayoutYAxisAnchor {
	public func constraint(equalToSystemSpacingBelow anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
		return constraint(equalToSystemSpacingBelow: anchor, multiplier: 1)
	}

	public func constraint(greaterThanOrEqualToSystemSpacingBelow anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
		return constraint(greaterThanOrEqualToSystemSpacingBelow: anchor, multiplier: 1)
	}

	public func constraint(lessThanOrEqualToSystemSpacingBelow anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
		return constraint(lessThanOrEqualToSystemSpacingBelow: anchor, multiplier: 1)
	}
}
#endif
