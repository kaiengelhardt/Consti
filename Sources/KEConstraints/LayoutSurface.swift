//
//  Created by Kai Engelhardt on 29.05.18
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

@MainActor
public protocol LayoutSurface {
	var leadingAnchor: NSLayoutXAxisAnchor { get }
	var trailingAnchor: NSLayoutXAxisAnchor { get }
	var leftAnchor: NSLayoutXAxisAnchor { get }
	var rightAnchor: NSLayoutXAxisAnchor { get }
	var topAnchor: NSLayoutYAxisAnchor { get }
	var bottomAnchor: NSLayoutYAxisAnchor { get }
	var widthAnchor: NSLayoutDimension { get }
	var heightAnchor: NSLayoutDimension { get }
	var centerXAnchor: NSLayoutXAxisAnchor { get }
	var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension LayoutSurface {
	public func constraintsMatchingEdges(
		of surface: LayoutSurface?,
		insetBy insets: NSDirectionalEdgeInsets = .zero,
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		guard let surface else {
			return []
		}

		let invertedInsets = NSDirectionalEdgeInsets(
			top: -insets.top,
			leading: -insets.leading,
			bottom: -insets.bottom,
			trailing: -insets.trailing
		)

		let constraints: [NSLayoutConstraint] = switch relation {
		case .equal:
			[
				surface.leadingAnchor.constraint(equalTo: leadingAnchor, constant: invertedInsets.leading),
				trailingAnchor.constraint(equalTo: surface.trailingAnchor, constant: invertedInsets.trailing),
				surface.topAnchor.constraint(equalTo: topAnchor, constant: invertedInsets.top),
				bottomAnchor.constraint(equalTo: surface.bottomAnchor, constant: invertedInsets.bottom),
			]
		case .lessThanOrEqual:
			[
				surface.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: invertedInsets.leading),
				trailingAnchor.constraint(lessThanOrEqualTo: surface.trailingAnchor, constant: invertedInsets.trailing),
				surface.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: invertedInsets.top),
				bottomAnchor.constraint(lessThanOrEqualTo: surface.bottomAnchor, constant: invertedInsets.bottom),
			]
		case .greaterThanOrEqual:
			[
				surface.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: invertedInsets.leading),
				trailingAnchor.constraint(
					greaterThanOrEqualTo: surface.trailingAnchor,
					constant: invertedInsets.trailing
				),
				surface.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: invertedInsets.top),
				bottomAnchor.constraint(greaterThanOrEqualTo: surface.bottomAnchor, constant: invertedInsets.bottom),
			]
		@unknown default:
			[]
		}

		return constraints
	}

	public func constraintsMatchingCenter(
		of surface: LayoutSurface?,
		offsetBy offset: CGSize = .zero,
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		guard let surface else {
			return []
		}

		let constraints: [NSLayoutConstraint] = switch relation {
		case .equal:
			[
				centerXAnchor.constraint(equalTo: surface.centerXAnchor, constant: offset.width),
				centerYAnchor.constraint(equalTo: surface.centerYAnchor, constant: offset.height),
			]
		case .lessThanOrEqual:
			[
				centerXAnchor.constraint(lessThanOrEqualTo: surface.centerXAnchor, constant: offset.width),
				centerYAnchor.constraint(lessThanOrEqualTo: surface.centerYAnchor, constant: offset.height),
			]
		case .greaterThanOrEqual:
			[
				centerXAnchor.constraint(greaterThanOrEqualTo: surface.centerXAnchor, constant: offset.width),
				centerYAnchor.constraint(greaterThanOrEqualTo: surface.centerYAnchor, constant: offset.height),
			]
		@unknown default:
			[]
		}
		return constraints
	}

	@available(macOS 11.0, *)
	public func constraintsMatchingEdgesWithSystemSpacing(
		of surface: LayoutSurface?,
		multipliedBy multiplier: CGSize = CGSize(width: 1, height: 1),
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		guard let surface else {
			return []
		}

		let constraints: [NSLayoutConstraint] = switch relation {
		case .equal:
			[
				leadingAnchor.constraint(
					equalToSystemSpacingAfter: surface.leadingAnchor,
					multiplier: multiplier.width
				),
				surface.trailingAnchor.constraint(
					equalToSystemSpacingAfter: trailingAnchor,
					multiplier: multiplier.width
				),
				topAnchor.constraint(equalToSystemSpacingBelow: surface.topAnchor, multiplier: multiplier.height),
				surface.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: multiplier.height),
			]
		case .lessThanOrEqual:
			[
				leadingAnchor.constraint(
					lessThanOrEqualToSystemSpacingAfter: surface.leadingAnchor,
					multiplier: multiplier.width
				),
				surface.trailingAnchor.constraint(
					lessThanOrEqualToSystemSpacingAfter: trailingAnchor,
					multiplier: multiplier.width
				),
				topAnchor.constraint(
					lessThanOrEqualToSystemSpacingBelow: surface.topAnchor,
					multiplier: multiplier.height
				),
				surface.bottomAnchor.constraint(
					lessThanOrEqualToSystemSpacingBelow: bottomAnchor,
					multiplier: multiplier.height
				),
			]
		case .greaterThanOrEqual:
			[
				leadingAnchor.constraint(
					greaterThanOrEqualToSystemSpacingAfter: surface.leadingAnchor,
					multiplier: multiplier.width
				),
				surface.trailingAnchor.constraint(
					greaterThanOrEqualToSystemSpacingAfter: trailingAnchor,
					multiplier: multiplier.width
				),
				topAnchor.constraint(
					greaterThanOrEqualToSystemSpacingBelow: surface.topAnchor,
					multiplier: multiplier.height
				),
				surface.bottomAnchor.constraint(
					greaterThanOrEqualToSystemSpacingBelow: bottomAnchor,
					multiplier: multiplier.height
				),
			]
		@unknown default:
			[]
		}

		return constraints
	}

	public func constraintsMatchingSize(
		of surface: LayoutSurface?,
		resizedBy size: CGSize = .zero,
		multipliedBy multiplier: CGSize = CGSize(width: 1, height: 1),
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		guard let surface else {
			return []
		}

		let constraints: [NSLayoutConstraint] = switch relation {
		case .equal:
			[
				widthAnchor.constraint(
					equalTo: surface.widthAnchor,
					multiplier: multiplier.width,
					constant: size.width
				),
				heightAnchor.constraint(
					equalTo: surface.heightAnchor,
					multiplier: multiplier.height,
					constant: size.height
				),
			]
		case .lessThanOrEqual:
			[
				widthAnchor.constraint(
					lessThanOrEqualTo: surface.widthAnchor,
					multiplier: multiplier.width,
					constant: size.width
				),
				heightAnchor.constraint(
					lessThanOrEqualTo: surface.heightAnchor,
					multiplier: multiplier.height,
					constant: size.height
				),
			]
		case .greaterThanOrEqual:
			[
				widthAnchor.constraint(
					greaterThanOrEqualTo: surface.widthAnchor,
					multiplier: multiplier.width,
					constant: size.width
				),
				heightAnchor.constraint(
					greaterThanOrEqualTo: surface.heightAnchor,
					multiplier: multiplier.height,
					constant: size.height
				),
			]
		@unknown default:
			[]
		}

		return constraints
	}

	public func constraintsMatchingSize(_ size: CGSize) -> [NSLayoutConstraint] {
		return [
			widthAnchor.constraint(equalToConstant: size.width),
			heightAnchor.constraint(equalToConstant: size.height),
		]
	}

	public func aspectRatioConstraint(ratio: Double = 1) -> NSLayoutConstraint {
		return widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio, constant: 0)
	}
}

