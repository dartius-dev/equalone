
## Type dependent comparison
```
 .---- [ operator == ]
 | .-- [ hashCode ]
 | | .-[ comparison ]
 + + Equalone<List> == Equalone<List>
 + + Equalone<List> == Equalone<List?>
 - - Equalone<List> == Equalone<List?>Null
 + + Equalone<List> == Equalone<List<int>>
 + + Equalone<List> == Equalone<List<int>?>
 + + Equalone<List> == Equalone<List<int?>?>
 - - Equalone<List> == Equalone<List<int?>?>Null
 - - Equalone<List> == Equalone<List<int>?>Null
 + - Equalone<List> == List
 + - Equalone<List> == List<int>
 + - Equalone<List> == List<int?>
 - - Equalone<List> == null
 | |
 + + Equalone<List?> == Equalone<List>
 + + Equalone<List?> == Equalone<List?>
 - - Equalone<List?> == Equalone<List?>Null
 + + Equalone<List?> == Equalone<List<int>>
 + + Equalone<List?> == Equalone<List<int>?>
 + + Equalone<List?> == Equalone<List<int?>?>
 - - Equalone<List?> == Equalone<List<int?>?>Null
 - - Equalone<List?> == Equalone<List<int>?>Null
 + - Equalone<List?> == List
 + - Equalone<List?> == List<int>
 + - Equalone<List?> == List<int?>
 - - Equalone<List?> == null
 | |
 - - Equalone<List?>Null == Equalone<List>
 - - Equalone<List?>Null == Equalone<List?>
 + + Equalone<List?>Null == Equalone<List?>Null
 - - Equalone<List?>Null == Equalone<List<int>>
 - - Equalone<List?>Null == Equalone<List<int>?>
 - - Equalone<List?>Null == Equalone<List<int?>?>
 + + Equalone<List?>Null == Equalone<List<int?>?>Null
 + + Equalone<List?>Null == Equalone<List<int>?>Null
 - - Equalone<List?>Null == List
 - - Equalone<List?>Null == List<int>
 - - Equalone<List?>Null == List<int?>
 - + Equalone<List?>Null == null
 | |
 + + Equalone<List<int>> == Equalone<List>
 + + Equalone<List<int>> == Equalone<List?>
 - - Equalone<List<int>> == Equalone<List?>Null
 + + Equalone<List<int>> == Equalone<List<int>>
 + + Equalone<List<int>> == Equalone<List<int>?>
 + + Equalone<List<int>> == Equalone<List<int?>?>
 - - Equalone<List<int>> == Equalone<List<int?>?>Null
 - - Equalone<List<int>> == Equalone<List<int>?>Null
 + - Equalone<List<int>> == List
 + - Equalone<List<int>> == List<int>
 + - Equalone<List<int>> == List<int?>
 - - Equalone<List<int>> == null
 | |
 + + Equalone<List<int>?> == Equalone<List>
 + + Equalone<List<int>?> == Equalone<List?>
 - - Equalone<List<int>?> == Equalone<List?>Null
 + + Equalone<List<int>?> == Equalone<List<int>>
 + + Equalone<List<int>?> == Equalone<List<int>?>
 + + Equalone<List<int>?> == Equalone<List<int?>?>
 - - Equalone<List<int>?> == Equalone<List<int?>?>Null
 - - Equalone<List<int>?> == Equalone<List<int>?>Null
 + - Equalone<List<int>?> == List
 + - Equalone<List<int>?> == List<int>
 + - Equalone<List<int>?> == List<int?>
 - - Equalone<List<int>?> == null
 | |
 + + Equalone<List<int?>?> == Equalone<List>
 + + Equalone<List<int?>?> == Equalone<List?>
 - - Equalone<List<int?>?> == Equalone<List?>Null
 + + Equalone<List<int?>?> == Equalone<List<int>>
 + + Equalone<List<int?>?> == Equalone<List<int>?>
 + + Equalone<List<int?>?> == Equalone<List<int?>?>
 - - Equalone<List<int?>?> == Equalone<List<int?>?>Null
 - - Equalone<List<int?>?> == Equalone<List<int>?>Null
 + - Equalone<List<int?>?> == List
 + - Equalone<List<int?>?> == List<int>
 + - Equalone<List<int?>?> == List<int?>
 - - Equalone<List<int?>?> == null
 | |
 - - Equalone<List<int?>?>Null == Equalone<List>
 - - Equalone<List<int?>?>Null == Equalone<List?>
 + + Equalone<List<int?>?>Null == Equalone<List?>Null
 - - Equalone<List<int?>?>Null == Equalone<List<int>>
 - - Equalone<List<int?>?>Null == Equalone<List<int>?>
 - - Equalone<List<int?>?>Null == Equalone<List<int?>?>
 + + Equalone<List<int?>?>Null == Equalone<List<int?>?>Null
 + + Equalone<List<int?>?>Null == Equalone<List<int>?>Null
 - - Equalone<List<int?>?>Null == List
 - - Equalone<List<int?>?>Null == List<int>
 - - Equalone<List<int?>?>Null == List<int?>
 - + Equalone<List<int?>?>Null == null
 | |
 - - Equalone<List<int>?>Null == Equalone<List>
 - - Equalone<List<int>?>Null == Equalone<List?>
 + + Equalone<List<int>?>Null == Equalone<List?>Null
 - - Equalone<List<int>?>Null == Equalone<List<int>>
 - - Equalone<List<int>?>Null == Equalone<List<int>?>
 - - Equalone<List<int>?>Null == Equalone<List<int?>?>
 + + Equalone<List<int>?>Null == Equalone<List<int?>?>Null
 + + Equalone<List<int>?>Null == Equalone<List<int>?>Null
 - - Equalone<List<int>?>Null == List
 - - Equalone<List<int>?>Null == List<int>
 - - Equalone<List<int>?>Null == List<int?>
 - + Equalone<List<int>?>Null == null
 | |
 - - List == Equalone<List>
 - - List == Equalone<List?>
 - - List == Equalone<List?>Null
 - - List == Equalone<List<int>>
 - - List == Equalone<List<int>?>
 - - List == Equalone<List<int?>?>
 - - List == Equalone<List<int?>?>Null
 - - List == Equalone<List<int>?>Null
 + + List == List
 - - List == List<int>
 - - List == List<int?>
 - - List == null
 | |
 - - List<int> == Equalone<List>
 - - List<int> == Equalone<List?>
 - - List<int> == Equalone<List?>Null
 - - List<int> == Equalone<List<int>>
 - - List<int> == Equalone<List<int>?>
 - - List<int> == Equalone<List<int?>?>
 - - List<int> == Equalone<List<int?>?>Null
 - - List<int> == Equalone<List<int>?>Null
 - - List<int> == List
 + + List<int> == List<int>
 - - List<int> == List<int?>
 - - List<int> == null
 | |
 - - List<int?> == Equalone<List>
 - - List<int?> == Equalone<List?>
 - - List<int?> == Equalone<List?>Null
 - - List<int?> == Equalone<List<int>>
 - - List<int?> == Equalone<List<int>?>
 - - List<int?> == Equalone<List<int?>?>
 - - List<int?> == Equalone<List<int?>?>Null
 - - List<int?> == Equalone<List<int>?>Null
 - - List<int?> == List
 - - List<int?> == List<int>
 + + List<int?> == List<int?>
 - - List<int?> == null
 | |
 - - null == Equalone<List>
 - - null == Equalone<List?>
 - + null == Equalone<List?>Null
 - - null == Equalone<List<int>>
 - - null == Equalone<List<int>?>
 - - null == Equalone<List<int?>?>
 - + null == Equalone<List<int?>?>Null
 - + null == Equalone<List<int>?>Null
 - - null == List
 - - null == List<int>
 - - null == List<int?>
 + + null == null
```
## Value dependent comparison
```
 .---- [ operator == ]
 | .-- [ hashCode ]
 | | .-[ comparison ]
 + + <int>[1]ShallowCollectionEquality == <int>[1]ShallowCollectionEquality
 + + <int>[1]ShallowCollectionEquality == <num>[1]ShallowCollectionEquality
 - - <int>[1]ShallowCollectionEquality == <int>[1,2]ShallowCollectionEquality
 - - <int>[1]ShallowCollectionEquality == <int>[2,1]ShallowCollectionEquality
 | |
 + + <num>[1]ShallowCollectionEquality == <int>[1]ShallowCollectionEquality
 + + <num>[1]ShallowCollectionEquality == <num>[1]ShallowCollectionEquality
 - - <num>[1]ShallowCollectionEquality == <int>[1,2]ShallowCollectionEquality
 - - <num>[1]ShallowCollectionEquality == <int>[2,1]ShallowCollectionEquality
 | |
 - - <int>[1,2]ShallowCollectionEquality == <int>[1]ShallowCollectionEquality
 - - <int>[1,2]ShallowCollectionEquality == <num>[1]ShallowCollectionEquality
 + + <int>[1,2]ShallowCollectionEquality == <int>[1,2]ShallowCollectionEquality
 - - <int>[1,2]ShallowCollectionEquality == <int>[2,1]ShallowCollectionEquality
 | |
 - - <int>[2,1]ShallowCollectionEquality == <int>[1]ShallowCollectionEquality
 - - <int>[2,1]ShallowCollectionEquality == <num>[1]ShallowCollectionEquality
 - - <int>[2,1]ShallowCollectionEquality == <int>[1,2]ShallowCollectionEquality
 + + <int>[2,1]ShallowCollectionEquality == <int>[2,1]ShallowCollectionEquality
```
## EqualoneUnorderedList comparison
```
 .---- [ operator == ]
 | .-- [ hashCode ]
 | | .-[ comparison ]
 + + EqualoneUnorderedList == EqualoneUnorderedList
 + + EqualoneUnorderedList == EqualoneUnorderedList<num>
 + + EqualoneUnorderedList == EqualoneUnorderedList<int>
 + + EqualoneUnorderedList == EqualoneUnorderedList<double>
 | |
 + + EqualoneUnorderedList<num> == EqualoneUnorderedList
 + + EqualoneUnorderedList<num> == EqualoneUnorderedList<num>
 + + EqualoneUnorderedList<num> == EqualoneUnorderedList<int>
 + + EqualoneUnorderedList<num> == EqualoneUnorderedList<double>
 | |
 + + EqualoneUnorderedList<int> == EqualoneUnorderedList
 + + EqualoneUnorderedList<int> == EqualoneUnorderedList<num>
 + + EqualoneUnorderedList<int> == EqualoneUnorderedList<int>
 + + EqualoneUnorderedList<int> == EqualoneUnorderedList<double>
 | |
 + + EqualoneUnorderedList<double> == EqualoneUnorderedList
 + + EqualoneUnorderedList<double> == EqualoneUnorderedList<num>
 + + EqualoneUnorderedList<double> == EqualoneUnorderedList<int>
 + + EqualoneUnorderedList<double> == EqualoneUnorderedList<double>
```
## Person comparison
```
Person: false
PersonEx: true
PersonDeep: true
```