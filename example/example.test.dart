import 'package:equalone/equalone.dart';
import '../example/example.lib.dart';


void main() {
  group('Equalone.empty', () {
    test('empty values', () {
      assert(Equalone.empty(null));
      assert(Equalone.empty(''));
      assert(Equalone.empty([]));
      assert(Equalone.empty({}));
      assert(Equalone.empty(<String, dynamic>{}));
      assert(Equalone.empty(Iterable.generate(0)));
    });
    test('non-empty values', () {
      assert(!Equalone.empty([null]));
      assert(!Equalone.empty([1, 2, 3]));
      assert(!Equalone.empty('hello'));
      assert(!Equalone.empty(0));
      assert(!Equalone.empty((0,1)));
      assert(!Equalone.empty((a:null)));
      assert(!Equalone.empty((null,null)));
      assert(!Equalone.empty((a:0,b:1)));
    });
  });

  group('Equalone.shallowEquals', () {
    test('lists equality', () {
      assert(Equalone.shallowEquals([1, 2, 3], [1, 2, 3]));
      assert(Equalone.shallowEquals([1, 2, 3], [1, 2, 3], ignoreType: false));

      assert(Equalone.shallowEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0]));
      assert(!Equalone.shallowEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0], ignoreType: false));

      assert(Equalone.shallowEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0]));
      assert(Equalone.shallowEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0], ignoreType: false));

      assert(!Equalone.shallowEquals([1, 2, [3]], [1, 2, [3]]));
      assert(!Equalone.shallowEquals([1, [2], {'a': 3}], [1, [2], {'a':3}]));
      assert(!Equalone.shallowEquals([{1}, [2], {'a': 3}], [{1}, [2], {'a':3}]));
      assert(!Equalone.shallowEquals([(1, 2), {'a': [3]}], [(1, 2), {'a':[3]}]));

      assert(!Equalone.shallowEquals([1, 2, 3], [3, 2, 1]));
      assert(!Equalone.shallowEquals([1, 2], [1, 2, 3]));
      assert(!Equalone.shallowEquals([1, 2, 3], {1, 2, 3}));
      assert(!Equalone.shallowEquals([1, 2, 3], Iterable<int>.generate(3, (i) => i+1)));
    });
    test('sets equality', () {
      assert(Equalone.shallowEquals({1, 2, 3}, {1, 2, 3}));
      assert(Equalone.shallowEquals({1, 2, 3}, {3, 2, 1}));
      assert(Equalone.shallowEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}, ignoreType: true));
      assert(!Equalone.shallowEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}, ignoreType: false));

      assert(Equalone.shallowEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}, ignoreType: true));
      assert(Equalone.shallowEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}, ignoreType: false));

      assert(Equalone.shallowEquals({1, 2.0, 3}, {1, 2.0, 3}, ignoreType: true));
      assert(Equalone.shallowEquals({1, 2.0, 3}, {1, 2.0, 3}, ignoreType: false));
      assert(Equalone.shallowEquals({1.0, 2, 3}, {1, 2.0, 3.0}, ignoreType: true));
      assert(Equalone.shallowEquals({1.0, 2, 3}, {1, 2.0, 3.0}, ignoreType: false));

      assert(Equalone.shallowEquals({(1, 2), 3}, {3, (1, 2)}));
      assert(!Equalone.shallowEquals({(1, 2), {'a': [3]}}, {{'a':[3]}, (1, 2)}));
      assert(!Equalone.shallowEquals({[1],[2,3]}, {[2,3],[1]}));
    });
    test('maps equality', () {
      assert(Equalone.shallowEquals({'a': 1}, {'a': 1}));
      assert(Equalone.shallowEquals({'a': 1}, {'a': 1.0}));
      assert(Equalone.shallowEquals({'a': 1,'b':2}, {'b':2,'a':1}));

      assert(Equalone.shallowEquals({'a': 1}, {'a': 1.0}, ignoreType: true));
      assert(!Equalone.shallowEquals({'a': 1}, {'a': 1.0}, ignoreType: false));

      assert(!Equalone.shallowEquals({'a': 1,'b':[2,3]}, {'b':[2,3],'a':1}));
      assert(!Equalone.shallowEquals({'a': 1}, {'a': 2}));
      assert(!Equalone.shallowEquals({'a': 1}, {'b': 1}));
      assert(!Equalone.shallowEquals({'a': 1,'b':null}, {'a':1}));
    });
    test('records equality', () {
      assert(Equalone.shallowEquals((1, 2), (1, 2)));
      assert(Equalone.shallowEquals((a:1, b:2), (a:1, b:2)));
      assert(Equalone.shallowEquals((a:1, b:2), (b:2, a:1)));
      assert(!Equalone.shallowEquals((a:1, b:2), (1, 2)));
      assert(!Equalone.shallowEquals((1, 2), (1, 2, 3)));

      assert(Equalone.shallowEquals((1, 2), (1, 2.0), ignoreType: true));
      assert(!Equalone.shallowEquals((1, 2), (1, 2.0), ignoreType: false));

      assert(!Equalone.shallowEquals(({1}, [2]), ({1}, [2])));
    });
    test('null equality', () {
      assert(Equalone.shallowEquals(null, null));
      assert(!Equalone.shallowEquals(null, []));
    });
  });

  group('Equalone.deepEquals', () {
    test('lists equality', () {
      assert(Equalone.deepEquals([1, 2, 3], [1, 2, 3]));
      assert(Equalone.deepEquals([1, 2, 3], [1, 2, 3], ignoreType: false));

      assert(Equalone.deepEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0]));
      assert(!Equalone.deepEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0], ignoreType: false));

      assert(Equalone.deepEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0]));
      assert(Equalone.deepEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0], ignoreType: false));

      assert(Equalone.deepEquals([1, 2, [3]], [1, 2, [3]]));
      assert(Equalone.deepEquals([1, [2], {'a': 3}], [1, [2], {'a':3}]));
      assert(Equalone.deepEquals([{1}, [2], {'a': 3}], [{1}, [2], {'a':3}]));
      assert(Equalone.deepEquals([(1, 2), {'a': [3]}], [(1, 2), {'a':[3]}]));

      assert(!Equalone.deepEquals([1, 2, 3], [3, 2, 1]));
      assert(!Equalone.deepEquals([1, 2], [1, 2, 3]));
      assert(!Equalone.deepEquals([1, 2, 3], {1, 2, 3}));
      assert(!Equalone.deepEquals([1, 2, 3], Iterable<int>.generate(3, (i) => i+1)));
    });
    test('sets equality', () {
      assert(Equalone.deepEquals({1, 2, 3}, {1, 2, 3}));
      assert(Equalone.deepEquals({1, 2, 3}, {3, 2, 1}));
      assert(Equalone.deepEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}));
      assert(!Equalone.deepEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}, ignoreType: false));

      assert(Equalone.deepEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}));
      assert(Equalone.deepEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}, ignoreType: false));
      
      assert(Equalone.deepEquals({1, 2.0, [3]}, {1, 2.0, [3]}));
      assert(Equalone.deepEquals({1, 2.0, [3]}, {1, 2.0, [3]}, ignoreType: false));
      assert(Equalone.deepEquals({1.0, 2, [3]}, {1, 2.0, [3.0]}));
      assert(Equalone.deepEquals({1.0, 2, [3]}, {1, 2.0, [3.0]}, ignoreType: false));

      assert(Equalone.shallowEquals({(1, 2), 3}, {3, (1, 2)}));
      assert(Equalone.deepEquals({(1, 2), {'a': [3]}}, {{'a':[3]}, (1, 2)}));
      assert(Equalone.deepEquals({[1],[2,3]}, {[2,3],[1]}));
    });
    test('maps equality', () {
      assert(Equalone.deepEquals({'a': 1}, {'a': 1}));
      assert(Equalone.deepEquals({'a': 1}, {'a': 1.0}));
      assert(Equalone.deepEquals({'a': 1,'b':2}, {'b':2,'a':1}));

      assert(Equalone.deepEquals({'a': 1}, {'a': 1.0}, ignoreType: true));
      assert(!Equalone.deepEquals({'a': 1}, {'a': 1.0}, ignoreType: false));

      assert(Equalone.deepEquals({'a': 1,'b':[2,3]}, {'b':[2,3],'a':1}));
      assert(!Equalone.deepEquals({'a': 1}, {'a': 2}));
      assert(!Equalone.deepEquals({'a': 1}, {'b': 1}));
      assert(!Equalone.deepEquals({'a': 1,'b':null}, {'a':1}));
    });
    test('records equality', () {
      assert(Equalone.deepEquals((1, 2), (1, 2)));
      assert(Equalone.deepEquals((a:1, b:2), (a:1, b:2)));
      assert(Equalone.deepEquals((a:1, b:2), (b:2, a:1)));
      assert(!Equalone.deepEquals((a:1, b:2), (1, 2)));
      assert(!Equalone.deepEquals((1, 2), (1, 2, 3)));

      assert(Equalone.deepEquals((1, 2), (1, 2.0), ignoreType: true));
      assert(!Equalone.deepEquals((1, 2), (1, 2.0), ignoreType: false));

      assert(!Equalone.deepEquals(({1}, [2]), ({1}, [2])));
    });
    test('null equality', () {
      assert(Equalone.deepEquals(null, null));
      assert(!Equalone.deepEquals(null, []));
    });
  });

  group('Equalone wrapper', () {
    test('== and hashCode for lists', () {
      final a = Equalone([1, 2, 3]);
      final b = Equalone([1, 2, 3]);
      final c = Equalone([1, 3, 2]);
      final d = Equalone([1.0, 2.0, 3.0]);
      final e = Equalone([1.0, 2.0, 3.0], ignoreType: false);

      assert(a == b);
      assert(a == [1, 2, 3]);
      assert(a != c);
      assert(a == d);
      assert(a == e);
      assert(e != a);
      assert(a.hashCode == b.hashCode);
      assert(a.hashCode == c.hashCode);
      assert(a.hashCode == d.hashCode);
      assert(a.hashCode != [1, 2, 3].hashCode);
      assert(a.hashCode != e.hashCode);
    });
    test('== and hashCode for maps', () {
      final a = Equalone({'x': 1, 'y': 2});
      final b = Equalone({'y': 2, 'x': 1});
      final c = Equalone({'x': 2, 'y': 1});
      final d = Equalone({'x': 1.0, 'y': 2.0}, ignoreType: false);

      assert(a == b);
      assert(a == {'x': 1, 'y': 2});
      assert(a != c);
      assert(a == d);
      assert(d != a);

      assert(a.hashCode == b.hashCode);
      assert(a.hashCode == c.hashCode);
      assert(a.hashCode != d.hashCode);
      assert(a.hashCode != {'x': 1, 'y': 2}.hashCode);
    });
    test('== and hashCode for records', () {
      final a = Equalone((1, 2, 3));
      final b = Equalone((1.0, 2.0, 3.0), ignoreType: false);
      assert(a == b);
      assert(a == (1, 2, 3));
      assert(b != a);
      assert(a.hashCode == b.hashCode);
      assert(a.hashCode == (1,2,3).hashCode);
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
          ? (a.fold<num>(0, (num s, v) => s + v) == b.fold<num>(0, (num s, v) => s + v))
          : false;
      final a = Equalone([1, 2, 3], equalsMethod: sumEquals);
      final b = Equalone([3, 3], equalsMethod: sumEquals);
      assert(a == b);
    });
  });

  group('EqualoneMixin in custom classes', () {
    test('simple value-based equality', () {
      final a = Point(1, 2);
      final b = Point(1, 2);
      final c = Point(2, 1);
      assert(a == b);
      assert(a != c);
      assert(a.hashCode == b.hashCode);
    });
    test('reference equality if not wrapped', () {
      final a = PersonRef('One', [1, 2, 3]);
      final b = PersonRef('One', [1, 2, 3]);
      final c = PersonRef('One', a.scores);
      assert(a != b); // different list references
      assert(a == c); // same instance
    });

    test('shallow equality for collections in mixin', () {
      final a = PersonShallow('One', [1, 2, 3]);
      final b = PersonShallow('One', [1, 2, 3]);
      final c = PersonShallow('One', [3, 2, 1]);
      assert(a == b);
      assert(a != c);
    });

    test('deep equality for collections in mixin', () {
      final a = PersonDeep('One', [1, 2, 3]);
      final b = PersonDeep('One', [1, 2, 3]);
      final c = PersonDeep('One', [3, 2, 1]);
      assert(a == b);
      assert(a != c);
    });
  });

  print('\nAll assertions passed!');
}


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
