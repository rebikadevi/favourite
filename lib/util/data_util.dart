import 'dart:convert';


import 'package:favorite_app/model/data_model.dart';
import 'package:http/http.dart' as http;

class DataUtil {
  Future<List<DataModel>> getData() async {
    List<DataModel> listData=[];
    try {
      var request = http.Request(
          'GET', Uri.parse('https://fakestoreapi.com/products'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var rawData=await response.stream.bytesToString();
        List<dynamic> data=jsonDecode(rawData);
        data.forEach((element) {
          DataModel model=DataModel.fromJson(element);
          listData.add(model);
        });
        return listData;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      print("Exception in Data $e");
      throw e;
    }
  }
}