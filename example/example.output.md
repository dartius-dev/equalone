# Type dependent comparison
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
# Value dependent comparison
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

# Valued Equalone comparison
```
 .---- [ operator == ]
 | .-- [ hashCode ]
 | | .-[ comparison ]
 + + Equalone<String> == Equalone<String>
 + + Equalone<String> == ValueEqualone<PersonBad>(PersonBad)
 + + Equalone<String> == PayloadEqualone<PersonDeep>(PersonDeep)
 + + Equalone<String> == ValueEqualone<Customer>(Customer)
 + + Equalone<String> == PayloadEqualone<Producer>(Producer)
 + + Equalone<String> == NamedValueEqualone(Customer)
 + + Equalone<String> == NamedValueEqualone(Producer)
 + + Equalone<String> == MapValueEqualone({name: One})
 + + Equalone<String> == MapValueEqualone({id: One})
 + + Equalone<String> == MapValueEqualone({key: One})
 | |
 + + ValueEqualone<PersonBad>(PersonBad) == Equalone<String>
 + + ValueEqualone<PersonBad>(PersonBad) == ValueEqualone<PersonBad>(PersonBad)
 + + ValueEqualone<PersonBad>(PersonBad) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + ValueEqualone<PersonBad>(PersonBad) == ValueEqualone<Customer>(Customer)
 + + ValueEqualone<PersonBad>(PersonBad) == PayloadEqualone<Producer>(Producer)
 + + ValueEqualone<PersonBad>(PersonBad) == NamedValueEqualone(Customer)
 + + ValueEqualone<PersonBad>(PersonBad) == NamedValueEqualone(Producer)
 + + ValueEqualone<PersonBad>(PersonBad) == MapValueEqualone({name: One})
 + + ValueEqualone<PersonBad>(PersonBad) == MapValueEqualone({id: One})
 + + ValueEqualone<PersonBad>(PersonBad) == MapValueEqualone({key: One})
 | |
 + + PayloadEqualone<PersonDeep>(PersonDeep) == Equalone<String>
 + + PayloadEqualone<PersonDeep>(PersonDeep) == ValueEqualone<PersonBad>(PersonBad)
 + + PayloadEqualone<PersonDeep>(PersonDeep) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + PayloadEqualone<PersonDeep>(PersonDeep) == ValueEqualone<Customer>(Customer)
 + + PayloadEqualone<PersonDeep>(PersonDeep) == PayloadEqualone<Producer>(Producer)
 + + PayloadEqualone<PersonDeep>(PersonDeep) == NamedValueEqualone(Customer)
 + + PayloadEqualone<PersonDeep>(PersonDeep) == NamedValueEqualone(Producer)
 + + PayloadEqualone<PersonDeep>(PersonDeep) == MapValueEqualone({name: One})
 + + PayloadEqualone<PersonDeep>(PersonDeep) == MapValueEqualone({id: One})
 + + PayloadEqualone<PersonDeep>(PersonDeep) == MapValueEqualone({key: One})
 | |
 + + ValueEqualone<Customer>(Customer) == Equalone<String>
 + + ValueEqualone<Customer>(Customer) == ValueEqualone<PersonBad>(PersonBad)
 + + ValueEqualone<Customer>(Customer) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + ValueEqualone<Customer>(Customer) == ValueEqualone<Customer>(Customer)
 + + ValueEqualone<Customer>(Customer) == PayloadEqualone<Producer>(Producer)
 + + ValueEqualone<Customer>(Customer) == NamedValueEqualone(Customer)
 + + ValueEqualone<Customer>(Customer) == NamedValueEqualone(Producer)
 + + ValueEqualone<Customer>(Customer) == MapValueEqualone({name: One})
 + + ValueEqualone<Customer>(Customer) == MapValueEqualone({id: One})
 + + ValueEqualone<Customer>(Customer) == MapValueEqualone({key: One})
 | |
 + + PayloadEqualone<Producer>(Producer) == Equalone<String>
 + + PayloadEqualone<Producer>(Producer) == ValueEqualone<PersonBad>(PersonBad)
 + + PayloadEqualone<Producer>(Producer) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + PayloadEqualone<Producer>(Producer) == ValueEqualone<Customer>(Customer)
 + + PayloadEqualone<Producer>(Producer) == PayloadEqualone<Producer>(Producer)
 + + PayloadEqualone<Producer>(Producer) == NamedValueEqualone(Customer)
 + + PayloadEqualone<Producer>(Producer) == NamedValueEqualone(Producer)
 + + PayloadEqualone<Producer>(Producer) == MapValueEqualone({name: One})
 + + PayloadEqualone<Producer>(Producer) == MapValueEqualone({id: One})
 + + PayloadEqualone<Producer>(Producer) == MapValueEqualone({key: One})
 | |
 + + NamedValueEqualone(Customer) == Equalone<String>
 + + NamedValueEqualone(Customer) == ValueEqualone<PersonBad>(PersonBad)
 + + NamedValueEqualone(Customer) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + NamedValueEqualone(Customer) == ValueEqualone<Customer>(Customer)
 + + NamedValueEqualone(Customer) == PayloadEqualone<Producer>(Producer)
 + + NamedValueEqualone(Customer) == NamedValueEqualone(Customer)
 + + NamedValueEqualone(Customer) == NamedValueEqualone(Producer)
 + + NamedValueEqualone(Customer) == MapValueEqualone({name: One})
 + + NamedValueEqualone(Customer) == MapValueEqualone({id: One})
 + + NamedValueEqualone(Customer) == MapValueEqualone({key: One})
 | |
 + + NamedValueEqualone(Producer) == Equalone<String>
 + + NamedValueEqualone(Producer) == ValueEqualone<PersonBad>(PersonBad)
 + + NamedValueEqualone(Producer) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + NamedValueEqualone(Producer) == ValueEqualone<Customer>(Customer)
 + + NamedValueEqualone(Producer) == PayloadEqualone<Producer>(Producer)
 + + NamedValueEqualone(Producer) == NamedValueEqualone(Customer)
 + + NamedValueEqualone(Producer) == NamedValueEqualone(Producer)
 + + NamedValueEqualone(Producer) == MapValueEqualone({name: One})
 + + NamedValueEqualone(Producer) == MapValueEqualone({id: One})
 + + NamedValueEqualone(Producer) == MapValueEqualone({key: One})
 | |
 + + MapValueEqualone({name: One}) == Equalone<String>
 + + MapValueEqualone({name: One}) == ValueEqualone<PersonBad>(PersonBad)
 + + MapValueEqualone({name: One}) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + MapValueEqualone({name: One}) == ValueEqualone<Customer>(Customer)
 + + MapValueEqualone({name: One}) == PayloadEqualone<Producer>(Producer)
 + + MapValueEqualone({name: One}) == NamedValueEqualone(Customer)
 + + MapValueEqualone({name: One}) == NamedValueEqualone(Producer)
 + + MapValueEqualone({name: One}) == MapValueEqualone({name: One})
 + + MapValueEqualone({name: One}) == MapValueEqualone({id: One})
 + + MapValueEqualone({name: One}) == MapValueEqualone({key: One})
 | |
 + + MapValueEqualone({id: One}) == Equalone<String>
 + + MapValueEqualone({id: One}) == ValueEqualone<PersonBad>(PersonBad)
 + + MapValueEqualone({id: One}) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + MapValueEqualone({id: One}) == ValueEqualone<Customer>(Customer)
 + + MapValueEqualone({id: One}) == PayloadEqualone<Producer>(Producer)
 + + MapValueEqualone({id: One}) == NamedValueEqualone(Customer)
 + + MapValueEqualone({id: One}) == NamedValueEqualone(Producer)
 + + MapValueEqualone({id: One}) == MapValueEqualone({name: One})
 + + MapValueEqualone({id: One}) == MapValueEqualone({id: One})
 + + MapValueEqualone({id: One}) == MapValueEqualone({key: One})
 | |
 + + MapValueEqualone({key: One}) == Equalone<String>
 + + MapValueEqualone({key: One}) == ValueEqualone<PersonBad>(PersonBad)
 + + MapValueEqualone({key: One}) == PayloadEqualone<PersonDeep>(PersonDeep)
 + + MapValueEqualone({key: One}) == ValueEqualone<Customer>(Customer)
 + + MapValueEqualone({key: One}) == PayloadEqualone<Producer>(Producer)
 + + MapValueEqualone({key: One}) == NamedValueEqualone(Customer)
 + + MapValueEqualone({key: One}) == NamedValueEqualone(Producer)
 + + MapValueEqualone({key: One}) == MapValueEqualone({name: One})
 + + MapValueEqualone({key: One}) == MapValueEqualone({id: One})
 + + MapValueEqualone({key: One}) == MapValueEqualone({key: One})
```
# EqualoneUnorderedList comparison

