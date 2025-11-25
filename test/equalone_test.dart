import 'package:test/test.dart';
import 'package:equalone/equalone.dart';
import '../example/example.lib.dart';

void main() {
  group('Equalone.empty', () {
    test('empty values', () {
      expect(const Emptiness().empty(null), isTrue);
      expect(const Emptiness().empty(''), isTrue);
      expect(const Emptiness().empty([]), isTrue);
      expect(const Emptiness().empty({}), isTrue);
      expect(const Emptiness().empty(<String, dynamic>{}), isTrue);
      expect(const Emptiness().empty(Iterable.generate(0)), isTrue);
      expect(const Emptiness().empty(Equalone.shallow([])), isTrue);
    });
    test('non-empty values', () {
      expect(const Emptiness().empty([null]), isFalse);
      expect(const Emptiness().empty([1, 2, 3]), isFalse);
      expect(const Emptiness().empty('hello'), isFalse);
      expect(const Emptiness().empty(0), isFalse);
      expect(const Emptiness().empty((0,1)), isFalse);
      expect(const Emptiness().empty((a:null)), isFalse);
      expect(const Emptiness().empty((null,null)), isFalse);
      expect(const Emptiness().empty((a:0,b:1)), isFalse);
    });
  });

  group('Equalone.shallowEquals', () {
    test('lists equality', () {
      expect(Equalone.shallowEquals([1, 2, 3], [1, 2, 3]), isTrue);
      expect(Equalone.shallowEquals([1, 2, 3], [3, 2, 1], unordered: true), isTrue);
      
      expect(Equalone.shallowEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0]), isTrue);
      expect(Equalone.shallowEquals(<int>[1, 2, 3], <double>[3.0, 2.0, 1.0], unordered: true), isTrue);

      expect(Equalone.shallowEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0]), isTrue);
      expect(Equalone.shallowEquals(<num>[1, 2.0, 3], <num>[3.0, 2, 1.0], unordered: true), isTrue);

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

      expect(Equalone.shallowEquals(<int>{1, 2, 3}, <double>{1.0, 2.0, 3.0}), isTrue);
      expect(Equalone.shallowEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}), isTrue);

      expect(Equalone.shallowEquals({1, 2.0, 3}, {1, 2.0, 3}), isTrue);
      expect(Equalone.shallowEquals({1.0, 2, 3}, {1, 2.0, 3.0}), isTrue);

      expect(Equalone.shallowEquals({(1, 2), 3}, {3, (1, 2)}), isTrue);
      expect(Equalone.shallowEquals({(1, 2), {'a': [3]}}, {{'a':[3]}, (1, 2)}), isFalse);
      expect(Equalone.shallowEquals({[1],[2,3]}, {[2,3],[1]}), isFalse);
    });
    test('maps equality', () {
      expect(Equalone.shallowEquals({'a': 1}, {'a': 1}), isTrue);
      expect(Equalone.shallowEquals({'a': 1}, {'a': 1.0}), isTrue);
      expect(Equalone.shallowEquals({'a': 1,'b':2}, {'b':2,'a':1}), isTrue);
      expect(Equalone.shallowEquals({'a': 1}, {'a': 1.0}), isTrue);

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

      expect(Equalone.shallowEquals((1, 2), (1, 2.0)), isTrue);
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
      expect(Equalone.deepEquals([1, 2, 3], [3, 2, 1], unordered: true), isTrue);

      expect(Equalone.deepEquals(<int>[1, 2, 3], <double>[1.0, 2.0, 3.0]), isTrue);
      expect(Equalone.deepEquals(<int>[1, 2, 3], <double>[3.0, 2.0, 1.0], unordered: true), isTrue);
      expect(Equalone.deepEquals(<num>[1, 2.0, 3], <num>[1.0, 2, 3.0]), isTrue);
      expect(Equalone.deepEquals(<num>[1, 2.0, 3], <num>[3.0, 2, 1.0], unordered: true), isTrue);

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
      expect(Equalone.deepEquals(<num>{1.0, 2, 3.0}, <num>{1, 2.0, 3}), isTrue);
      
      expect(Equalone.deepEquals({1, 2.0, [3]}, {1, 2.0, [3]}), isTrue);
      expect(Equalone.deepEquals({1.0, 2, [3]}, {1, 2.0, [3.0]}), isTrue);

      expect(Equalone.shallowEquals({(1, 2), 3}, {3, (1, 2)}), isTrue);
      expect(Equalone.deepEquals({(1, 2), {'a': [3]}}, {{'a':[3]}, (1, 2)}), isTrue);
      expect(Equalone.deepEquals({[1],[2,3]}, {[2,3],[1]}), isTrue);
    });
    test('maps equality', () {
      expect(Equalone.deepEquals({'a': 1}, {'a': 1}), isTrue);
      expect(Equalone.deepEquals({'a': 1}, {'a': 1.0}), isTrue);
      expect(Equalone.deepEquals({'a': 1,'b':2}, {'b':2,'a':1}), isTrue);

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
      expect(Equalone.deepEquals(({1}, [2]), ({1}, [2])), isFalse);
    });
    test('null equality', () {
      expect(Equalone.deepEquals(null, null), isTrue);
      expect(Equalone.deepEquals(null, []), isFalse);
    });
  });
  group('Equalone wrapper', () {
    test('== and hashCode for lists', () {
      final a = Equalone.shallow([1, 2, 3]);
      final b = Equalone.shallow([1, 2, 3]);
      final c = Equalone.shallow([1, 3, 2]);
      final d = Equalone.shallow([1.0, 2.0, 3.0]);
      final e = Equalone.shallow([1.0, 2, 3.0]);

      expect(a == b, isTrue);
      expect(a == [1, 2, 3], isTrue);
      expect(a == c, isFalse);
      expect(a == d, isTrue);
      expect(a == e, isTrue);
      expect(e == a, isTrue);
      expect(a.hashCode, equals(b.hashCode));
      expect(a.hashCode, isNot(equals(c.hashCode)));
      expect(a.hashCode, equals(d.hashCode));
      expect(a.hashCode, equals(e.hashCode));
      expect(a.hashCode, isNot(equals([1, 2, 3].hashCode)));
    });
    test('== and hashCode for maps', () {
      final a = Equalone.shallow({'x': 1, 'y': 2});
      final b = Equalone.shallow({'y': 2, 'x': 1});
      final c = Equalone.shallow({'x': 2, 'y': 1});
      final d = Equalone.shallow({'x': 1.0, 'y': 2.0});

      expect(a == b, isTrue);
      expect(a == {'x': 1, 'y': 2}, isTrue);
      expect(a == c, isFalse);
      expect(a == d, isTrue);
      expect(d == a, isTrue);

      expect(a.hashCode, equals(b.hashCode));
      expect(a.hashCode, equals(c.hashCode));
      expect(a.hashCode, equals(d.hashCode));
      expect(a.hashCode, isNot(equals({'x': 1, 'y': 2}.hashCode)));
    });
    test('== and hashCode for records', () {
      final a = Equalone.shallow((1, 2, 3));
      final b = Equalone.shallow((1.0, 2.0, 3.0));
      expect(a == b, isTrue);
      expect(a == (1, 2, 3), isTrue);
      expect(b == a, isTrue);
      expect(a.hashCode, equals(b.hashCode));
      expect(a.hashCode, equals((1,2,3).hashCode));
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

    test('plain equality for collections in mixin', () {
      final a = PersonSpread('One', [1, 2, 3]);
      final b = PersonSpread('One', [1, 2, 3]);
      final c = PersonSpread('One', [3, 2, 1]);
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

    test('unordered score equality for collections in mixin', () {
      final a = PersonUnorderedScores('One', [1, 2, 3]);
      final b = PersonUnorderedScores('One', [3, 2, 1]);
      expect(a == b, isTrue);
    });

    test('complex equality for collections in mixin', () {
      final a = Person('One', [1, 2, 3], {'a':{'n':5}, 'b':[1]} );
      final b = Person('One', [3, 2, 1], {'b':[1], 'a':{'n':5}} );
      expect(a == b, isTrue);
    });

  });

}

