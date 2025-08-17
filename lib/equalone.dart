import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

/// {@template equalone_mixin}
/// The [EqualoneMixin] provides a reusable, standardized way to implement value-based equality in Dart classes.
///
/// ### Purpose
/// Use this mixin to simplify and unify equality and hashCode logic for value objects, data models, or any class
/// where you want equality to be based on the values of fields rather than object identity.
///
/// ### How It Works
/// Classes that mix in [EqualoneMixin] must override the [equalones] getter to return a list of all fields
/// that should participate in equality and hashCode calculations. The mixin then provides a robust implementation
/// of [==] and [hashCode] using these values.
///
/// ### Usage
/// 1. Add `with EqualoneMixin` to your class declaration.
/// 2. Override the `equalones` getter to return a list of fields to compare.
///    (Be careful with use of [List], [Map] or [Set] fields).
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
/// ### Caution
/// - Be careful with using collections ([List], [Map], [Set]) in [equalones]
///   - Prefer using immutable collections or value objects to avoid unexpected behavior.
///   - Try to use [Equalone] for collections to ensure deep equality.
///
/// ```dart
/// class Person with EqualoneMixin {
///   final String name;
///   final List<int> scores;
///
///   Person(this.name, this.scores);
///
///   @override
///   List<Object?> get equalones => [name, Equalone(scores)];
/// }
///
/// void main() {
///   final a = Person('One', [1, 2, 3]);
///   final b = Person('One', [1, 2, 3]);
///   print(a == b); // true (deep equality for the list)
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
/// {@endtemplate}
mixin EqualoneMixin {
  List<Object?> get equalones;

  @override
  bool operator ==(Object other) {
    final equal = identical(this, other) ||
        other is EqualoneMixin &&
            runtimeType == other.runtimeType &&
            Equalone.shallowEquals(
                // do not use deepEquals
                equalones,
                other.equalones);

    return equal;
  }

  @override
  int get hashCode => runtimeType.hashCode ^ Object.hashAll(equalones);
}

typedef HashCodeBuilder<T> = int Function(T? o, {bool ignoreType});
typedef TestEquals<T> = bool Function(T? a, T? b);
typedef TestEmpty = bool Function(Object?);

