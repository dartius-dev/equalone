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

class Person with EqualoneMixin {
  final String name;
  final List<int> scores;
  final Map props;

  Person(this.name, this.scores, this.props);

  @override
  List<Object?> get equalones => [
    name, 
    Equalone(scores, equality: const ShallowCollectionEquality.unordered()),
    Equalone.deep(props)
  ];
}

///
/// Reference equality
///
class PersonRef with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonRef(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, scores];
}

///
/// Spread equality
///
class PersonSpread with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonSpread(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, ...scores];
}

///
/// Shallow equality with Equalone wrapping
///
class PersonShallow with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonShallow(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, Equalone.shallow(scores)];
}

class PersonUnorderedScores with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonUnorderedScores(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, Equalone(scores, equality: const DeepCollectionEquality.unordered())];
}
///
///
///
class EqualoneUnorderedList<T> extends Equalone<List<T>> {
  const EqualoneUnorderedList(super.value) : super(equality: const DeepCollectionEquality.unordered());
}
