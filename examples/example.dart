import 'package:equalone/equalone.dart';

void main() {
  print("# Emptiness checks\n");
  print("0 is empty: ${Equalone.empty(0)}");
  Equalone.initialize(
    empty: (v) => switch(v) {num n => n == 0, _ => Equalone.defaultEmpty(v)},
  );
  print("0 is empty: ${Equalone.empty(0)}");
  print("");


  
  print("# Type dependent comparison checks\n");
  compare([
    Equalone<List>([1,2,3]),
    Equalone<List?>([1,2,3]),
    Equalone<List?>(null),
    Equalone<List<int>>([1,2,3]),
    Equalone<List<int>?>([1,2,3]),
    Equalone<List<int?>?>([1,2,3]),
    Equalone<List<int?>?>(null),
    Equalone<List<int>?>(null),
    <dynamic>[1,2,3],
    <int>[1,2,3],
    <int?>[1,2,3],
    null,
  ], 
    name: typeName
  );


  print("# Value dependent comparison checks\n");
  compare([
      Equalone([1]), Equalone(<num>[1]), Equalone(<num>[1], ignoreType: false),
      Equalone([1,2]), Equalone([2,1]),
    ], 
    name: valueName
  );

  print("# Person comparison\n");
  print("Person: ${PersonBad('Alice', [1,2,3]) == PersonBad('Alice', [1,2,3])}"); 
  print("PersonEx: ${PersonShallow('Alice', [1,2,3]) == PersonShallow('Alice', [1,2,3])}"); 
  print("PersonDeep: ${PersonDeep('Alice', [1,2,3]) == PersonDeep('Alice', [1,2,3])}"); 
  print("");
}

///
///
///
void compare(List values, {required String Function(Object?) name}) {
  print('Comparing values:');
  print(' .---- [ operator == ]');
  print(' | .-- [ hashCode ]');
  print(' | | .-[ comparison ]');
  for(int i=0; i<values.length; i++) {
    for(int j=0; j<values.length; j++) {
      final a = values[i];
      final b = values[j];
      final results = [a == b, a.hashCode == b.hashCode];
      print(
        ' ${results.map((r)=>r ?'+': '-').join(' ')} ${name(a)} == ${name(b)}'
      );
    }
    print(i == values.length - 1 ? '' : ' | |');
  }
}

String typeName(Object? obj) {
  if (obj == null) return 'null';
  return "${obj.runtimeType.toString().replaceAll('<dynamic>', '')}${obj is Equalone && obj.value==null ? 'Null':''}";
}
String valueName(Object? obj) {
  final e =obj as Equalone;
  final type = switch(e.value) {
    List<int> _=> '<int>',
    List<num> _=> '<num>',
    _=> '',
  };
  return "$type[${e.value.join(',')}]${e.ignoreType ? '' : 'typed'}";
}


///
/// Bad comparison usage
///
class PersonBad with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonBad(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, scores];
}

///
/// Shallow comparison
///
class PersonShallow with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonShallow(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, ...scores];
}

///
/// Deep comparison with Equalone
///
class PersonDeep with EqualoneMixin {
  final String name;
  final List<int> scores;

  PersonDeep(this.name, this.scores);

  @override
  List<Object?> get equalones => [name, Equalone(scores)];
}