# EqualOne
![pub version](https://img.shields.io/pub/v/equalone)
![pub points](https://img.shields.io/pub/points/equalone)
![likes](https://img.shields.io/pub/likes/equalone)
[![example](https://github.com/dartius-dev/equalone/raw/main/example/example.svg)](https://github.com/dartius-dev/equalone/blob/main/example/)

`equalone` is a Dart utility package for deep equality, value-based comparison, and robust hashCode generation for any Dart object, including List, Map, Set, and nested collections. It solves common problems with object comparison, custom equality, and hashCode in Dart data classes, value objects, and collections. Use `equalone` to implement deep equality, shallow equality, and custom comparison logic for models, state objects, and when using objects as keys in Map or elements in Set. The package provides static methods, a wrapper class, and a mixin for easy integration with your Dart or Flutter projects.

## Why EqualOne?

```dart
  final a0 = {'k': 'v'};
  final a1 = {'k': 'v'};
  final b0 = {1,2,3};
  final b1 = {1,2,3};
  final c0 = [1,[2,3]];
  final c1 = [1,[2,3]];

  final values = {a0,b0,c0,''};

  print(a1 == a0);              // ❌ false 
  print(b1 == b0);              // ❌ false 
  print(c1 == c0);              // ❌ false 

  print(values.contains(a1));   // ❌ false 
  print(values.contains(b1));   // ❌ false 
  print(values.contains(c1));   // ❌ false 

  
  print(Equalone.equals(a0, a1));  // ✅ true      
  print(Equalone.equals(b0, b1));  // ✅ true
  print(Equalone.equals(c0, c1));  // ✅ true

  final a2 = Equalone({'k': 'v'});
  final b2 = Equalone({1,2,3});
  final c2 = Equalone([1,[2,3]]);

  final equalones = {...values.map(Equalone.new)};

  print(a2 == a0 && a2 == a1);     // ✅ true
  print(b2 == b0 && b2 == b1);     // ✅ true
  print(c2 == c0 && c2 == c1);     // ✅ true

  print(equalones.contains(a2));   // ✅ true
  print(equalones.contains(b2));   // ✅ true
  print(equalones.contains(c2));   // ✅ true

  // checks for empty elements
  print(values.any(Equalone.empty));    // ✅ true
  print(equalones.any(Equalone.empty)); // ✅ true
```

Because it's ALL in ONE! Simple, easy, accessible!

And that's NOT all! There's so much more to discover...

## Features

- Deep equality for any Dart object, including nested collections (List, Map, Set, Iterable)
- Shallow (top-level) equality for fast comparison
- Customizable equality and emptiness logic
- Type-agnostic: works with any value, including null
- Easy integration with models, state objects, and value classes
- Mixin for value-based equality in your own classes

## Getting started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  equalone: 
```

Import in your Dart code:

```dart
import 'package:equalone/equalone.dart';
```

`equalone` is built on top of the popular [`collection`](https://pub.dev/packages/collection) package for advanced equality and hashing.

For convenience, you can access `collection` features via:
```dart
import 'package:equalone/collection.dart';
```

This simply re-exports the official `collection` package used by `equalone`.

# Contents

- [EqualOne](#equalone)
  - [Why EqualOne?](#why-equalone)
  - [Features](#features)
  - [Getting started](#getting-started)
- [Contents](#contents)
  - [Usage](#usage)
  - [Using Static methods](#using-static-methods)
    - [`Equalone.empty(value)`](#equaloneemptyvalue)
    - [`Equalone.equals(a, b)`](#equaloneequalsa-b)
    - [`Equalone.deepEquals(a, b)`](#equalonedeepequalsa-b)
    - [`Equalone.shallowEquals(a, b)`](#equaloneshallowequalsa-b)
    - [deepEquals vs shallowEquals](#deepequals-vs-shallowequals)
    - [Customization](#customization)
  - [Using `Equalone` wrapper](#using-equalone-wrapper)
    - [Equality for collections](#equality-for-collections)
    - [Comparing with regular collections](#comparing-with-regular-collections)
    - [Null comparison](#null-comparison)
    - [Type sensitivity](#type-sensitivity)
    - [Custom equality](#custom-equality)
    - [Custom `hashCode`](#custom-hashcode)
  - [Extending `Equalone`](#extending-equalone)
    - [Customizing methods](#customizing-methods)
    - [Overriding Methods](#overriding-methods)
    - [Using an `Equalone` instance as a function](#using-an-equalone-instance-as-a-function)
    - [Using `PayloadEqualone`](#using-payloadequalone)
  - [Using `EqualoneMixin` in your classes](#using-equalonemixin-in-your-classes)
    - [Simple value-based equality in your class](#simple-value-based-equality-in-your-class)
    - [Deep equality for collections](#deep-equality-for-collections)
    - [Shallow, but correct, equality for collections](#shallow-but-correct-equality-for-collections)
  - [Caveats \& Warnings](#caveats--warnings)
    - [Cyclic Structures Warning](#cyclic-structures-warning)
    - [Deep Equality in Records](#deep-equality-in-records)
    - [Asymmetric Comparison](#asymmetric-comparison)
    - [Null Comparison](#null-comparison-1)
    - [Customization Consistency](#customization-consistency)
    - [Collections in EqualoneMixin](#collections-in-equalonemixin)
    - [Equalone HashCode Limitations](#equalone-hashcode-limitations)
  - [Additional information](#additional-information)
  - [License](#license)


## Usage

You can use the `equalone` package in several main ways:

- [Static methods](#using-static-methods): Use static methods like `Equalone.equals`, `Equalone.deepEquals`, `Equalone.shallowEquals`, and `Equalone.empty` for quick, type-agnostic checks and comparisons.
- [Wrapper class](#using-equalone-wrapper): Wrap any value or collection in the `Equalone` class to enable robust equality and hashCode logic, especially for use in sets, maps, or when comparing complex/nested objects.
- [Creating your own Equalone class](#extending-equalone): You can extend the base `Equalone` class to implement custom comparison and hashing logic.
- [Using an Equalone instance as a function](#using-an-equalone-instance-as-a-function): An `Equalone` subclass instance can be used as a callable function to check the equality of values. 
- [Mixin for custom classes](#using-equalonemixin-in-your-classes): Add value-based equality to your own classes by mixing in `EqualoneMixin` and specifying which fields should participate in equality and hashCode calculations.

## Using Static methods

### `Equalone.empty(value)`
Checks if a value is empty (null, empty string, or empty collection). This method is customizable.

```dart
Equalone.empty(null);       // ✅ true
Equalone.empty('');         // ✅ true
Equalone.empty([]);         // ✅ true
Equalone.empty([1, 2, 3]);  // ❌ false 
Equalone.empty('hello');    // ❌ false 
```

### `Equalone.equals(a, b)`
Customizable equality check (uses `deepEquals` by default). This is considered the default equality method for your application.

Suitable for comparing any values, including collections.

```dart
Equalone.equals([1, 2, 3], [1, 2, 3]);           // ✅ true  
Equalone.equals({'a': 1}, {'a': 1});             // ✅ true  
Equalone.equals([1, 2, 3], [3, 2, 1]);           // ❌ false 
Equalone.equals([[1, 2], [3]], [[1, 2], [3]]);   // ✅ true, if customized with deepEquals
Equalone.equals('abc', 'abc');                   // ✅ true  
Equalone.equals(null, null);                     // ✅ true  
```

### `Equalone.deepEquals(a, b)`
Performs a deep recursive equality check for any values, including nested collections. Ignores reference identity and compares  contents.

```dart
Equalone.deepEquals([1, [2, 3]], [1, [2, 3]]);      // ✅ true  
Equalone.deepEquals([1, [2, 3]], [1, [3, 2]]);      // ❌ false 
Equalone.deepEquals({'x': [1, 2]}, {'x': [1, 2]});  // ✅ true  
Equalone.deepEquals({'x': [1, 2]}, {'x': [2, 1]});  // ❌ false 
Equalone.deepEquals([[1, 2], [3]], [[1, 2], [3]]);  // ✅ true  
```

You can control type sensitivity with the `ignoreType` parameter (default: `true`).
```dart
Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: true);   // ✅ true   
Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false);  // ❌ false  
```

### `Equalone.shallowEquals(a, b)`
Performs a top-level (shallow) equality check for any values. For collections, only the first level of elements is compared (not nested contents).

```dart
Equalone.shallowEquals([1, [2, 3]], [1, [2, 3]]);      // ❌ false  (see deepEquals)
Equalone.shallowEquals([1, 2, 3], [1, 2, 3]);          // ✅ true  
Equalone.shallowEquals([1, 2, 3], [3, 2, 1]);          // ❌ false 
Equalone.shallowEquals({'a': 1}, {'a': 1});            // ✅ true  
Equalone.shallowEquals({'a': 1}, {'a': 2});            // ❌ false 
Equalone.shallowEquals({'x': [1, 2]}, {'x': [1, 2]});  // ❌ false  (see deepEquals)
Equalone.shallowEquals([[1, 2], [3]], [[1, 2], [3]]);  // ❌ false  (see deepEquals)
```

You can control type sensitivity with the `ignoreType` parameter (default: `true`).
```dart
Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: true);  // ✅ true   
Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false); // ❌ false 
```
### deepEquals vs shallowEquals

- **`deepEquals`** performs a deep, recursive comparison: it checks all elements of collections, including nested structures. Two lists, maps, or sets are considered equal if their contents (and the contents of any nested collections) are equal by value, regardless of object references.

- **`shallowEquals`** performs only a top-level (shallow) comparison: it compares only the first-level elements of collections, without checking nested structures. If an element is itself a collection, only its reference (identity) is compared, not its contents.


```dart
final a = [1, [2, 3]];
final b = [1, [2, 3]];

Equalone.deepEquals(a, b);    // ✅ true  (nested list contents are equal)
Equalone.shallowEquals(a, b); // ❌ false (nested lists are different objects)

final c = [1, 2, 3];
final d = [1, 2, 3];

Equalone.deepEquals(c, d);    // ✅ true
Equalone.shallowEquals(c, d); // ✅ true
```

Use `deepEquals` for comparing complex or nested structures, and `shallowEquals` for fast, top-level collection comparison.

> **Note:** `deepEquals` performs a recursive, thorough comparison of all nested elements, which makes it significantly more computationally intensive and slower than `shallowEquals`. Use `deepEquals` when you need full structural comparison, but prefer `shallowEquals` for performance-critical or simple top-level checks.

Here is a table summarizing the main differences between `deepEquals` and `shallowEquals`:

| Aspect                | `deepEquals`                                                                 | `shallowEquals`                                                      |
|-----------------------|------------------------------------------------------------------------------|----------------------------------------------------------------------|
| Comparison depth      | Recursively compares all nested elements and collections                     | Compares only the top-level elements; nested collections by reference|
| Use case              | For full structural comparison of complex/nested objects                     | For fast, top-level comparison where nested structure is not important|
| Performance           | Slower (recursive, more computationally intensive)                           | Faster (non-recursive, less computation)                             |
| Nested collections    | Compared by value (contents)                                                 | Compared by reference (identity)                                     |
| Typical usage         | Comparing models, state objects, or deeply nested data                       | Quick checks, top-level collections, performance-critical scenarios  |

### Customization

You can globally override the equality and emptiness logic:

```dart
import 'package:equalone/collection.dart';

Equalone.customize(
  // Type-insensitive unordered deep equality
  equals: const DeepCollectionEquality.unordered().equals, 
  empty: (v) => v is num ? v == 0 : Equalone.defaultEmpty(v),
);

print(Equalone.equals([1, 2, 3], [3, 2, 1]));      // ✅ true 
print(Equalone.equals([1, 2, 3], <num>[3, 2, 1])); // ✅ true  

print(Equalone.empty(0));    // ✅ true  
print(Equalone.empty(1));    // ❌ false 
print(Equalone.empty([]));   // ✅ true  
print(Equalone.empty(null)); // ✅ true  
```

Case-insensitive string comparison:

```dart
Equalone.customize(
  equals: (a, b) => a is String && b is String
      ? a.toLowerCase() == b.toLowerCase()
      : Equalone.deepEquals(a, b),
);

print(Equalone.equals('Hello', 'hello')); // ✅ true  
print(Equalone.equals('Hello', 'world')); // ❌ false 
```

> Use `Equalone.customize` to globally customize default comparison and emptiness logic to match requirements of your app.

**Local customization** also possible.

The example below demonstrates how to locally customize the equality logic for a specific context or block of code, without affecting the global behavior.


```dart
final restore = Equalone.customize(
  equals: const DeepCollectionEquality().unordered().equals,
);

print(Equalone.equals([1, 2, 3], [3, 2, 1]));      // ✅ true 

restore(); // Restores previous equality logic

print(Equalone.equals([1, 2, 3], [3, 2, 1]));      // ❌ false  

```

The `customize` method returns a `restore` function, which can be called to revert to the previous (default) equality logic.  
This allows for flexible, context-specific equality comparisons without permanently affecting global behavior.

- Use `Equalone.customize` to set a custom equality function.
- All calls to `Equalone.equals` will use the new logic until `restore()` is called.
- After calling `restore()`, the default equality logic is reinstated.


## Using `Equalone` wrapper

You can wrap any value, collection, or object in an `Equalone` instance to enable robust equality and hashCode logic. This is especially useful when you want to compare complex or nested structures, use them as keys in maps, or store them in sets.

### Equality for collections

```dart
final a = Equalone([1, 2, 3]);
final b = Equalone([1, 2, 3]);

print(a == b);                    // ✅ true (deep equality for lists)
print(a.hashCode == b.hashCode);  // ✅ true  

final c = Equalone({'x': 1, 'y': 2});
final d = Equalone({'x': 1, 'y': 2});

print(c == d); // ✅ true (deep equality for maps)
```

By default, `deepEquals` is used for equality checks.

But you can explicitly specify the comparison method using `Equalone.deep` for deep equality or `Equalone.shallow` for shallow equality.

```dart
  final a = Equalone.deep([1, [2, 3]]);
  final b = Equalone.shallow([1, [2, 3]]);

  print(a == b);  // ✅ true (deep equality)
  print(b == a);  // ❌ false (shallow equality)
```

### Comparing with regular collections

You can even compare an `Equalone` instance with regular collections. However, avoid comparing regular collections directly to `Equalone`, as this may lead to unexpected or incorrect results.

```dart
final e = Equalone([1, 2, 3]);
final f = [1, 2, 3];

print(e == f); // ✅ true  
print(f == e); // ❌ false 
```

### Null comparison

You cannot directly compare an `Equalone` instance with a regular `null` value. For consistent and correct results, always wrap `null` values in an `Equalone` instance before comparison.

```dart
final g = Equalone(null);
final h = Equalone(null);

print(g == h);    // ✅ true  
print(g.hashCode == null.hashCode); // ✅ true  
print(g == null); // ❌ false 
print(null == g); // ❌ false 
```

### Type sensitivity

You can control whether type differences are considered in equality checks using the `ignoreType` parameter. By default, `ignoreType` is set to `true`, so type differences are ignored. If you set `ignoreType: false`, values with different types (e.g., `List<int>` and `List<num>`) will not be considered equal, even if their contents match.

```dart
final c = Equalone([1, 2, 3], ignoreType: true);
final d = Equalone(<num>[1, 2, 3], ignoreType: false);

print(c == d); // ✅ true (ignores type differences)
print(d == c); // ❌ false (type differences matter for d)
```


### Custom equality 

You can provide a custom equality function via the `equalsMethod` parameter. For example, to compare lists by their sum:

```dart
bool sumEquals(Object? a, Object? b) => (a is List<num> && b is List<num>)
       ? (a.fold<num>(0, (num s, v) => s + v) == b.fold<num>(0, (num s, v) => s + v))
       : false;

final a = Equalone([3, 3], equalsMethod: sumEquals);
final b = Equalone([1, 2, 3], equalsMethod: sumEquals);

print(a == b); // ✅ true (both sum to 6)
```


### Custom `hashCode`

You can provide a custom hash code calculation for an `Equalone` instance using the `hashCodeMethod` parameter. This is useful when you want the hash code to reflect a specific property or a custom combination of values, rather than relying on the default `Equalone` hash logic provided by `hashCodeBuilder` static method.


```dart
int sumHashCode(Object? value, {bool ignoreType = true}) => value is List<num> 
  ? value.fold<num>(0, (s, v) => s + v).hashCode 
  : Equalone.hashCodeBuilder(value, ignoreType: ignoreType);

final a = Equalone([3, 3], equalsMethod: sumEquals, hashCodeMethod: sumHashCode);
final b = Equalone([1, 2, 3], equalsMethod: sumEquals, hashCodeMethod: sumHashCode);
final c = Equalone([2, 2, 2], equalsMethod: sumEquals, hashCodeMethod: sumHashCode);

print(a == b);                    // ✅ true (both sum to 6)
print(a.hashCode == b.hashCode);  // ✅ true (hash code is 6.hashCode)

final s = {a,b};                  // s = {Equalone([1, 2, 3])}

print(s.length);                  // 1 (`b` was not added)
print(s.contains(b));             // ✅ true (`b` has the same hash as `a`)
print(s.contains(c)));            // ✅ true

