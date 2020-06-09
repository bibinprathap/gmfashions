import 'dart:convert';

import 'package:http/http.dart' as http;

var headers = {'authorization' : 'oasisspa'};

Future<String> httpGet({String url}) async {
  var response = await http.get(url);
  print('url-$url');
  if(response.statusCode == 200){
    print('Response- ${response.body}');
    return response.body;
  }
  else{
    return 'error';
  }
}



Future<String> httpPost({String url,Map<String,String> params}) async{
  print('url - $url, params - $params');
  var response = await http.post(url,body: params);
  print('Response- ${response.body}');
  if(response.statusCode == 200){
    return response.body;
  }
  else{
    return 'Error';
  }
}
