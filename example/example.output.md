# Type dependent comparison checks

Comparing values:
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

# Value dependent comparison checks

Comparing values:
```
 .---- [ operator == ]
 | .-- [ hashCode ]
 | | .-[ comparison ]
 + + <int>[1] == <int>[1]
 + + <int>[1] == <num>[1]
 + - <int>[1] == <num>[1]typed
 - - <int>[1] == <int>[1,2]
 - - <int>[1] == <int>[2,1]
 | |
 + + <num>[1] == <int>[1]
 + + <num>[1] == <num>[1]
 + - <num>[1] == <num>[1]typed
 - - <num>[1] == <int>[1,2]
 - - <num>[1] == <int>[2,1]
 | |
 - - <num>[1]typed == <int>[1]
 + - <num>[1]typed == <num>[1]
 + + <num>[1]typed == <num>[1]typed
 - - <num>[1]typed == <int>[1,2]
 - - <num>[1]typed == <int>[2,1]
 | |
 - - <int>[1,2] == <int>[1]
 - - <int>[1,2] == <num>[1]
 - - <int>[1,2] == <num>[1]typed
 + + <int>[1,2] == <int>[1,2]
 - + <int>[1,2] == <int>[2,1]
 | |
 - - <int>[2,1] == <int>[1]
 - - <int>[2,1] == <num>[1]
 - - <int>[2,1] == <num>[1]typed
 - + <int>[2,1] == <int>[1,2]
 + + <int>[2,1] == <int>[2,1]
```

# Person comparison
```
Person: false
PersonEx: true
PersonDeep: true
```

# Customization
default:
```
. 0 is empty: false
. list equality: false
```
customized:
```
. 0 is empty: true
. list equality: true
```