```

You can use any logic for `hashCodeMethod` that matches your equality logic. This is especially important when using `Equalone` as a key in a `Map` or as an element in a `Set`, as hash codes must be consistent with equality.

Another example: using only a specific property of a map for hashing and equality:

```dart
int idHashCode(Object? value) => value is Map && value['id'] != null 
    ? value['id'].hashCode : 
    : Equalone.hashCodeBuilder(value, ignoreType: ignoreType);

bool idEquals(Object? a, Object? b) =>
  a is Map && b is Map ? a['id'] == b['id'] : false;

final a = Equalone(
    {'id': 42, 'name': 'One'}, 
    equalsMethod: idEquals, 
    hashCodeMethod: idHashCode);

final b = Equalone(
    {'id': 42, 'name': 'Equ'}, 
    equalsMethod: idEquals, 
    hashCodeMethod: idHashCode);

print(a == b); // ✅ true (same id)
print(a.hashCode == b.hashCode); // ✅ true (hash code is based on id)
```

> **Note:** Always ensure that your custom `hashCodeMethod` is consistent with your `equalsMethod` to avoid unexpected behavior in collections.

## Extending `Equalone`

Customizing is great, but having to set custom methods every time is not always convenient.

That's why, in addition to using `Equalone` directly, you can create your own subclasses with specific logic tailored to your needs.

You can create your own classes that extend `Equalone` to add custom behavior or additional methods while retaining robust value-based equality and hashCode logic.

For even more control, you can fully override the `testEquals` and `getHashCode` methods in your own subclass of `Equalone`. This approach is useful if you need to implement advanced or non-standard comparison and hashing logic.

To customize or override equality and hashing behavior for specialized use cases you can use the base static methods of `Equalone` :

- `Equalone.hashCodeBuilder`
- `Equalone.deepEquals`
- `Equalone.shallowEquals`

The extending allows you to adapt `Equalone` to any scenario that requires custom equality or hashing logic.

### Customizing methods 

When extending `Equalone`, pass the value you want to wrap to the superclass constructor, and optionally provide custom equality and/or hash logic. 

You can provide custom handlers and hash code for your `Equalone` subclass by passing your own `equalsMethod` and `hashCodeMethod` to the `Equalone` constructor. This allows you to define exactly how two values are compared and how the hash code is calculated.

Let's see how you can simplify working with the [example of comparing lists by the sum of their elements](#custom-equality):

```dart
class EqualoneSum<T extends num> extends Equalone<List<T>> {
  const EqualoneSum(super.value) : super(
      equalsMethod: sumEquals,
      hashCodeMethod: sumHashCode
    );
}

