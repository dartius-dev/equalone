# EqualOne

`equalone` is a Dart package for robust, deep, and customizable equality and hashCode logic for any value type, including collections and nested structures. It is especially useful for comparing complex objects, using them as keys in maps, or storing them in sets.

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

## Usage

### Deep equality for collections

```dart
final a = Equalone([1, 2, 3]);
final b = Equalone([1, 2, 3]);
print(a == b); // true (deep equality for lists)
print(a.hashCode == b.hashCode); // true

final c = Equalone({'x': 1, 'y': 2});
final d = Equalone({'x': 1, 'y': 2});
print(c == d); // true (deep equality for maps)
```

### Comparing with regular collections

```dart
final e = Equalone([1, 2, 3]);
final f = [1, 2, 3];
print(e == f); // true
print(f == e); // false
```

### Null comparison

```dart
final g = Equalone(null);
final h = Equalone(null);
print(g == h); // true
print(g.hashCode == null.hashCode); // true
```

### Custom equality and type ignoring

```dart
final a = Equalone([1, 2, 3], ignoreType: true);
final b = Equalone(<num>[1, 2, 3], ignoreType: true);
print(a == b); // true (ignores type differences)
```

### Using EqualoneMixin in your classes

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
print(a == b); // true
```

## API Highlights

- `Equalone.empty(value)`: Checks if a value is empty (null, empty string, or empty collection). Customizable
- `Equalone.equals(a, b)`: Customizable equality check (deepEquals by default)
- `Equalone.deepEquals(a, b)`: Deep recursive equality for any values
- `Equalone.shallowEquals(a, b)`: Top-level equality for any values

## Customization

You can globally override the equality and emptiness logic:

```dart
Equalone.initialize(
  equals: const DeepCollectionEquality().equals, // Type-insensitive deep equality
  empty: (v) => v is num ? v == 0 : Equalone.defaultEmpty(v),
);
```

## Caveats & Warnings

### Asymmetric Comparison

When comparing an `Equalone` instance with a regular collection, the result may be asymmetric.

```dart
final a = Equalone([1, 2, 3]);
final b = [1, 2, 3];
print(a == b); // true
print(b == a); // false
```
This is because the equality logic is determined by the left-hand operand. Always use `Equalone` as the left operand for consistent results.



### Null Comparison

Equality and hashCode behavior with `null` values can be non-intuitive.

```dart
final a = Equalone(null);
final b = null;
final c = Equalone(null);
print(a == b); // false
print(a == c); // true
print(a.hashCode == null.hashCode); // true
```
Comparing `Equalone(null)` with `null` using `==` returns `false`, but `Equalone(null) == Equalone(null)` returns `true`. The `hashCode` of `Equalone(null)` is equal to `null.hashCode`.



### Customization Consistency

Always use the same custom settings for all compared `Equalone` instances to avoid unexpected results.

```dart
final a = Equalone([1, 2, 3], ignoreType: true);
final b = Equalone(<num>[1, 2, 3], ignoreType: false);
print(a == b); // false (different ignoreType)

final c = Equalone([1, 2, 3], ignoreType: true);
final d = Equalone(<num>[1, 2, 3], ignoreType: true);
print(c == d); // true (same ignoreType)
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

final a = Person('Alice', [1, 2, 3]);
final b = Person('Alice', [1, 2, 3]);
print(a == b); // false (different list references)

class PersonDeep with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonDeep(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, Equalone(scores)]; // Wrapped: deep equality
}

final c = PersonDeep('Alice', [1, 2, 3]);
final d = PersonDeep('Alice', [1, 2, 3]);
print(c == d); // true (deep equality)
```
When using `EqualoneMixin`, be careful with mutable collections in the `equalones` list. Prefer wrapping collections in `Equalone` to ensure deep equality and avoid unexpected behavior due to reference identity.


### Equalone HashCode Limitations

The `hashCode` for collections is based on their length and type, not their contents. This means that two collections with the same length but different elements may have the same hashCode.

```dart
final a = Equalone([1, 2, 3]);
final b = Equalone([4, 5, 6]);
print(a.hashCode == b.hashCode); // true (same length, same type)
print(a == b); // false (different contents)
```
For use as map keys, always rely on equality, not just hashCode.

However, you can still use `Equalone` as a value in a `Set` or as a key in a `Map`:

```dart
 final set12 = {Equalone([1,2])};
 print(set12.contains(Equalone([1,2]))); // true
 print(set12.contains(Equalone([2,1]))); // false
 
 final map12 = {Equalone([1,2]) :"12"};

 print(map12.containsKey(Equalone([1,2]))); // true
 print(map12.containsKey(Equalone([2,1]))); // false

```

## More examples

See the `/examples` folder for more comparison scenarios.

## License

MIT
