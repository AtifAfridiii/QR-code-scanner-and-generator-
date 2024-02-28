import 'package:hive/hive.dart';
import 'package:qrcode_scanner/models/model.dart';

class Retrive {

static Box<History_Model> getData()=>Hive.box<History_Model>('History');
static Box<Generate_Model> getData2()=>Hive.box<Generate_Model>('History2');


}