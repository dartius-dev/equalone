import 'package:equalone/equalone.dart';
import 'package:equalone/collection.dart';

import 'example.lib.dart';

void main() {
  {
    print("# Type dependent comparison\n");
    compare([
      Equalone<List>([1, 2, 3]),
      Equalone<List?>([1, 2, 3]),
      Equalone<List?>(null),
      Equalone<List<int>>([1, 2, 3]),
      Equalone<List<int>?>([1, 2, 3]),
      Equalone<List<int?>?>([1, 2, 3]),
      Equalone<List<int?>?>(null),
      Equalone<List<int>?>(null),
      <dynamic>[1, 2, 3],
      <int>[1, 2, 3],
      <int?>[1, 2, 3],
      null,
    ], name: typeName);
  }

  {
    print("# Value dependent comparison\n");
    compare([
      Equalone([1]),
      Equalone(<num>[1]),
      Equalone(<num>[1], ignoreType: false),
      Equalone([1, 2]),
      Equalone([2, 1]),
    ], name: valueName);
  }

  {
    final a = PersonRef('One', [1]);
    final b = PersonDeep('One', [2]);
    final c = Customer('One', 30);
    final d = Producer('One', 0.6);
    final e = <String, dynamic>{'name': 'One'};
    final f = <String, String>{'id': 'One'};
    final g = {'key': 'One'};

    print("# Extended Equalone comparison\n");
    compare([
      Equalone('One'),
      ValueEqualone(a, (o) => o?.name),
      PayloadEqualone(b.name, data: b),
      ValueEqualone(c, (o) => o?.name),
      PayloadEqualone(d.name, data: d),
      NamedValueEqualone(c),
      NamedValueEqualone(d),
      MapValueEqualone(e, 'name'),
      MapValueEqualone(f, 'id'),
      MapValueEqualone(g, 'key'),
    ], name: typedEqualone);
  }

  {
    print("# EqualoneUnorderedList comparison\n");
    compare([
      EqualoneUnorderedList<dynamic>([1, 2, 3]),
      EqualoneUnorderedList<num>([1, 3, 2]),
      EqualoneUnorderedList<int>([2, 3, 1]),
      EqualoneUnorderedList<double>([2, 3, 1]),
    ], name: typeName);
  }

  {
    print("# Person comparison\n");
    print(
        "Person: ${PersonRef('One', [1, 2, 3]) == PersonRef('One', [1, 2, 3])}");
    print(
        "PersonEx: ${PersonShallow('One', [1, 2, 3]) == PersonShallow('One', [1, 2, 3])}");
    print(
        "PersonDeep: ${PersonDeep('One', [1, 2, 3]) == PersonDeep('One', [1, 2, 3])}");
    print("");
  }

  {
    print("# Customization");
    print("default:");
    print(". 0 is empty: ${Equalone.empty(0)}");
    print(". list equality: ${Equalone.equals(<num>[0], [0])}");
    Equalone.customize(
      equals:
          const DeepCollectionEquality.unordered().equals, // Type-insensitive unordered deep equality
      empty: (v) => switch (v) { num n => n == 0, _ => Equalone.defaultEmpty(v) },
    );
    print("customized:");
    print(". 0 is empty: ${Equalone.empty(0)}");
    print(". list equality: ${Equalone.equals(<num>[1,2], [2,1])}");
    print("");
  }
}

///
///
///
void compare(List values, {required String Function(Object?) name}) {
  print(' .---- [ operator == ]');
  print(' | .-- [ hashCode ]');
  print(' | | .-[ comparison ]');
  for (int i = 0; i < values.length; i++) {
    for (int j = 0; j < values.length; j++) {
      final a = values[i];
      final b = values[j];
      final results = [a == b, a.hashCode == b.hashCode];
      print(
          ' ${results.map((r) => r ? '+' : '-').join(' ')} ${name(a)} == ${name(b)}');
    }
    print(i == values.length - 1 ? '' : ' | |');
  }
}

String typeName(Object? obj) {
  if (obj == null) return 'null';
  return "${obj.runtimeType.toString().replaceAll('<dynamic>', '')}${obj is Equalone && obj.value == null ? 'Null' : ''}";
}
String typedEqualone(Object? obj) {
  if (obj == null) return 'null';
  final name = obj.toString().replaceAll('<dynamic>', '').replaceAll('Instance of ', '').replaceAll("'", '');
  return "$name${obj is Equalone && obj.value == null ? 'Null' : ''}";
}

String valueName(Object? obj) {
  final e = obj as Equalone;
  final type = switch (e.value) {
    List<int> _ => '<int>',
    List<num> _ => '<num>',
    _ => '',
  };
  return "$type[${e.value.join(',')}]${e.ignoreType ? '' : 'typed'}";
}

