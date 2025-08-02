import 'package:equalone/equalone.dart';

void main() {
  group('EqualoneMixin in custom classes', () {
    test('simple value-based equality', () {
      final a = Point(1, 2);
      final b = Point(1, 2);
      final c = Point(2, 1);
      assert(a == b);
      assert(a != c);
      assert(a.hashCode == b.hashCode);
    });

    test('deep equality for collections in mixin', () {
      final a = PersonDeep('One', [1, 2, 3]);
      final b = PersonDeep('One', [1, 2, 3]);
      final c = PersonDeep('One', [3, 2, 1]);
      assert(a == b);
      assert(a != c);
    });

    test('shallow equality for collections in mixin', () {
      final a = PersonShallow('One', [1, 2, 3]);
      final b = PersonShallow('One', [1, 2, 3]);
      final c = PersonShallow('One', [3, 2, 1]);
      assert(a == b);
      assert(a != c);
    });

    test('reference equality if not wrapped', () {
      final a = PersonRef('One', [1, 2, 3]);
      final b = PersonRef('One', [1, 2, 3]);
      final c = a;
      assert(a != b); // different list references
      assert(a == c); // same instance
    });
  });

  group('Equalone.empty', () {
    test('returns true for null, empty string, and empty list', () {
      assert(Equalone.empty(null));
      assert(Equalone.empty(''));
      assert(Equalone.empty([]));
    });
    test('returns false for non-empty values', () {
      assert(!Equalone.empty([1, 2, 3]));
      assert(!Equalone.empty('hello'));
    });
  });

  group('Equalone.equals', () {
    test('deep equality for lists and maps', () {
      assert(Equalone.equals([1, 2, 3], [1, 2, 3]));
      assert(Equalone.equals({'a': 1}, {'a': 1}));
      assert(!Equalone.equals([1, 2, 3], [3, 2, 1]));
    });
    test('null equality', () {
      assert(Equalone.equals(null, null));
      assert(!Equalone.equals(null, []));
    });
  });

  group('Equalone.deepEquals', () {
    test('deeply nested structures', () {
      assert(Equalone.deepEquals([1, [2, 3]], [1, [2, 3]]));
      assert(!Equalone.deepEquals([1, [2, 3]], [1, [3, 2]]));
      assert(Equalone.deepEquals({'x': [1, 2]}, {'x': [1, 2]}));
      assert(Equalone.deepEquals({'x': [1, 2]}, {'x': [1, 2]}));
      assert(!Equalone.deepEquals({'x': [1, 2]}, {'x': [2, 1]}));
    });
    test('type sensitivity', () {
      assert(Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3]));
      assert(Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: true));
      assert(!Equalone.deepEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false));
    });
  });

  group('Equalone.shallowEquals', () {
    test('shallow comparison', () {
      assert(!Equalone.shallowEquals([1, [2, 3]], [1, [2, 3]]));
      assert(Equalone.shallowEquals([1, 2, 3], [1, 2, 3]));
      assert(!Equalone.shallowEquals([1, 2, 3], [3, 2, 1]));
    });
    test('type sensitivity', () {
      assert(Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3]));
      assert(Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: true));
      assert(!Equalone.shallowEquals([1, 2, 3], <num>[1, 2, 3], ignoreType: false));
    });
  });

  group('Equalone wrapper', () {
    test('== and hashCode for lists', () {
      final a = Equalone([1, 2, 3]);
      final b = Equalone([1, 2, 3]);
      assert(a == b);
      assert(a.hashCode == b.hashCode);
    });
    test('== and hashCode for maps', () {
      final a = Equalone({'x': 1, 'y': 2});
      final b = Equalone({'x': 1, 'y': 2});
      assert(a == b);
      assert(a.hashCode == b.hashCode);
    });
    test('type sensitivity in wrapper', () {
      final a = Equalone([1, 2, 3], ignoreType: true);
      final b = Equalone(<num>[1, 2, 3], ignoreType: false);
      assert(a == b); // ignores type differences
      assert(b != a); // type differences matter for b
      final c = Equalone([1, 2, 3], ignoreType: true);
      final d = Equalone(<num>[1, 2, 3], ignoreType: true);
      assert(c == d);
      assert(d == c);
    });
    test('custom equalsMethod', () {
      bool sumEquals(Object? a, Object? b) => (a is List<num> && b is List<num>)
          ? (a.fold<num>(0, (num s, v) => s + v) ==
              b.fold<num>(0, (num s, v) => s + v))
          : false;
      final a = Equalone([1, 2, 3], equalsMethod: sumEquals);
      final b = Equalone([3, 3], equalsMethod: sumEquals);
      assert(a == b);
    });
  });

  print('All assertions passed!');
}

// --- Test classes ---

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
  List<Object?> get equalones => [name, scores];  // Not wrapped
}

// --- Simple group/test emulation for console ---

typedef VoidCallback = void Function();

void group(String name, VoidCallback body) {
  print('\n== $name ==');
  body();
}

void test(String name, VoidCallback body) {
  try {
    body();
    print('  [PASS] $name');
  } catch (e, st) {
    print('  [FAIL] $name');
    print('    $e');
    print('    $st');
    rethrow;
  }
}
