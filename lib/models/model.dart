


// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)

class History_Model extends HiveObject{


@HiveField(0)
String ? qr_code ;

@HiveField(1)
String ? title ;

History_Model({
required this.qr_code,
required this.title,
});

}



@HiveType(typeId: 1)

class Generate_Model extends HiveObject{


@HiveField(0)
String ? qr_code ;

@HiveField(1)
String ? title ;

Generate_Model({
required this.qr_code,
required this.title,
});

}