final a = EqualoneSum([3, 3]);
final b = EqualoneSum([1, 2, 3]);
final c = EqualoneSum([2, 2, 2]);

print(a == b);                    // ✅ true (both sum to 6)
print(a.hashCode == b.hashCode);  // ✅ true (hash code is 6.hashCode)

final s = {a,b};                  // s = {EqualoneSum([1, 2, 3])}

print(s.length);                  // 1 (`b` was not added)
print(s.contains(b));             // ✅ true 
print(s.contains(c));             // ✅ true

```


### Overriding Methods

The most straightforward way to create a class based on `Equalone` with custom logic is to implement the logic directly in the class methods `testEquals` and `getHashCode`.

Here’s how such a class would look for our [previous example](#customizing-methods):

```dart
class EqualoneSum extends Equalone<List<num>> {
  const EqualoneSum([super.value = const []]);

  @override
  bool testEquals(Object? a, Object? b) =>
    (a is List<num> && b is List<num>)
      ? (a.fold<num>(0, (num s, v) => s + v) == b.fold<num>(0, (num s, v) => s + v))
      : false;

  @override
  int getHashCode(List<num> value) =>
    value.fold<num>(0, (s, v) => s + v).hashCode;
}

final a = EqualoneSum([3, 3]);
final b = EqualoneSum([1, 2, 3]);