```
 .---- [ operator == ]
 | .-- [ hashCode ]
 | | .-[ comparison ]
 + + EqualoneUnorderedList == EqualoneUnorderedList
 + + EqualoneUnorderedList == EqualoneUnorderedList<num>
 + + EqualoneUnorderedList == EqualoneUnorderedList<int>
 + + EqualoneUnorderedList == EqualoneUnorderedList<double>
 | |
 - + EqualoneUnorderedList<num> == EqualoneUnorderedList
 + + EqualoneUnorderedList<num> == EqualoneUnorderedList<num>
 + + EqualoneUnorderedList<num> == EqualoneUnorderedList<int>
 + + EqualoneUnorderedList<num> == EqualoneUnorderedList<double>
 | |
 - + EqualoneUnorderedList<int> == EqualoneUnorderedList
 - + EqualoneUnorderedList<int> == EqualoneUnorderedList<num>
 + + EqualoneUnorderedList<int> == EqualoneUnorderedList<int>
 - + EqualoneUnorderedList<int> == EqualoneUnorderedList<double>
 | |
 - + EqualoneUnorderedList<double> == EqualoneUnorderedList
 - + EqualoneUnorderedList<double> == EqualoneUnorderedList<num>
 - + EqualoneUnorderedList<double> == EqualoneUnorderedList<int>
 + + EqualoneUnorderedList<double> == EqualoneUnorderedList<double>
```

# Person comparison
```
Person: false
PersonEx: true
PersonDeep: true
```
# Customization
```
default:
. 0 is empty: false
. list equality: true
customized:
. 0 is empty: true
. list equality: true
```