/// {@template equalone_class}
/// ## Equalone
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
/// - Wrap any value or collection in [Equalone] to enable deep equality.
/// - Use in your models, state objects, or anywhere value-based comparison is needed.
///
/// ```dart
/// final a = Equalone([1, 2, 3]);
/// final b = Equalone([1, 2, 3]);
/// print(a == b); // true (deep equality for lists)
/// print(a.hashCode == b.hashCode); // true
///
/// final c = Equalone({'x': 1, 'y': 2});
/// final d = Equalone({'x': 1, 'y': 2});
/// print(c == d); // true (deep equality for maps)
/// ```
///
/// You can even compare an [Equalone] instance with regular collections.
/// However, avoid comparing regular collections directly to [Equalone],
/// as this may lead to unexpected or incorrect results:
/// ```dart
/// final e = Equalone([1, 2, 3]);
/// final f = [1, 2, 3];
/// print(e == f); // true (deep equality for lists)
/// print(f == e); // false
/// print(e.hashCode == f.hashCode); // false
/// ```
/// ### Null comparison Caution
/// `Null` comparison by `==` operator is working only with [Equalone] wrapper.
///
/// Although, `hashCode` of [Equalone] with `null` value is equal to `hashCode` of `null`.
///
/// ```dart
/// final g = Equalone(null);
/// final n = null;
/// final h = Equalone(n);
///
/// print(g == n); // false
/// print(n == g); // false
/// print(g == h); // true
/// print(g.hashCode == n.hashCode); // true
/// print(g.hashCode == h.hashCode); // true
/// ```
///
/// ### Customization
/// The `Equalone` class provides customizable equality comparison for its instances.
///
/// Features:
/// - Use the `equalsMethod` to define a custom logic for comparing two instances of `Equalone`.
///   This allows you to override the default equality behavior and specify exactly how instances
///   should be considered equal.
/// - The `ignoreType` option can be enabled to ignore the runtime type when comparing instances.
///   - When set to `true`, two objects with the same properties but different types will be considered equal.
///   - When set to `false`, two objects with the same properties and same type will be considered equal.
///
/// Usage:
/// - Set `equalsMethod` to a function that takes two objects and returns a boolean indicating equality.
/// - Set `ignoreType` to `false` if you want to compare objects based on their properties and types.
/// - Use `Equalone.shallow()` or `Equalone.deep()` to create instances with specific equality behavior.
///
/// ### Customization Caution
/// Comparing two [Equalone] instances with different settings (such as different `equalsMethod` or `ignoreType`)
/// may lead to unexpected results. If you compare objects with differing parameters,
/// the comparison result may be incorrect or asymmetric.
///
/// It is recommended to always use the same settings for [Equalone] instances being compared.
///
/// **Note:** When using the `==` operator, the order of operands matters.
/// Comparing `EqualoneA == EqualoneB` may produce a different result than `EqualoneB == EqualoneA`.
/// This is because the equality logic is determined by the left-hand operand.
///
/// ---
///
/// ## Static Methods
///
/// The static methods of [Equalone] provide a flexible and type-agnostic way to perform equality
/// and emptiness checks on any variables.
///
/// - [Equalone.equals] — The function used for default equality checks ([deepEquals] by default).
/// - [Equalone.empty] — The function used to check if a value is considered empty.
/// - [Equalone.shallowEquals] — The function used for shallow (top-level) equality checks.
/// - [Equalone.deepEquals] — The function used for deep equality checks.
///
/// ### Usage
/// These methods are especially convenient for working with collections and variables of
/// unknown or dynamic types, where standard equality or emptiness checks may not be sufficient
/// or reliable.
///
/// The [Equalone.equals] method can be used to compare two objects for equality,
/// which is useful in scenarios such as:
/// - Safely comparing variables whose type may not be known at compile time.
/// - Checking if two collections (e.g., `List`, `Map`, `Set`) contain the same elements, even if nested.
///
/// Example:
/// ```dart
/// bool areEqual = Equalone.equals(user1, user2);
/// if (areEqual) {
///   print('Users are equal');
/// }
///
/// dynamic a = [1, 2, 3];
/// dynamic b = [1, 2, 3];
/// if (Equalone.equals(a, b)) {
///   print('Collections are equal');
/// }
/// ```
///
/// The [Equalone.empty] method can be used to check if a value is considered "empty".
/// This is helpful for:
/// - Filtering out empty values from collections.
/// - Checking emptiness for variables of unknown or dynamic type (e.g., `String`, `List`, `Iterable`).
///
/// Example:
/// ```dart
/// dynamic value = [];
/// if (Equalone.empty(value)) {
///   print('Value is empty');
/// }
/// ```
///
/// ### Customization
/// [Equalone.customize] allows you to globally customize how equality and emptiness are determined.
/// Call this to override the default equality/emptiness logic globally.
/// ```dart
/// Equalone.customize(
///   equals: const DeepCollectionEquality().equals, // Type-insensitive deep equality
///   empty: (v) => switch(v) {
///     num n => n==0,  // Custom empty check for numbers
///     _ => Equalone.defaultEmpty(v),
///   },
/// );
/// ```
/// 
/// Local customization also possible:
/// 
/// ```dart
/// final restore = Equalone.customize(
///   equals: const DeepCollectionEquality().equals,
/// );
/// 
/// ... Use custom equality logic
/// 
/// restore(); // Restore default equality logic
/// ```
/// 
/// {@endtemplate}
@immutable
class Equalone<T> {
  static bool Function(Object? a, Object? b) equals = deepEquals;

  static bool Function(Object? value) empty = defaultEmpty;

  static void Function() customize({
    TestEquals<Object>? equals,
    TestEmpty? empty,
  }) {
    final backup = (Equalone.equals, Equalone.empty);

    if (equals != null) Equalone.equals = equals;
    if (empty != null) Equalone.empty = empty;
    
    return () {
      Equalone.equals = backup.$1;
      Equalone.empty = backup.$2;
    };
  }

  @Deprecated('Use `Equalone.customize` instead')
  static void initialize({TestEquals<Object>? equals, TestEmpty? empty}) =>
      customize(equals: equals ?? Equalone.equals, empty: empty ?? Equalone.empty);

  /// Performs a shallow (top-level) equality check between two objects.
  ///
  /// - For [List], [Map], [Set], and [Iterable], compares only the top-level elements (does not recurse into nested collections).
  /// - For non-collections, uses the standard `==` operator.
  /// - Returns true if both objects are identical.
  /// - If [ignoreType] is true (by default), skips runtime type checking and compares values directly (useful for comparing different but structurally similar types).
  /// - If [ignoreType] is false, considers the runtime type of both objects and requires them to be the same for equality.
  ///
  /// Use this for fast, top-level comparison where deep (recursive) equality is not required.
  static bool shallowEquals(Object? a, Object? b, {bool ignoreType = true}) {
    if (identical(a, b)) return true;
    return (ignoreType || a.runtimeType == b.runtimeType) &&
        switch (a) {
          final List list => b is List? ? const ListEquality().equals(list, b) : false,
          final Map map => b is Map? ? const MapEquality().equals(map, b) : false,
          final Set set => b is Set? ? const SetEquality().equals(set, b) : false,
          final Iterable iterable =>
            b is Iterable? ? const IterableEquality().equals(iterable, b) : false,
          final obj => obj == b,
        };
  }