print(a == b);                    // ✅ true (both sum to 6)
print(a.hashCode == b.hashCode);  // ✅ true (hash code is 6.hashCode)
```

No separate functions are needed — all logic is contained within a single class.

### Using an `Equalone` instance as a function

As you may have noticed, in the previous example above, the `value` parameter in the constructor is optional.

This was done intentionally, because an instance of `EqualoneSum` can be used as a function to compare two values:

```dart
  final equalsBySum = const EqualoneSum();

  final a = EqualoneSum([3, 3]);

  print( equalsBySum([1,2,3], [3,3]) ); // ✅ true 
  print( equalsBySum([1,2,3], a) );     // ✅ true 
```

well, you can also use the `hashCode` getter method:

```dart
print( equalsBySum.getHashCode([2,2,2]) ); // 69606
```
You can customize the default `Equalone.equals` method by supplying your own equality function from an `Equalone` subclass. For example, to use the sum-based equality from `EqualoneSum`:

```dart
final restore = Equalone.customize(
  equals: const EqualoneSum().call,
);

print(Equalone.equals([1, 2, 3], [3, 3])); // ✅ true 
print(Equalone.equals([1, 2, 3], a));      // ✅ true 

restore();

print(Equalone.equals([1, 2, 3], [3, 3])); // ❌ false 
print(Equalone.equals([1, 2, 3], a));      // ❌ false 
```

This temporarily sets the equality logic to compare lists by their sum, as defined in `EqualoneSum`. After calling `restore()`, the default logic is restored.

### Using `PayloadEqualone`

The `PayloadEqualone` class is designed to associate additional payload data (`data`) with a value (`value`)
that is compared using the [Equalone] equality logic.

The main purpose of this class is to bind extra data (`data`) to a value (`value`) that participates in
equality and hashCode calculations via [Equalone]. While equality and hashCode are determined solely by `value`,
the `data` field allows you to attach related information that does not affect comparison.

Use Cases
- Attaching metadata or auxiliary information to a value object that is used as a key in collections or for comparison.
- Keeping a reference to the original data or context while using [Equalone] for equality checks.
- Associating additional payloads with values in state management, caching, or mapping scenarios.

```dart
// You want to compare users by their ID, but also keep their full profile as payload.
final user = UserProfile(id: 123, name: 'One');
final userEqualone = PayloadEqualone(
  user.id, // value used for equality
  data: user,
);
// Only the value (123) is used for equality:
final anotherEqualone = PayloadEqualone(123, data: UserProfile(id: 123, name: 'Equ'));

