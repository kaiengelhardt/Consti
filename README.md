![Header image for Consti, the library providing convenience APIs for Apple's Auto Layout](.images/header.png "Header image – 'Consti - Convenient Auto Layout'")

# Consti
Consti is a tiny library to make working with Auto Layout more convenient.

# Usage

## Constraint Creation APIs
Consti provides you convenience APIs for the most common cases of creating Auto Layout constraints.

### 1. Pinning to Edges
```
view.addSubview(contentView)
contentView.translatesAutoResizingMaskIntoConstraints = false

// Instead of this:
NSLayoutConstraint.activate([
	contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
	contentView.topAnchor.constraint(equalTo: view.topAnchor),
	contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
	contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
])

// You can now write this:
NSLayoutConstraint.activate(contentView.constraintsMatchingEdgesOfSuperview())
```

### 2. Pin to Safe Area
```
view.addSubview(contentView)
contentView.translatesAutoResizingMaskIntoConstraints = false

// Instead of this:
NSLayoutConstraint.activate([
	contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
	contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
	contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
	contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
])

// You can now write this:
NSLayoutConstraint.activate(contentView.constraintsMatchingEdges(of: view.safeAreaLayoutGuide))
```

### 3. Set Priorities
```
let constraints = 
```

### 4. Other

```
// Setting up aspect ratio
imageView.aspectRatioConstraint().isActive = true // 1:1 aspect ratio
imageView.aspectRatioConstraint(ratio: 16 / 9).isActive = true // 16:9 aspect ratio
```


## The `@ActiveConstraint` Property Wrapper
`@ActiveConstraint` is a property wrapper, which helps you correctly activate and deactivate mutually exclusive layout constraints. Just mark a property of type `NSLayoutConstraint`, `[NSLayoutConstraint]` or `NSLayoutConstraint?` with `@ActiveConstraint` and assign properties you want to be active to the property. If you subsequently assign properties again, the previously assigned constraints will be deactivated, thus preventing the common "Unable to simultaneously satisfy constraints" error.

### Example
Here's an example showing how you might change the constraints for a button that should have a completely different layout in portrait vs landscape on iPhone.

```
@ActiveConstraint() private var buttonConstraints: [NSLayoutConstraint]

override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
	super.traitCollectionDidChange(previousTraitCollection)
	let isiPhonePortrait = traitCollection.verticalSizeClass == .regular
		&& traitCollection.horizontalSizeClass == .compact
	if isiPhonePortrait {
		buttonConstraints = ... // Constraints for portrait layout.
	} else {
		buttonConstraints = ... // Constraints for landscape layout.
	}
}

```

# Installation
Add this to your `Package.swift` file.

```
.package(url: "https://github.com/kaiengelhardt/consti", from: "1.0.0"),
```

# Contributions
Contributions in general are welcome, however there is a few guidelines to follow:

1. This package is not intended to be a replacement for the Auto Layout API. The philosophy is "Fill the gaps and add a few helpers".
2. New APIs should read and feel like they belong in UIKit directly, e.g. follow the same naming conventions and style.

# Name
The name of the library is a combincation of the word constraint, which this library is all about, and my very good friend and colleague Konsti.
