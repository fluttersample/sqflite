
class PhoneBookFields{
  static final List<String> values =[
    name,id,number
  ];
  static const String name = 'name';
  static const String id = '_id';
  static const String number = 'number';
}



class PhoneBookModel {

  final int? number;
  final String? name;
  final int? id ;

 const PhoneBookModel({
    this.number,this.name,
     this.id});


  PhoneBookModel copyWith({
    int? id,
    int? number,
    String? name
  }){
    return PhoneBookModel(
        id: id??this.id,
        name: name??this.name,
        number: number ?? this.number
    );
  }




  Map<String,dynamic> toJson(){
    return {
      PhoneBookFields.id : id,
      PhoneBookFields.name : name,
      PhoneBookFields.number: number
    };
  }


  static PhoneBookModel fromJson(Map<String,dynamic> json){
    return PhoneBookModel(
      id: json[PhoneBookFields.id] as int?,
      number: json[PhoneBookFields.number] as int?,
      name: json[PhoneBookFields.name] as String
    );
  }


}