#if canImport(UIKit)
private typealias View = UIView
#elseif canImport(AppKit)
private typealias View = NSView
#endif

// MARK: - View + LayoutSurface

extension View: LayoutSurface {
	public func constraintsMatchingEdgesOfSuperview(
		insetBy insets: NSDirectionalEdgeInsets = .zero,
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		return constraintsMatchingEdges(of: superview, insetBy: insets, relation: relation)
	}

	public func constraintsMatchingCenterOfSuperview(
		offsetBy offset: CGSize = .zero,
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		return constraintsMatchingCenter(of: superview, offsetBy: offset, relation: relation)
	}

	public func constraintsMatchingSizeOfSuperview(
		resizedBy size: CGSize = .zero,
		multipliedBy multiplier: CGSize = CGSize(width: 1, height: 1),
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		return constraintsMatchingSize(of: superview, resizedBy: size, multipliedBy: multiplier, relation: relation)
	}

	@available(macOS 11.0, *)
	public func constraintsMatchingEdgesWithSystemSpacingOfSuperview(
		multipliedBy multiplier: CGSize = CGSize(width: 1, height: 1),
		relation: NSLayoutConstraint.Relation = .equal
	) -> [NSLayoutConstraint] {
		return constraintsMatchingEdgesWithSystemSpacing(of: superview, multipliedBy: multiplier, relation: relation)
	}
}

#if canImport(UIKit)
extension UILayoutGuide: LayoutSurface {}
#elseif canImport(AppKit)
extension NSLayoutGuide: LayoutSurface {}
#endif

@MainActor
extension Array where Element: LayoutSurface {
	public func constraintsMatchingWidth() -> [NSLayoutConstraint] {
		guard
			let first,
			count > 1
		else {
			return []
		}
		let constraints = dropFirst().map {
			$0.widthAnchor.constraint(equalTo: first.widthAnchor)
		}
		return constraints
	}

	public func constraintsMatchingHeight() -> [NSLayoutConstraint] {
		guard
			let first,
			count > 1
		else {
			return []
		}
		let constraints = dropFirst().map {
			$0.heightAnchor.constraint(equalTo: first.heightAnchor)
		}
		return constraints
	}

	public func constraintsMatchingSize() -> [NSLayoutConstraint] {
		guard
			let first,
			count > 1
		else {
			return []
		}
		let constraints = dropFirst().flatMap {
			[
				$0.widthAnchor.constraint(equalTo: first.widthAnchor),
				$0.heightAnchor.constraint(equalTo: first.heightAnchor),
			]
		}
		return constraints
	}
}
#endif