print(userEqualone == anotherEqualone); // ✅ true

// You can still access the associated data:
print(userEqualone.data.name); // 'One'
```

This class is useful when you need to compare objects by a specific value but also need to retain
associated data for further processing or retrieval.


## Using `EqualoneMixin` in your classes

You can add robust, value-based equality and hashCode logic to your own classes by mixing in `EqualoneMixin`. This is especially useful for data classes, value objects, and models where you want equality to depend on the values of specific fields rather than object identity.

To use `EqualoneMixin`, simply add `with EqualoneMixin` to your class declaration and override the `equalones` getter to return a list of all fields that should participate in equality and hashCode calculations. For collections or nested objects, wrap them in `Equalone` to ensure deep equality.

**Benefits:**
- Eliminates boilerplate code for `==` and `hashCode`.
- Ensures consistent, reliable equality logic across your codebase.
- Supports deep equality for collections and nested structures.

### Simple value-based equality in your class

```dart
class Point with EqualoneMixin {
  final int x;
  final int y;
  Point(this.x, this.y);
  @override
  List<Object?> get equalones => [x, y];
}

final a = Point(1, 2);
final b = Point(1, 2);
print(a == b); // ✅ true  
```

### Deep equality for collections

```dart
class PersonDeep with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonDeep(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, Equalone(scores)];
}

