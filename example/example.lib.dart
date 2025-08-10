import 'package:equalone/equalone.dart';
import 'package:equalone/collection.dart';

///
/// Simple value-based equality
///
class Point with EqualoneMixin {
  final int x;
  final int y;
  const Point(this.x, this.y);
  @override
  List<Object?> get equalones => [x, y];
}


///
/// Reference shallow equality
///
class PersonRef with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonRef(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, scores];
}

///
/// Shallow equality
///
class PersonShallow with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonShallow(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, ...scores];
}

///
/// Deep equality with Equalone wrapping
///
class PersonDeep with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonDeep(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, Equalone(scores)];
}

///
///
///
class EqualoneUnorderedList<T> extends Equalone<List<T>> {
  EqualoneUnorderedList(super.value) : super(
      ignoreType: false, 
      equalsMethod: const DeepCollectionEquality.unordered().equals);
}

///
///
///
bool sumEquals(Object? a, Object? b) => (a is List<num> && b is List<num>)
    ? (a.fold<num>(0, (num s, v) => s + v) == b.fold<num>(0, (num s, v) => s + v))
    : false;

int sumHashCode(Object? value, {bool ignoreType = true}) => value is List<num> 
    ? value.fold<num>(0, (s, v) => s + v).hashCode 
    : Equalone.hashCodeBuilder(value, ignoreType: ignoreType);

class EqualoneSumCustomized extends Equalone<List<num>> {
  const EqualoneSumCustomized(super.value) : super(
      equalsMethod: sumEquals,
      hashCodeMethod: sumHashCode
    );
}

///
///
///
class EqualoneSum extends Equalone<List<num>> {
  const EqualoneSum([super.value = const []]);

  @override
  bool testEquals(Object? a, Object? b) 
    => (a is List<num> && b is List<num>)
       ? (a.fold<num>(0, (num s, v) => s + v) == b.fold<num>(0, (num s, v) => s + v))
       : false;  

  @override
  int getHashCode(List<num> value) 
    => value.fold<num>(0, (s, v) => s + v).hashCode;
}


///
///
///
class NamedEqualone extends Equalone<Named> {
  const NamedEqualone(super.value) : super(ignoreType: false);
  
  @override
  bool testEquals(Object? a, Object? b) => (a as Named?) == (b as Named?);

  @override
  int get hashCode => value.name.hashCode;
}

class MapPropertyEqualone extends Equalone<Map> {
  final String key;
  const MapPropertyEqualone(super.value, this.key) : super(ignoreType: false);

  @override
  bool testEquals(Object? a, Object? b) 
      => (a as Map?)?[key] == (b as Map?)?[key];

  @override
  int getHashCode(Map value) => value[key].hashCode;
}

class ValueEqualone<T> extends Equalone {
  final T? object;
  final Object? Function(T?) objectValue;
  ValueEqualone(this.object, this.objectValue) : super(objectValue(object), ignoreType: true);

  @override
  String toString() => "${super.toString()}($object)";
}

class NamedValueEqualone extends Equalone {
  final Named object;
  NamedValueEqualone(this.object) : super(object.name, ignoreType: true);

  @override
  String toString() => "${super.toString()}($object)";
}

class MapValueEqualone extends Equalone {
  final Map map;  
  MapValueEqualone(this.map, String key) : super(map[key], ignoreType: false);
  @override
  String toString() => "${super.toString()}($map)";
}

///
///
///
abstract class Named {
    String get name;
}

// Two classes implementing the Named interface
class Customer implements Named {
    final String name;
    final int age;

    Customer(this.name, this.age);
}

class Producer implements Named {
    final String name;
    final double efficiency;

    Producer(this.name, this.efficiency);
}