  /// Performs a deep (recursive) equality check between two objects.
  ///
  /// - Uses [DeepCollectionEquality] from the `collection` package to compare all nested elements and collections.
  /// - Suitable for complex/nested data structures (e.g., nested [List], [Map], [Set], [Iterable]) where all levels must be checked for equality.
  /// - Returns true if both objects are identical or deeply equal.
  /// - If [ignoreType] is true (by default), skips runtime type checking and compares values deeply (useful for comparing different but structurally similar types).
  /// - If [ignoreType] is false, considers the runtime type of both objects and requires them to be the same for equality.
  ///
  /// Use this for thorough, recursive comparison of all nested elements.
  static bool deepEquals(Object? a, Object? b, {bool ignoreType = true}) {
    if (identical(a, b)) return true;
    return (ignoreType || a.runtimeType == b.runtimeType) &&
        const DeepCollectionEquality().equals(a, b);
  }

  static bool defaultEmpty(Object? value) => switch (value) {
        null => true,
        final String s => s.isEmpty,
        final Iterable i => i.isEmpty,
        final Map m => m.isEmpty,
        final Equalone e => e.isEmpty,
        _ => false
      };

  static int hashCodeBuilder<T>(Object? value, {bool ignoreType = true}) {
    return switch (value) {
      final List list => Object.hash((ignoreType ? List : T).hashCode, list.length),
      final Map map => Object.hash((ignoreType ? Map : T).hashCode, map.length),
      final Set set => Object.hash((ignoreType ? Set : T).hashCode, set.length),
      final Iterable _ => (ignoreType ? Iterable : T).hashCode,
      _ => value.hashCode,
    };
  }

  final T value;
  final bool ignoreType;
  final TestEquals<Object>? equalsMethod;
  final HashCodeBuilder<Object>? hashCodeMethod;

  const Equalone(this.value, {this.equalsMethod, this.hashCodeMethod, this.ignoreType = true});
  const Equalone.deep(this.value, {this.ignoreType = true}) : equalsMethod = deepEquals, hashCodeMethod = null;
  const Equalone.shallow(this.value, {this.ignoreType = true}) : equalsMethod = shallowEquals, hashCodeMethod = null;

  bool get isEmpty => empty(value);
  bool get isNotEmpty => !isEmpty;

  bool testEquals(Object? a, Object? b) => deepEquals(a, b, ignoreType: ignoreType);
  int getHashCode(T value) => (hashCodeMethod ?? hashCodeBuilder)(value, ignoreType: ignoreType);

  bool call(Object? a, Object? b) {
    while (a is Equalone) a = a.value;
    while (b is Equalone) b = b.value;
    return equalsMethod != null
        ? (ignoreType || (a is T && b is T)) && equalsMethod!(a, b)
        : testEquals(a, b);
  }

  @override
  bool operator ==(Object other) => call(value, other);
  
  @override
  int get hashCode => getHashCode(value);
}

/// The `PayloadEqualone` class is designed to associate additional payload data (`data`) with a value (`value`)
/// that is compared using the [Equalone] equality logic.
///
/// # Purpose
/// The main purpose of this class is to bind extra data (`data`) to a value (`value`) that participates in
/// equality and hashCode calculations via [Equalone]. While equality and hashCode are determined solely by `value`,
/// the `data` field allows you to attach related information that does not affect comparison.
///
/// # Use Cases
/// - Attaching metadata or auxiliary information to a value object that is used as a key in collections or for comparison.
/// - Keeping a reference to the original data or context while using [Equalone] for equality checks.
/// - Associating additional payloads with values in state management, caching, or mapping scenarios.
///
/// # Examples
///
/// ```dart
/// final user = PayloadEqualone(
///   123, // value used for equality
///   data: UserProfile(id: 123, name: 'One'), // keep full profile as payload.
/// );
///
/// final another = PayloadEqualone(123, data: UserProfile(id: 123, name: 'Equ'));
/// print(user == another); // true, Only the value (123) is used for equality:
///
/// print(user.data.name); // 'One', You can still access the associated data
/// ```
///
/// This class is useful when you need to compare objects by a specific value but also need to retain
/// associated data for further processing or retrieval.
///
class PayloadEqualone<T> extends Equalone {
  final T? data;
  PayloadEqualone(super.value, {required this.data, super.ignoreType, super.equalsMethod, super.hashCodeMethod});

  @override
  String toString() => "${super.toString()}(${data.runtimeType})";
}