final a = PersonDeep('One', [1, 2, 3]);
final b = PersonDeep('One', [1, 2, 3]);
print(a == b); // ✅ true (deep equality for the list)
```

### Shallow, but correct, equality for collections

```dart
class PersonShallow with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonShallow(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, ...scores];
}

final a = PersonShallow('One', [1, 2, 3]);
final b = PersonShallow('One', [1, 2, 3]);
print(a == b); // ✅ true   
```

## Caveats & Warnings

### Cyclic Structures Warning

`Equalone.deepEquals` does **not** detect or handle cyclic (self-referencing) data structures. Passing collections with cycles (e.g., a list that contains itself) will result in a stack overflow or infinite recursion.

```dart
final a = [];
a.add(a);

Equalone.deepEquals(a, a); // 🚫 This will cause a stack overflow:
```
Avoid using `deepEquals` on cyclic data structures. If you need to compare potentially cyclic graphs, consider using specialized libraries that support cycle detection.

### Deep Equality in Records 

Unlike collections, Dart's `Record` type does **not** support deep equality out of the box. When you compare two records that contain complex objects (such as lists, maps, or sets), the comparison and `hashCode` calculation are performed using reference equality for those inner objects, not by their contents.

This means that two records with identical nested collections will not be considered equal unless the nested objects are the exact same instances.

```dart
final r1 = (a: [1, 2, 3], b: {'x': 1});
final r2 = (a: [1, 2, 3], b: {'x': 1});

