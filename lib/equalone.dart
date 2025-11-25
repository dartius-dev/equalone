import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

/// 
/// The [EqualoneMixin] provides a reusable, standardized way to implement value-based equality in Dart classes.
/// The mixin provides a robust implementation of [==] and [hashCode] using [equalones] values.
///
/// ### Usage
/// 1. Add `with EqualoneMixin` to your class declaration.
/// 2. Override the `equalones` getter to return a list of fields to compare. 
/// 3. Do not override [==] or [hashCode] unless you need custom logic.
///
/// ```dart
/// class Point with EqualoneMixin {
///   final int x;
///   final int y;
///
///   Point(this.x, this.y);
///
///   @override
///   List<Object?> get equalones => [x, y];
/// }
///
/// void main() {
///   final a = Point(1, 2);
///   final b = Point(1, 2);
///   print(a == b); // true
///   print(a.hashCode == b.hashCode); // true
/// }
/// ```
/// 
/// ⚠️ **Caution when using collections ([List], [Map], [Set]) in [equalones]:**
///   - Directly including mutable collections in [equalones] may lead to incorrect equality or hashCode results.
///   - Prefer immutable collections or value objects to avoid unexpected equality issues.
///   - For collections, always wrap them with [Equalone.shallow] or [Equalone.deep] to ensure correct and predictable equality checks.
///
/// ```dart
/// class Person with EqualoneMixin {
///   final String name;
///   final List<int> scores;
///
///   Person(this.name, this.scores);
///
///   @override
///   List<Object?> get equalones => [name, Equalone.shallow(scores)];
/// }
///
/// void main() {
///   final a = Person('One', [1, 2, 3]);
///   final b = Person('One', [1, 2, 3]);
///   print(a == b); // true (shallow equality for the list)
/// }
/// ```
/// 
/// ### When to Use
/// - For value objects and data classes where equality should be based on field values.
/// - To avoid boilerplate and errors in manual `==`/`hashCode` implementations.
/// - In Flutter apps for state comparison, collection operations, or testing.
///
/// ### Notes
/// - Always include all relevant fields in [equalones].
/// - The mixin uses equality for collections via the `collection` package.
///
/// ### Benefits
/// - Reduces boilerplate code for equality checks.
/// - Ensures consistent equality logic across your codebase.
/// - Ability to use deep equality for collections and nested structures (via [Equalone]).
/// - Makes it easy to create value objects that can be used in collections, maps, or as keys.
///
/// 
mixin EqualoneMixin {
  List<Object?> get equalones;

  @override
  bool operator ==(Object other) {
    final equal = identical(this, other) ||
        other is EqualoneMixin &&
            runtimeType == other.runtimeType &&
            Equalone.shallowEquals(equalones, other.equalones);
    return equal;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ Object.hashAll(equalones);
}


/// 
/// The [Equalone] class is a value wrapper that provides deep, customizable equality
/// and [hashCode] logic for any value type.
///
/// ### Purpose
/// Use [Equalone] to wrap values (including collections) and gain robust, consistent
/// equality and [hashCode] behavior.
///
/// This is especially useful for comparing complex objects, using them as keys in maps,
/// or storing them in sets.
///
/// ### Usage
/// - Wrap any value or collection in [Equalone] to enable desired equality.
/// - Use in your models, state objects, or anywhere value-based comparison is needed.
///
/// There are three ways to create an [Equalone] instance:
/// - `Equalone.shallow(value)` - uses shallow (top-level) equality.
/// - `Equalone.deep(value)` - uses deep (recursive) equality.
/// - `Equalone(value, equality: Equality())` - uses custom equality.
///
/// ```dart
/// final a = Equalone.shallow([1, 2, 3]);
/// final b = Equalone.shallow([1, 2, 3]);
/// print(a == b); // true (shallow equality for lists)
/// print(a.hashCode == b.hashCode); // true
///
/// final c = Equalone.deep({'x': 1, 'y': [2,3]});
/// final d = Equalone.deep({'x': 1, 'y': [2,3]});
/// print(c == d); // true (deep equality for maps)
/// ```
///
/// You can even compare an [Equalone] instance with regular collections.
/// However, avoid comparing regular collections directly to [Equalone],
/// as this may lead to unexpected or incorrect results:
/// ```dart
/// final e = Equalone.shallow([1, 2, 3]);
/// final f = [1, 2, 3];
/// print(e == f); // true (shallow equality for lists)
/// print(f == e); // false
/// print(e.hashCode == f.hashCode); // false
/// ```
/// ### Null comparison Caution
/// `Null` comparison by `==` operator is working only with [Equalone] wrapper.
///
/// Although, `hashCode` of [Equalone] with `null` value is equal to `hashCode` of `null`.
///
/// ```dart
/// final g = Equalone.deep(null);
/// final n = null;
/// final h = Equalone.deep(n);
///
/// print(g == n); // false
/// print(n == g); // false
/// print(g == h); // true
/// print(g.hashCode == n.hashCode); // true
/// print(g.hashCode == h.hashCode); // true
/// ```
///
/// ### Customized Equalone
/// The `Equalone` class provides customizable `equality` comparison for its instances.
///
/// Use the `Equalone()` to define a custom logic for comparing.
/// ```dart
/// final dcu = Equalone([0,1,2], const DeepCollectionEquality.unordered());
/// 
/// print(dcu == [2,1,0]); // true
/// ```
///
/// ⚠️ Comparing two [Equalone] instances with different equalities 
/// may lead to unexpected results. If you compare objects with differing parameters,
/// the comparison result may be incorrect or asymmetric.
/// 
/// ```dart
/// final i = Equalone.shallow({'a':[0,1]});
/// final j = Equalone.deep({'a':[0,1]});
/// 
/// print(i==j); // false
/// print(j==i); // true
/// ```
/// It is recommended to always use the same settings for [Equalone] instances being compared.
///
/// **Note:** When using the `==` operator, the order of operands matters.
/// Comparing `EqualoneA == EqualoneB` may produce a different result than `EqualoneB == EqualoneA`.
/// This is because the equality logic is determined by the left-hand operand.
///
///
/// {@endtemplate}
@immutable
class Equalone<T> {

  /// Performs a shallow (top-level) equality check between two objects.
  ///
  /// - For [List], [Map], [Set], and [Iterable], compares only the top-level elements (does not recurse into nested collections).
  /// - Each element is compared using the provided [equality].
  /// - For non-collections, uses the [equality] parameter.
  /// - set [unordered] to `true` if the order of elements in collections should be ignored during comparison.
  ///
  /// Use this for fast, top-level comparison where deep (recursive) equality is not required.
  static bool shallowEquals(Object? a, Object? b, {
    Equality equality = const DefaultEquality<Never>(), 
    bool unordered = false
  }) {
    if (identical(a, b)) return true;
    return unordered 
      ? ShallowCollectionEquality.unordered(equality).equals(a, b) 
      : ShallowCollectionEquality(equality).equals(a, b);
  }

  /// Performs a deep (recursive) equality check between two objects.
  ///
  /// - Suitable for complex/nested data structures (e.g., nested [List], [Map], [Set], [Iterable]) where all levels must be checked for equality.
  /// - Each element is compared using the provided [equality].
  /// - For non-collections, uses the [equality] parameter.
  /// - set [unordered] to `true` if the order of elements in collections should be ignored during comparison.
  ///
  /// Use this for thorough, recursive comparison of all nested elements.
  static bool deepEquals(Object? a, Object? b, {
    Equality equality = const DefaultEquality<Never>(),
    bool unordered = false    
  }) {
    if (identical(a, b)) return true;
    return unordered 
      ? DeepCollectionEquality.unordered(equality).equals(a, b)
      : DeepCollectionEquality(equality).equals(a, b);
  }

  /// Checks whether the given value is considered "empty".
  /// 
  /// This is helpful for:
  /// - Filtering out empty values from collections.
  /// - Checking emptiness for variables of unknown or dynamic type (e.g., `String`, `List`, `Iterable`).
  static bool empty(Object? value) => const Emptiness().empty(value);

  static T valueOf<T>(Object? obj) {
    while (obj is Equalone) obj = obj.value;
    return obj as T;
  }
    
  final T value;
  final Equality equality;
  @experimental
  final Emptiness emptiness;

  const Equalone(this.value, { 
    required this.equality,
    @experimental this.emptiness = const DefaultEmptiness() 
  });
  const Equalone.deep(this.value) : equality = const DeepCollectionEquality(), this.emptiness = const DefaultEmptiness();
  const Equalone.shallow(this.value) : equality = const ShallowCollectionEquality(), this.emptiness = const DefaultEmptiness();

  @experimental
  bool get isEmpty => emptiness(value);

  @experimental
  bool get isNotEmpty => !isEmpty;
  
  bool equals(Object? other) => call(value, other);
  
  bool call(Object? a, Object? b) {
    return equality.equals(valueOf(a), valueOf(b));
  }
 
  @override
  bool operator ==(Object other) => call(value, other);

  @override
  int get hashCode => equality.hash(valueOf(value));
}


///
///
///
class ShallowCollectionEquality implements Equality {
  final Equality _base;
  final bool _unordered;

  const ShallowCollectionEquality([Equality base = const DefaultEquality<Never>()])
      : _base = base,
        _unordered = false;

  /// Creates a shallow equality on collections where the order of lists and
  /// iterables are not considered important. 
  /// Only lists and iterables are treated as unordered iterables.
  const ShallowCollectionEquality.unordered(
      [Equality base = const DefaultEquality<Never>()])
      : _base = base,
        _unordered = true;

  @override
  bool equals(Object? e1, Object? e2) => 
    switch(e1) {
      final Set s1 => e2 is Set && SetEquality(_base).equals(s1, e2),
      final Map m1 => e2 is Map && MapEquality(values: _base).equals(m1, e2),
      final List l1 => !_unordered
        ? e2 is List && ListEquality(_base).equals(l1, e2)
        : e2 is Iterable && UnorderedIterableEquality(_base).equals(l1, e2),
      final Iterable i1 => !_unordered
        ? e2 is Iterable && IterableEquality(_base).equals(i1, e2)
        : e2 is Iterable && UnorderedIterableEquality(_base).equals(i1, e2),
      final obj => _base.equals(obj, e2),
    };

  @override
  int hash(Object? o) => 
    switch(o) {
      final Set s => SetEquality(_base).hash(s),
      final Map m => MapEquality(values: _base).hash(m),
      final List l => !_unordered
        ? ListEquality(_base).hash(l)
        : UnorderedIterableEquality(_base).hash(l),
      final Iterable i => !_unordered
        ? IterableEquality(_base).hash(i)
        : UnorderedIterableEquality(_base).hash(i),
      final obj => _base.hash(obj),
    };

  @override
  bool isValidKey(Object? o) =>
      o is Iterable || o is Map || _base.isValidKey(o);
}


///
///
///
abstract class Emptiness {
  const factory Emptiness() = DefaultEmptiness; 
  const factory Emptiness.custom(bool Function(Object? value) empty) = CustomEmptiness; 
  const Emptiness.constructor();

  bool call(Object? value) => empty(value);
  bool empty(Object? value);
}

///
///
///
class DefaultEmptiness extends Emptiness {
  const DefaultEmptiness() : super.constructor();

  @override
  bool empty(Object? value) => 
    switch (value) {
      null => true,
      final String s => s.isEmpty,
      final Iterable i => i.isEmpty,
      final Map m => m.isEmpty,
      final Equalone e => e.isEmpty,
      _ => false,
    };
}

///
///
///
class CustomEmptiness extends Emptiness {
  final bool Function(Object? value) _empty;
  const CustomEmptiness(this._empty) : super.constructor();

  @override
  bool empty(Object? value) => _empty(value);
}