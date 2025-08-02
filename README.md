# EqualOne
![pub version](https://img.shields.io/pub/v/equalone)
![pub points](https://img.shields.io/pub/points/equalone)
![likes](https://img.shields.io/pub/likes/equalone)


`equalone` is a Dart utility package for deep equality, value-based comparison, and robust hashCode generation for any Dart object, including List, Map, Set, and nested collections. It solves common problems with object comparison, custom equality, and hashCode in Dart data classes, value objects, and collections. Use `equalone` to implement deep equality, shallow equality, and custom comparison logic for models, state objects, and when using objects as keys in Map or elements in Set. The package provides static methods, a wrapper class, and a mixin for easy integration with your Dart or Flutter projects.

## Why equalone?

```dart
  final a0 = {'k': 'v'};
  final a1 = {'k': 'v'};
  final b0 = {1,2,3};
  final b1 = {1,2,3};
  final c0 = [1,[2,3]];
  final c1 = [1,[2,3]];

  final values = {a0,b0,c0};

  print(a1 == a0);              // ❌ false 
  print(b1 == b0);              // ❌ false 
  print(c1 == c0);              // ❌ false 

  print(values.contains(a1));   // ❌ false 
  print(values.contains(b1));   // ❌ false 
  print(values.contains(c1));   // ❌ false 

  
  final a2 = Equalone({'k': 'v'});
  final b2 = Equalone({1,2,3});
  final c2 = Equalone([1,[2,3]]);

  final equalones = {...values.map(Equalone.new)};

  print(Equalone.equals(a0, a1));  // ✅ true      
  print(Equalone.equals(b0, b1));  // ✅ true
  print(Equalone.equals(c0, c1));  // ✅ true

  print(a2 == a0 && a2 == a1);     // ✅ true
  print(b2 == b0 && b2 == b1);     // ✅ true
  print(c2 == c0 && c2 == c1);     // ✅ true

  print(equalones.contains(a2));   // ✅ true
  print(equalones.contains(b2));   // ✅ true
  print(equalones.contains(c2));   // ✅ true
```

Because ALL in ONE! Simple, Easy, Accessible!

And that's not ALL! Keep reading...

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

This simply re-exports the official `collection` package used be `equalone`.


## Usage

You can use the `equalone` package in three main ways:

- **Static methods**: Use static methods like `Equalone.equals`, `Equalone.deepEquals`, `Equalone.shallowEquals`, and `Equalone.empty` for quick, type-agnostic checks and comparisons.
- **Wrapper class**: Wrap any value or collection in the `Equalone` class to enable robust equality and hashCode logic, especially for use in sets, maps, or when comparing complex/nested objects.
- **Mixin for custom classes**: Add value-based equality to your own classes by mixing in `EqualoneMixin` and specifying which fields should participate in equality and hashCode calculations.

## Static methods usage

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
Customizable equality check (uses `deepEquals` by default). Suitable for comparing any values, including collections and nested structures.

```dart

Equalone.equals([1, 2, 3], [1, 2, 3]);           // ✅ true  
Equalone.equals({'a': 1}, {'a': 1});             // ✅ true  
Equalone.equals([1, 2, 3], [3, 2, 1]);           // ❌ false 
Equalone.equals([[1, 2], [3]], [[1, 2], [3]]);   // ✅ true, if customized with deepEquals
Equalone.equals('abc', 'abc');                   // ✅ true  
Equalone.equals(null, null);                     // ✅ true  
```

### `Equalone.deepEquals(a, b)`
Performs a deep recursive equality check for any values, including nested collections. Ignores reference identity and compares structure and contents.

```dart
Equalone.deepEquals([1, [2, 3]], [1, [2, 3]]);      // ✅ true  
Equalone.deepEquals([1, [2, 3]], [1, [3, 2]]);      // ❌ false 
Equalone.deepEquals({'x': [1, 2]}, {'x': [1, 2]});  // ✅ true  
Equalone.deepEquals({'x': [1, 2]}, {'x': [2, 1]});  // ❌ false 
Equalone.deepEquals([[1, 2], [3]], [[1, 2], [3]]);  // ✅ true  
```

You can control type sensitivity with the `ignoreType` parameter (default: `true`).
```dart
Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false);  // ❌ false  
Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3]);                     // ✅ true   
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
Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3]);                    // ✅ true   
Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false); // ❌ false 
```

### Customization

You can globally override the equality and emptiness logic:

```dart
import 'package:equalone/collection.dart';

Equalone.initialize(
  equals: const DeepCollectionEquality.unordered().equals, // Type-insensitive unordered deep equality
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
Equalone.initialize(
  equals: (a, b) => a is String && b is String
      ? a.toLowerCase() == b.toLowerCase()
      : Equalone.deepEquals(a, b),
);

print(Equalone.equals('Hello', 'hello')); // ✅ true  
print(Equalone.equals('Hello', 'world')); // ❌ false 
```

> Use `Equalone.initialize` to globally customize default comparison and emptiness logic to match requirements of your app.

## `Equalone` instances usage

You can wrap any value, collection, or object in an `Equalone` instance to enable robust equality and hashCode logic. This is especially useful when you want to compare complex or nested structures, use them as keys in maps, or store them in sets.

### Deep equality for collections

```dart
final a = Equalone([1, 2, 3]);
final b = Equalone([1, 2, 3]);

print(a == b);                    // ✅ true (deep equality for lists)
print(a.hashCode == b.hashCode);  // ✅ true  

final c = Equalone({'x': 1, 'y': 2});
final d = Equalone({'x': 1, 'y': 2});

print(c == d); // ✅ true (deep equality for maps)
```

### Comparing with regular collections

You can even compare an `Equalone` instance with regular collections. However, avoid comparing regular collections directly to `Equalone`, as this may lead to unexpected or incorrect results

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

### Custom equality 

You can provide a custom equality function via the `equalsMethod` parameter. For example, to compare lists by their sum:

```dart
bool sumEquals(Object? a, Object? b) => (a is List<num> && b is List<num>)
       ? (a.fold<num>(0, (num s, v) => s + v) == b.fold<num>(0, (num s, v) => s + v))
       : false;

final a = Equalone([1, 2, 3], equalsMethod: sumEquals);
final b = Equalone([3, 3], equalsMethod: sumEquals);

print(a == b); // ✅ true (both sum to 6)
```

### Type sensitivity

You can control whether type differences are considered in equality checks using the `ignoreType` parameter. By default, `ignoreType` is set to `true`, so type differences are ignored. If you set `ignoreType: false`, values with different types (e.g., `List<int>` and `List<num>`) will not be considered equal, even if their contents match.

```dart
final c = Equalone([1, 2, 3], ignoreType: true);
final d = Equalone(<num>[1, 2, 3], ignoreType: false);

print(c == d); // ✅ true (ignores type differences)
print(d == c); // ❌ false (type differences matter for d)
```

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

final a = Person('One', [1, 2, 3]);
final b = Person('One', [1, 2, 3]);
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

final a = Person('One', [1, 2, 3]);
final b = Person('One', [1, 2, 3]);
print(a == b); // ✅ true   
```


## Caveats & Warnings

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
  List<Object?> get equalones => [name, scores]; // Not wrapped: shallow equality
}

final a = Person('One', [1, 2, 3]);
final b = Person('One', [1, 2, 3]);
print(a == b); // ❌ false (different list references)

class PersonDeep with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonDeep(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, Equalone(scores)]; // Wrapped: deep equality
}

final c = PersonDeep('One', [1, 2, 3]);
final d = PersonDeep('One', [1, 2, 3]);
print(c == d); // ✅ true (deep equality)
```
When using `EqualoneMixin`, be careful with mutable collections in the `equalones` list. Prefer wrapping collections in `Equalone` to ensure deep equality and avoid unexpected behavior due to reference identity.


### Equalone HashCode Limitations

The `hashCode` for collections is based on their length and type, not their contents. This means that two collections with the same length but different elements may have the same `hashCode`.

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
* [example_test.dart](https://github.com/dartius-dev/equalone/blob/main/example/example.test.dart) - assert based tests

Explore the `/test` folder for a suite of automated tests covering features, edge cases, and caveats of `equalone`:
* [equalone_test.dart](https://github.com/dartius-dev/equalone/blob/main/test/equalone_test.dart)
  
Experiment by adding tests for your own cases 


By studying the example and tests, you'll gain a deeper and more practical understanding of how to use `equalone` effectively and safely in your own projects.

Issues and suggestions are welcome!

## License

MIT