print(r1 == r2); // ❌ false (different list and map instances)
print(r1.hashCode == r2.hashCode); // ❌ false
```

Even though the contents of `a` and `b` are the same in both records, the equality check fails because the lists and maps are different objects in memory.

**With Equalone:**

Wrapping a record to `Equalone` will not help...

```dart
final e1 = Equalone((a: [1, 2, 3], b: {'x': 1}));
final e2 = Equalone((a: [1, 2, 3], b: {'x': 1}));

print(e1 == e2); // ❌ false (different list and map instances)
print(e1.hashCode == e2.hashCode); // ❌ false

```

To achieve deep equality for records, wrap the inner collections with `Equalone`:

```dart
final r1 = (a: Equalone([1, 2, 3]), b: Equalone({'x': 1}));
final r2 = (a: Equalone([1, 2, 3]), b: Equalone({'x': 1}));

print(r1 == r2); // ✅ true (deep equality for collections)
print(r1.hashCode == r2.hashCode); // ✅ true
```

By wrapping the collections with `Equalone`, you ensure that equality and hashCode are based on the contents, not just references.

> **Note:** If you use records with nested collections and want value-based comparison, always wrap those collections with `Equalone` to avoid subtle bugs and unexpected behavior.

### Asymmetric Comparison

When comparing an `Equalone` instance with a regular collection, the result may be asymmetric.

```dart
final a = Equalone([1, 2, 3]);
final b = [1, 2, 3];
print(a == b); // ✅ true  
print(b == a); // ❌ false
```
This is because the equality logic is determined by the left-hand operand. Always use `Equalone` as the left operand for consistent results.

### Null Comparison

Equality and hashCode behavior with `null` values can be non-intuitive.

```dart
final a = Equalone(null);
final b = null;
final c = Equalone(null);
print(a == b); // ❌ false
print(a == c); // ✅ true  
print(a.hashCode == null.hashCode); // ✅ true  
```
Comparing `Equalone(null)` with `null` using `==` returns `false`, but `Equalone(null) == Equalone(null)` returns `true`. The `hashCode` of `Equalone(null)` is equal to `null.hashCode`.

### Customization Consistency

Always use the same custom settings for all compared `Equalone` instances to avoid unexpected results.

```dart
final a = Equalone([1, 2, 3], ignoreType: true);
final b = Equalone(<num>[1, 2, 3], ignoreType: false);
print(a == b); // ✅ true  
print(b == a); // ❌ false (different ignoreType)

