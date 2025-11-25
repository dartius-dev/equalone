import 'package:equalone/equalone.dart';

import 'example.lib.dart';


void main() {
  {
    print("# Type dependent comparison\n");
    compare([
      Equalone<List>.shallow([1, 2, 3]),
      Equalone<List?>.shallow([1, 2, 3]),
      Equalone<List?>.shallow(null),
      Equalone<List<int>>.shallow([1, 2, 3]),
      Equalone<List<int>?>.shallow([1, 2, 3]),
      Equalone<List<int?>?>.shallow([1, 2, 3]),
      Equalone<List<int?>?>.shallow(null),
      Equalone<List<int>?>.shallow(null),
      <dynamic>[1, 2, 3],
      <int>[1, 2, 3],
      <int?>[1, 2, 3],
      null,
    ], name: typeName);
  }

  {
    print("# Value dependent comparison\n");
    compare([
      Equalone.shallow([1]),
      Equalone.shallow(<num>[1]),
      Equalone.shallow([1, 2]),
      Equalone.shallow([2, 1]),
    ], name: valueName);
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
        "PersonEx: ${PersonSpread('One', [1, 2, 3]) == PersonSpread('One', [1, 2, 3])}");
    print(
        "PersonDeep: ${PersonShallow('One', [1, 2, 3]) == PersonShallow('One', [1, 2, 3])}");
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
  return "$type[${e.value.join(',')}]${e.equality.runtimeType}";
}

