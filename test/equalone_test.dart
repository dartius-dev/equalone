import 'package:test/test.dart';
import 'package:equalone/equalone.dart';


void main() {

  group('EqualoneMixin in custom classes', () {
    test('simple value-based equality', () {
      final a = Point(1, 2);
      final b = Point(1, 2);
      final c = Point(2, 1);
      expect(a == b, isTrue);
      expect(a == c, isFalse);
      expect(a.hashCode, equals(b.hashCode));
    });

    test('deep equality for collections in mixin', () {
      final a = PersonDeep('One', [1, 2, 3]);
      final b = PersonDeep('One', [1, 2, 3]);
      final c = PersonDeep('One', [3, 2, 1]);
      expect(a == b, isTrue);
      expect(a == c, isFalse);
    });

    test('shallow equality for collections in mixin', () {
      final a = PersonShallow('One', [1, 2, 3]);
      final b = PersonShallow('One', [1, 2, 3]);
      final c = PersonShallow('One', [3, 2, 1]);
      expect(a == b, isTrue);
      expect(a == c, isFalse);
    });

    test('reference equality if not wrapped', () {
      final a = PersonRef('One', [1, 2, 3]);
      final b = PersonRef('One', [1, 2, 3]);
      final c = a;
      expect(a == b, isFalse); // different list references
      expect(a == c, isTrue);  // same instance
    });
  });
  group('Equalone.empty', () {
    test('returns true for null, empty string, and empty list', () {
      expect(Equalone.empty(null), isTrue);
      expect(Equalone.empty(''), isTrue);
      expect(Equalone.empty([]), isTrue);
    });
    test('returns false for non-empty values', () {
      expect(Equalone.empty([1, 2, 3]), isFalse);
      expect(Equalone.empty('hello'), isFalse);
    });
  });

  group('Equalone.equals', () {
    test('deep equality for lists and maps', () {
      expect(Equalone.equals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.equals({'a': 1}, {'a': 1}), isTrue);
      expect(Equalone.equals([1, 2, 3], [3, 2, 1]), isFalse);
    });
    test('null equality', () {
      expect(Equalone.equals(null, null), isTrue);
      expect(Equalone.equals(null, []), isFalse);
    });
  });

  group('Equalone.deepEquals', () {
    test('deeply nested structures', () {
      expect(Equalone.deepEquals([1, [2, 3]], [1, [2, 3]]), isTrue);
      expect(Equalone.deepEquals([1, [2, 3]], [1, [3, 2]]), isFalse);
      expect(Equalone.deepEquals({'x': [1, 2]}, {'x': [1, 2]}), isTrue);
      expect(Equalone.deepEquals({'x': [1, 2]}, {'x': [2, 1]}), isFalse);
    });
    test('type sensitivity', () {
      expect(Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3]), isFalse);
      expect(Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: true), isTrue);
      expect(Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false), isFalse);
    });
  });

  group('Equalone.shallowEquals', () {
    test('shallow comparison', () {
      expect(Equalone.shallowEquals([1, [2, 3]], [1, [2, 3]]), isFalse);
      expect(Equalone.shallowEquals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.shallowEquals([1, 2, 3], [3, 2, 1]), isFalse);
    });
    test('type sensitivity', () {
      expect(Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3]), isFalse);
      expect(Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: true), isTrue);
      expect(Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false), isFalse);
    });
  });

  group('Equalone wrapper', () {
    test('== and hashCode for lists', () {
      final a = Equalone([1, 2, 3]);
      final b = Equalone([1, 2, 3]);
      expect(a == b, isTrue);
      expect(a.hashCode, equals(b.hashCode));
    });
    test('== and hashCode for maps', () {
      final a = Equalone({'x': 1, 'y': 2});
      final b = Equalone({'x': 1, 'y': 2});
      expect(a == b, isTrue);
      expect(a.hashCode, equals(b.hashCode));
    });
    test('type sensitivity in wrapper', () {
      final a = Equalone([1, 2, 3], ignoreType: true);
      final b = Equalone(<num>[1, 2, 3], ignoreType: false);
      expect(a == b, isTrue); // ignores type differences
      expect(b == a, isFalse); // type differences matter for b
      final c = Equalone([1, 2, 3], ignoreType: true);
      final d = Equalone(<num>[1, 2, 3], ignoreType: true);
      expect(c == d, isTrue);
      expect(d == c, isTrue);
    });
    test('custom equalsMethod', () {
      bool sumEquals(Object? a, Object? b) => (a is List<num> && b is List<num>)
            ? (a.fold<num>(0, (num s, v) => s + v) == b.fold<num>(0, (num s, v) => s + v))
            : false;
      final a = Equalone([1, 2, 3], equalsMethod: sumEquals);
      final b = Equalone([3, 3], equalsMethod: sumEquals);
      expect(a == b, isTrue);
    });
  });
}

class Point with EqualoneMixin {
  final int x;
  final int y;
  Point(this.x, this.y);
  @override
  List<Object?> get equalones => [x, y];
}

class PersonDeep with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonDeep(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, Equalone(scores)];
}

class PersonShallow with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonShallow(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, ...scores];
}

class PersonRef with EqualoneMixin {
  final String name;
  final List<int> scores;
  PersonRef(this.name, this.scores);
  @override
  List<Object?> get equalones => [name, scores]; // Not wrapped
}