final c = Equalone([1, 2, 3], ignoreType: true);
final d = Equalone(<num>[1, 2, 3], ignoreType: true);
print(c == d); // ✅ true   
print(d == c); // ✅ true   
```
If you use custom `equalsMethod` or `ignoreType` settings, ensure that all compared `Equalone` instances use the same settings. Comparing instances with different settings may lead to unexpected or asymmetric results.

### Collections in EqualoneMixin

When using `EqualoneMixin`, always wrap collections in `Equalone` for deep equality; otherwise, only reference equality is checked.

```dart
class Person with EqualoneMixin {
  final String name;
  final List<int> scores;
  Person(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, scores]; // Not wrapped: shallow reference equality 
}

final a = Person('One', [1, 2, 3]);
final b = Person('One', [1, 2, 3]);
print(a == b); // ❌ false (different list references)

class PersonDeep with EqualoneMixin {
  final String name;
  final List<int> scores;
  const PersonDeep(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, Equalone(scores)]; // Wrapped: deep equality
}

final c = PersonDeep('One', [1, 2, 3]);
final d = PersonDeep('One', [1, 2, 3]);
print(c == d); // ✅ true (deep equality)
```
When using `EqualoneMixin`, be careful with mutable collections in the `equalones` list. Prefer wrapping collections in `Equalone` to ensure deep equality and avoid unexpected behavior due to reference identity.

### Equalone HashCode Limitations

The default `hashCode` for collections is based on their length and type, not their contents. This means that two collections with the same length but different elements may have the same `hashCode`.

```dart
final a = Equalone([1, 2, 3]);
final b = Equalone([4, 5, 6]);
print(a.hashCode == b.hashCode); // ✅ true (same length, same type)
print(a == b); // ❌ false (different contents)
```
For use as map keys, always rely on equality, not just `hashCode`.

However, you can still use `Equalone` as a value in a `Set` or as a key in a `Map`:

```dart
final set12 = {Equalone([1, 2])};
print(set12.contains(Equalone([1, 2]))); // ✅ true  
print(set12.contains(Equalone([2, 1]))); // ❌ false

final map12 = {Equalone([1, 2]): "12"};
print(map12.containsKey(Equalone([1, 2]))); // ✅ true  
print(map12.containsKey(Equalone([2, 1]))); // ❌ false
```

## Additional information

See the `/example` folder for more comparison scenarios:
* [example.dart](https://github.com/dartius-dev/equalone/blob/main/example/example.dart) and [console output](https://github.com/dartius-dev/equalone/blob/main/example/example.output.md)
* [example_test.dart](https://github.com/dartius-dev/equalone/blob/main/example/example.test.dart) - assert-based tests

Explore the `/test` folder for a suite of automated tests covering features, edge cases, and caveats of `equalone`:
* [equalone_test.dart](https://github.com/dartius-dev/equalone/blob/main/test/equalone_test.dart)
  
Experiment by adding tests for your own cases.

By studying the example and tests, you'll gain a deeper and more practical understanding of how to use `equalone` effectively and safely in your own projects.

Issues and suggestions are welcome!

## License

MIT
