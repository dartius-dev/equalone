# EqualOne
![pub version](https://img.shields.io/pub/v/equalone)
![pub points](https://img.shields.io/pub/points/equalone)
![likes](https://img.shields.io/pub/likes/equalone)
[![example](https://github.com/dartius-dev/equalone/raw/main/example/example.svg)](https://github.com/dartius-dev/equalone/blob/main/example/)

`equalone` is a Dart utility package for deep equality, value-based comparison, and robust hashCode generation for any Dart object, including List, Map, Set, and nested collections. It solves common problems with object comparison, custom equality, and hashCode in Dart data classes, value objects, and collections. Use `equalone` to implement deep equality, shallow equality, and custom comparison logic for models, state objects, and when using objects as keys in Map or elements in Set. The package provides static methods, a wrapper class, and a mixin for easy integration with your Dart or Flutter projects.

## Why EqualOne?

```dart
class Person with EqualoneMixin {
  final String name;
  final List<int> scores;
  final Map props;

  Person(this.name, this.scores, this.props);

  @override
  List<Object?> get equalones => [
    name.toUpperCase()), 
    Equalone(scores, equality: const ShallowCollectionEquality.unordered()),
    Equalone.deep(props)
  ];
}

final a = Person('One', [1, 2, 3], {'a':{'n':5}, 'b':[1]} );
final b = Person('one', [3, 2, 1], {'b':[1], 'a':{'n':5}} );

print(a == b); // ✅ true
```

and even more

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

  
  print(Equalone.deepEquals(a0, a1));  // ✅ true      
  print(Equalone.deepEquals(b0, b1));  // ✅ true
  print(Equalone.deepEquals(c0, c1));  // ✅ true

  final a2 = Equalone.deep({'k': 'v'});
  final b2 = Equalone.deep({1,2,3});
  final c2 = Equalone.deep([1,[2,3]]);

  final equalones = {...values.map(Equalone.deep)};

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

Simple, easy, accessible!

And that's NOT all! There's so much more to discover...

## Features

- Deep equality for any Dart object, including nested collections (List, Map, Set, Iterable)
- Shallow (top-level) equality for fast comparison
- Type-agnostic: works with any value, including null
- Easy integration with models, state objects, and value classes
- Mixin for value-based equality in your own classes

## Getting started

Add to your `pubspec.yaml`:

```yaml
dependencies:
  equalone: 2.0.0
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
  - [Using `EqualoneMixin` in your classes](#using-equalonemixin-in-your-classes)
    - [Simple value-based equality in your class](#simple-value-based-equality-in-your-class)
    - [Spread equality for collections](#spread-equality-for-collections)
    - [Shallow equality for collections](#shallow-equality-for-collections)
    - [Custom equalities for collections](#custom-equalities-for-collections)
  - [Using Static methods](#using-static-methods)
    - [`Equalone.empty(value)`](#equaloneemptyvalue)
    - [`Equalone.deepEquals(a, b)`](#equalonedeepequalsa-b)
    - [`Equalone.shallowEquals(a, b)`](#equaloneshallowequalsa-b)
    - [deepEquals vs shallowEquals](#deepequals-vs-shallowequals)
  - [Using `Equalone` wrapper](#using-equalone-wrapper)
    - [Equality for objects](#equality-for-objects)
    - [Equality for collections](#equality-for-collections)
    - [Comparing with regular collections](#comparing-with-regular-collections)
    - [Null comparison](#null-comparison)
  - [Caveats \& Warnings](#caveats--warnings)
    - [Cyclic Structures Warning](#cyclic-structures-warning)
    - [Deep Equality in Records](#deep-equality-in-records)
    - [Asymmetric Comparison](#asymmetric-comparison)
    - [Null Comparison](#null-comparison-1)
    - [Collections in EqualoneMixin](#collections-in-equalonemixin)
  - [Additional information](#additional-information)
  - [License](#license)


## Usage

You can use the `equalone` package in several main ways:

- [Mixin for custom classes](#using-equalonemixin-in-your-classes): Add value-based equality to your own classes by mixing in `EqualoneMixin` and specifying which fields should participate in equality and hashCode calculations.
- [Static methods](#using-static-methods): Use static methods `Equalone.deepEquals`, `Equalone.shallowEquals` and `Equalone.empty` for quick, type-agnostic checks and comparisons.
- [Wrapper class](#using-equalone-wrapper): Wrap any value or collection in the `Equalone` class to enable robust equality and hashCode logic, especially for use in sets, maps, or when comparing complex/nested objects.

## Using `EqualoneMixin` in your classes

You can add robust, value-based equality and hashCode logic to your own classes by mixing in `EqualoneMixin`. This is especially useful for data classes, value objects, and models where you want equality to depend on the values of specific fields rather than object identity.

To use `EqualoneMixin`, simply 

- add `with EqualoneMixin` to your class declaration 
- override the `equalones` getter to return a list of all fields that should participate in equality and hashCode calculations. 
- for collections wrap them in `Equalone` to ensure deep equality

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

### Spread equality for collections

```dart
class PersonSpread with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonSpread(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, ...scores];
}

final a = PersonSpread('One', [1, 2, 3]);
final b = PersonSpread('One', [1, 2, 3]);

print(a == b); // ✅ true   
```

### Shallow equality for collections

```dart
class Person with EqualoneMixin {
  final String name;
  final List<int> scores;
  Person(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, Equalone.shallow(scores)];
}

final a = Person('One', [1, 2, 3]);
final b = Person('One', [1, 2, 3]);

print(a == b); // ✅ true (equality for the list)
```

### Custom equalities for collections

```dart
class Complex with EqualoneMixin {
  final Map props;
  final List<int> scores;
  final List<Point> points;
  Complex(this.props, this.scores, this.points);

  @override
  List<Object?> get equalones => [
    // deep equality
    Equalone.deep(props),
    // unordered shallow equality
    Equalone(scores, equality: const ShallowCollectionEquality.unordered()),
    // equality based on the sum of x and y for each element
    Equalone(points, equality: ListEquality<Point>(EqualityBy((p)=>p.x + p.y))), 
  ];
}

final a = Complex({'a':{'n':5}, 'b':[1]}, [1, 2, 3], [Point(1, 5), Point(2,8)]);
final b = Complex({'b':[1], 'a':{'n':5}}, [3, 2, 1], [Point(2, 4), Point(6,4)]);

print(a == b); // ✅ true
```

## Using Static methods

### `Equalone.empty(value)`
Checks if a value is empty (null, empty string, or empty collection). 

```dart
Equalone.empty(null);       // ✅ true
Equalone.empty('');         // ✅ true
Equalone.empty([]);         // ✅ true
Equalone.empty([1, 2, 3]);  // ❌ false 
Equalone.empty('hello');    // ❌ false 
```

### `Equalone.deepEquals(a, b)`
Performs a deep recursive equality check for any values, including nested collections. Ignores reference identity and compares contents.

```dart
Equalone.deepEquals([1, [2, 3]], [1, [2, 3]]);      // ✅ true  
Equalone.deepEquals([1, [2, 3]], [1, [3, 2]]);      // ❌ false 
Equalone.deepEquals({'x': [1, 2]}, {'x': [1, 2]});  // ✅ true  
Equalone.deepEquals({'x': [1, 2]}, {'x': [2, 1]});  // ❌ false 
Equalone.deepEquals([[1, 2], [3]], [[1, 2], [3]]);  // ✅ true  
```

You can specify the `unordered` parameter to perform order-insensitive comparisons for collections like Lists and Iterables. When `unordered: true`, the order of elements does not affect equality:

```dart
Equalone.deepEquals([1, [2, 3]], [[3, 2], 1], unordered: true); // ✅ true
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

You can specify the `unordered` parameter to perform order-insensitive comparisons for collections like Lists and Iterables. When `unordered: true`, the order of elements does not affect equality:

```dart
Equalone.shallowEquals([1, 2, 3], [3, 2, 1], unordered: true); // ✅ true
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



## Using `Equalone` wrapper

You can wrap any value, collection, or object in an `Equalone` instance to enable robust equality and hashCode logic. This is especially useful when you want to compare complex or nested structures, use them as keys in maps, or store them in sets.

### Equality for objects

You can compare a specific subset of an object's fields, or use complex computed expressions for comparison.

```dart
final u = Equalone(User(name:'One', age:20), equality: EqualityBy((u)=>u.age)); 
final a = Equalone([10,20,30,40], equality: EqualityBy((e)=>e.first + e.last));

print(u == User(name:'Equ', age:20)); // ✅ true 
print(a == [20, 30]);                 // ✅ true 
```

### Equality for collections

You can select the comparison method using `Equalone.deep` for deep equality or `Equalone.shallow` for shallow equality, or specify your own custom logic by `equality` parameter:

```dart
final deep = Equalone.deep([1, [2, 3]]);
final shallow = Equalone.shallow([1, [2, 3]]);
final custom = Equalone([[2, 3], 1], equality: const DeepCollectionEquality.unordered());

print(deep == shallow);  // ✅ true (deep equality)
print(shallow  == deep);  // ❌ false (shallow equality)
print(deep == custom);  // ❌ false (ordered equality)
print(custom == deep);  // ✅ true (unordered equality)
```

### Comparing with regular collections

You can even compare an `Equalone` instance with regular collections. However, avoid comparing regular collections directly to `Equalone`, as this may lead to unexpected or incorrect results.

```dart
final e = Equalone.shallow([1, 2, 3]);
final f = [1, 2, 3];

print(e == f); // ✅ true  
print(f == e); // ❌ false 
```

### Null comparison

You **can not** directly compare an `Equalone` instance with a regular `null` value. For consistent and correct results, always wrap `null` values in an `Equalone` instance before comparison.

```dart
final g = Equalone.shallow(null);
final h = Equalone.shallow(null);

print(g == h);    // ✅ true  
print(g.hashCode == null.hashCode); // ✅ true  
print(g == null); // ❌ false 
print(null == g); // ❌ false 
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
final e1 = Equalone.deep((a: [1, 2, 3], b: {'x': 1}));
final e2 = Equalone.deep((a: [1, 2, 3], b: {'x': 1}));

print(e1 == e2); // ❌ false (different list and map instances)
print(e1.hashCode == e2.hashCode); // ❌ false

```

To achieve deep equality for records, wrap the inner collections with `Equalone`:

```dart
final r1 = (a: Equalone.shallow([1, 2, 3]), b: Equalone.shallow({'x': 1}));
final r2 = (a: Equalone.shallow([1, 2, 3]), b: Equalone.shallow({'x': 1}));

print(r1 == r2); // ✅ true (deep equality for collections)
print(r1.hashCode == r2.hashCode); // ✅ true
```

By wrapping the collections with `Equalone`, you ensure that equality and hashCode are based on the contents, not just references.

> **Note:** If you use records with nested collections and want value-based comparison, always wrap those collections with `Equalone` to avoid subtle bugs and unexpected behavior.

### Asymmetric Comparison

When comparing an `Equalone` instance with a regular collection, the result may be asymmetric.

```dart
final a = Equalone.shallow([1, 2, 3]);
final b = [1, 2, 3];
print(a == b); // ✅ true  
print(b == a); // ❌ false
```
This is because the equality logic is determined by the left-hand operand. Always use `Equalone` as the left operand for consistent results.

### Null Comparison

Equality and hashCode behavior with `null` values can be non-intuitive.

```dart
final a = Equalone.shallow(null);
final b = null;
final c = Equalone.shallow(null);
print(a == b); // ❌ false
print(a == c); // ✅ true  
print(a.hashCode == null.hashCode); // ✅ true  
```
Comparing `Equalone(null)` with `null` using `==` returns `false`, but `Equalone(null) == Equalone(null)` returns `true`. The `hashCode` of `Equalone(null)` is equal to `null.hashCode`.

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
  List<Object?> get equalones => [name, Equalone.deep(scores)]; // Wrapped: deep equality
}

final c = PersonDeep('One', [1, 2, 3]);
final d = PersonDeep('One', [1, 2, 3]);
print(c == d); // ✅ true (deep equality)
```
When using `EqualoneMixin`, be careful with mutable collections in the `equalones` list. Prefer wrapping collections in `Equalone` to ensure deep equality and avoid unexpected behavior due to reference identity.

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
