# Consti
Consti is a tiny library for making working with Auto Layout more convenient.

# Constraint Creation APIs


# The `@ActiveConstraint` Property Wrapper
`@ActiveConstraint` is a property wrapper, which helps you correctly activate and deactivate mutually exclusive layout constraints. Just mark a property of type `NSLayoutConstraint`, `[NSLayoutConstraint]` or `NSLayoutConstraint?` with `@ActiveConstraint` and assign properties you want to be active to the property. If you subsequently assign properties again, the previously assigned constraints will be deactivated, thus preventing the common "Unable to simultaneously satisfy constraints" error.

## Example
```
@ActiveConstraint() private var titleLabelConstraints: [NSLayoutConstraint]

override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
	super.traitCollectionDidChange(previousTraitCollection)
	let isiPhonePortrait = traitCollection.verticalSizeClass == .regular
		&& traitCollection.horizontalSizeClass == .compact
	if isiPhonePortrait {
		titleLabelConstraints = ... // Constraints for portrait layout.
	} else {
		titleLabelConstraints = ... // Constraints for landscape layout.
	}
}

```

# Contributions
Contributions in general are welcome, however there is a few guidelines to follow:

1. This package is not intended to be a replacement for the Auto Layout API. The philosophy is "Fill the gaps and add a few helpers".
2. New APIs should read and feel like they belong in UIKit directly, e.g. follow the same naming conventions and style.

# Name
The name of the library is a combincation of the word constraint, which this library is all about, and my very good friend and colleague Konsti.
