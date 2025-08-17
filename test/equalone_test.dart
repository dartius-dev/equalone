import 'package:test/test.dart';
import 'package:equalone/equalone.dart';
import '../example/example.lib.dart';

void main() {
  group('Equalone.empty', () {
    test('empty values', () {
      expect(Equalone.empty(null), isTrue);
      expect(Equalone.empty(''), isTrue);
      expect(Equalone.empty([]), isTrue);
      expect(Equalone.empty({}), isTrue);
      expect(Equalone.empty(<String, dynamic>{}), isTrue);
      expect(Equalone.empty(Iterable.generate(0)), isTrue);
    });
    test('non-empty values', () {
      expect(Equalone.empty([null]), isFalse);
      expect(Equalone.empty([1, 2, 3]), isFalse);
      expect(Equalone.empty('hello'), isFalse);
      expect(Equalone.empty(0), isFalse);
      expect(Equalone.empty((0,1)), isFalse);
      expect(Equalone.empty((a:null)), isFalse);
      expect(Equalone.empty((null,null)), isFalse);
      expect(Equalone.empty((a:0,b:1)), isFalse);
    });
  });

  group('Equalone.shallowEquals', () {
    test('lists equality', () {
      expect(Equalone.shallowEquals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.shallowEquals([1, 2, 3], [1, 2, 3], ignoreType: false), isTrue);

      expect(Equalone.shallowEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0]), isTrue);
      expect(Equalone.shallowEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0], ignoreType: false), isFalse);

      expect(Equalone.shallowEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0]), isTrue);
      expect(Equalone.shallowEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0], ignoreType: false), isTrue);

      expect(Equalone.shallowEquals([1, 2, [3]], [1, 2, [3]]), isFalse);
      expect(Equalone.shallowEquals([1, [2], {'a': 3}], [1, [2], {'a':3}]), isFalse);
      expect(Equalone.shallowEquals([{1}, [2], {'a': 3}], [{1}, [2], {'a':3}]), isFalse);
      expect(Equalone.shallowEquals([(1, 2), {'a': [3]}], [(1, 2), {'a':[3]}]), isFalse);

      expect(Equalone.shallowEquals([1, 2, 3], [3, 2, 1]), isFalse);
      expect(Equalone.shallowEquals([1, 2], [1, 2, 3]), isFalse);
      expect(Equalone.shallowEquals([1, 2, 3], {1, 2, 3}), isFalse);
      expect(Equalone.shallowEquals([1, 2, 3], Iterable<int>.generate(3, (i) => i+1)), isFalse);
    });
    test('sets equality', () {
      expect(Equalone.shallowEquals({1, 2, 3}, {1, 2, 3}), isTrue);
      expect(Equalone.shallowEquals({1, 2, 3}, {3, 2, 1}), isTrue);
      expect(Equalone.shallowEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}, ignoreType: true), isTrue);
      expect(Equalone.shallowEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}, ignoreType: false), isFalse);

      expect(Equalone.shallowEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}, ignoreType: true), isTrue);
      expect(Equalone.shallowEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}, ignoreType: false), isTrue);

      expect(Equalone.shallowEquals({1, 2.0, 3}, {1, 2.0, 3}, ignoreType: true), isTrue);
      expect(Equalone.shallowEquals({1, 2.0, 3}, {1, 2.0, 3}, ignoreType: false), isTrue);
      expect(Equalone.shallowEquals({1.0, 2, 3}, {1, 2.0, 3.0}, ignoreType: true), isTrue);
      expect(Equalone.shallowEquals({1.0, 2, 3}, {1, 2.0, 3.0}, ignoreType: false), isTrue);

      expect(Equalone.shallowEquals({(1, 2), 3}, {3, (1, 2)}), isTrue);
      expect(Equalone.shallowEquals({(1, 2), {'a': [3]}}, {{'a':[3]}, (1, 2)}), isFalse);
      expect(Equalone.shallowEquals({[1],[2,3]}, {[2,3],[1]}), isFalse);
    });
    test('maps equality', () {
      expect(Equalone.shallowEquals({'a': 1}, {'a': 1}), isTrue);
      expect(Equalone.shallowEquals({'a': 1}, {'a': 1.0}), isTrue);
      expect(Equalone.shallowEquals({'a': 1,'b':2}, {'b':2,'a':1}), isTrue);

      expect(Equalone.shallowEquals({'a': 1}, {'a': 1.0}, ignoreType: true), isTrue);
      expect(Equalone.shallowEquals({'a': 1}, {'a': 1.0}, ignoreType: false), isFalse);

      expect(Equalone.shallowEquals({'a': 1,'b':[2,3]}, {'b':[2,3],'a':1}), isFalse);
      expect(Equalone.shallowEquals({'a': 1}, {'a': 2}), isFalse);
      expect(Equalone.shallowEquals({'a': 1}, {'b': 1}), isFalse);
      expect(Equalone.shallowEquals({'a': 1,'b':null}, {'a':1}), isFalse);
    });
    test('records equality', () {
      expect(Equalone.shallowEquals((1, 2), (1, 2)), isTrue);
      expect(Equalone.shallowEquals((a:1, b:2), (a:1, b:2)), isTrue);
      expect(Equalone.shallowEquals((a:1, b:2), (b:2, a:1)), isTrue);
      expect(Equalone.shallowEquals((a:1, b:2), (1, 2)), isFalse);
      expect(Equalone.shallowEquals((1, 2), (1, 2, 3)), isFalse);

      expect(Equalone.shallowEquals((1, 2), (1, 2.0), ignoreType: true), isTrue);
      expect(Equalone.shallowEquals((1, 2), (1, 2.0), ignoreType: false), isFalse);

      expect(Equalone.shallowEquals(({1}, [2]), ({1}, [2])), isFalse);
    });
    test('null equality', () {
      expect(Equalone.shallowEquals(null, null), isTrue);
      expect(Equalone.shallowEquals(null, []), isFalse);
    });
  });

  group('Equalone.deepEquals', () {
    test('lists equality', () {
      expect(Equalone.deepEquals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.deepEquals([1, 2, 3], [1, 2, 3], ignoreType: false), isTrue);

      expect(Equalone.deepEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0]), isTrue);
      expect(Equalone.deepEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0], ignoreType: false), isFalse);

      expect(Equalone.deepEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0]), isTrue);
      expect(Equalone.deepEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0], ignoreType: false), isTrue);

      expect(Equalone.deepEquals([1, 2, [3]], [1, 2, [3]]), isTrue);
      expect(Equalone.deepEquals([1, [2], {'a': 3}], [1, [2], {'a':3}]), isTrue);
      expect(Equalone.deepEquals([{1}, [2], {'a': 3}], [{1}, [2], {'a':3}]), isTrue);
      expect(Equalone.deepEquals([(1, 2), {'a': [3]}], [(1, 2), {'a':[3]}]), isTrue);

      expect(Equalone.deepEquals([1, 2, 3], [3, 2, 1]), isFalse);
      expect(Equalone.deepEquals([1, 2], [1, 2, 3]), isFalse);
      expect(Equalone.deepEquals([1, 2, 3], {1, 2, 3}), isFalse);
      expect(Equalone.deepEquals([1, 2, 3], Iterable<int>.generate(3, (i) => i+1)), isFalse);
    });
    test('sets equality', () {
      expect(Equalone.deepEquals({1, 2, 3}, {1, 2, 3}), isTrue);
      expect(Equalone.deepEquals({1, 2, 3}, {3, 2, 1}), isTrue);
      expect(Equalone.deepEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}), isTrue);
      expect(Equalone.deepEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}, ignoreType: false), isFalse);

      expect(Equalone.deepEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}), isTrue);
      expect(Equalone.deepEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}, ignoreType: false), isTrue);
      
      expect(Equalone.deepEquals({1, 2.0, [3]}, {1, 2.0, [3]}), isTrue);
      expect(Equalone.deepEquals({1, 2.0, [3]}, {1, 2.0, [3]}, ignoreType: false), isTrue);
      expect(Equalone.deepEquals({1.0, 2, [3]}, {1, 2.0, [3.0]}), isTrue);
      expect(Equalone.deepEquals({1.0, 2, [3]}, {1, 2.0, [3.0]}, ignoreType: false), isTrue);

      expect(Equalone.shallowEquals({(1, 2), 3}, {3, (1, 2)}), isTrue);
      expect(Equalone.deepEquals({(1, 2), {'a': [3]}}, {{'a':[3]}, (1, 2)}), isTrue);
      expect(Equalone.deepEquals({[1],[2,3]}, {[2,3],[1]}), isTrue);
    });
    test('maps equality', () {
      expect(Equalone.deepEquals({'a': 1}, {'a': 1}), isTrue);
      expect(Equalone.deepEquals({'a': 1}, {'a': 1.0}), isTrue);
      expect(Equalone.deepEquals({'a': 1,'b':2}, {'b':2,'a':1}), isTrue);

      expect(Equalone.deepEquals({'a': 1}, {'a': 1.0}, ignoreType: true), isTrue);
      expect(Equalone.deepEquals({'a': 1}, {'a': 1.0}, ignoreType: false), isFalse);

      expect(Equalone.deepEquals({'a': 1,'b':[2,3]}, {'b':[2,3],'a':1}), isTrue);
      expect(Equalone.deepEquals({'a': 1}, {'a': 2}), isFalse);
      expect(Equalone.deepEquals({'a': 1}, {'b': 1}), isFalse);
      expect(Equalone.deepEquals({'a': 1,'b':null}, {'a':1}), isFalse);
    });
    test('records equality', () {
      expect(Equalone.deepEquals((1, 2), (1, 2)), isTrue);
      expect(Equalone.deepEquals((a:1, b:2), (a:1, b:2)), isTrue);
      expect(Equalone.deepEquals((a:1, b:2), (b:2, a:1)), isTrue);
      expect(Equalone.deepEquals((a:1, b:2), (1, 2)), isFalse);
      expect(Equalone.deepEquals((1, 2), (1, 2, 3)), isFalse);

      expect(Equalone.deepEquals((1, 2), (1, 2.0), ignoreType: true), isTrue);
      expect(Equalone.deepEquals((1, 2), (1, 2.0), ignoreType: false), isFalse);

      expect(Equalone.deepEquals(({1}, [2]), ({1}, [2])), isFalse);
    });
    test('null equality', () {
      expect(Equalone.deepEquals(null, null), isTrue);
      expect(Equalone.deepEquals(null, []), isFalse);
    });
  });
  group('Equalone customization', () {
    test('custom initialization', () {
      final restore = Equalone.customize(
        equals: const EqualoneSum().call,
        empty: (v) => v is num ? v == 0 : Equalone.defaultEmpty(v),
      );
      // Use custom equality logic
      expect(Equalone.equals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.equals([1, 2, 3], [3, 2, 1]), isTrue);
      expect(Equalone.equals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.equals([1, 2, 3], [3, 3]), isTrue);
      expect(Equalone.empty(0.0), isTrue);
      
      restore(); // Restore default equality logic

      expect(Equalone.equals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.equals([1, 2, 3], [3, 2, 1]), isFalse);
      expect(Equalone.equals([1, 2, 3], [3, 3]), isFalse);
      expect(Equalone.empty(0.0), isFalse);
    });
  });
  group('Equalone wrapper', () {
    test('== and hashCode for lists', () {
      final a = Equalone([1, 2, 3]);
      final b = Equalone([1, 2, 3]);
      final c = Equalone([1, 3, 2]);
      final d = Equalone([1.0, 2.0, 3.0]);
      final e = Equalone([1.0, 2.0, 3.0], ignoreType: false);

      expect(a == b, isTrue);
      expect(a == [1, 2, 3], isTrue);
      expect(a == c, isFalse);
      expect(a == d, isTrue);
      expect(a == e, isTrue);
      expect(e == a, isFalse);
      expect(a.hashCode, equals(b.hashCode));
      expect(a.hashCode, equals(c.hashCode));
      expect(a.hashCode, equals(d.hashCode));
      expect(a.hashCode, isNot(equals([1, 2, 3].hashCode)));
      expect(a.hashCode, isNot(equals(e.hashCode)));
    });
    test('== and hashCode for maps', () {
      final a = Equalone({'x': 1, 'y': 2});
      final b = Equalone({'y': 2, 'x': 1});
      final c = Equalone({'x': 2, 'y': 1});
      final d = Equalone({'x': 1.0, 'y': 2.0}, ignoreType: false);

      expect(a == b, isTrue);
      expect(a == {'x': 1, 'y': 2}, isTrue);
      expect(a == c, isFalse);
      expect(a == d, isTrue);
      expect(d == a, isFalse);

      expect(a.hashCode, equals(b.hashCode));
      expect(a.hashCode, equals(c.hashCode));
      expect(a.hashCode, isNot(equals(d.hashCode)));
      expect(a.hashCode, isNot(equals({'x': 1, 'y': 2}.hashCode)));
    });
    test('== and hashCode for records', () {
      final a = Equalone((1, 2, 3));
      final b = Equalone((1.0, 2.0, 3.0), ignoreType: false);
      expect(a == b, isTrue);
      expect(a == (1, 2, 3), isTrue);
      expect(b == a, isFalse);
      expect(a.hashCode, equals(b.hashCode));
      expect(a.hashCode, equals((1,2,3).hashCode));
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
      final a = Equalone([1, 2, 3], equalsMethod: sumEquals);
      final b = Equalone([3, 3], equalsMethod: sumEquals);
      expect(a == b, isTrue);
    });
  });
  group('EqualoneMixin in custom classes', () {
    test('simple value-based equality', () {
      final a = Point(1, 2);
      final b = Point(1, 2);
      final c = Point(2, 1);
      expect(a == b, isTrue);
      expect(a == c, isFalse);
      expect(a.hashCode, equals(b.hashCode));
    });
    test('reference equality if not wrapped', () {
      final a = PersonRef('One', [1, 2, 3]);
      final b = PersonRef('One', [1, 2, 3]);
      final c = PersonRef('One', a.scores);
      expect(a == b, isFalse); // different list references
      expect(a == c, isTrue); // same instance
    });

    test('shallow equality for collections in mixin', () {
      final a = PersonShallow('One', [1, 2, 3]);
      final b = PersonShallow('One', [1, 2, 3]);
      final c = PersonShallow('One', [3, 2, 1]);
      expect(a == b, isTrue);
      expect(a == c, isFalse);
    });

    test('deep equality for collections in mixin', () {
      final a = PersonDeep('One', [1, 2, 3]);
      final b = PersonDeep('One', [1, 2, 3]);
      final c = PersonDeep('One', [3, 2, 1]);
      expect(a == b, isTrue);
      expect(a == c, isFalse);
    });

  });

}

