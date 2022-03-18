
import 'package:flutter/material.dart';


printLog(String? text,{bool printAll=true}) {
  const String key = "print-----";
  if(text==null){
    debugPrint("$key$text");
  }else{
    int maxLength = text.length;
    if (maxLength >=1000 && printAll==true) {
      debugPrint(key);
      debugPrint(text.substring(0,1000));
      printLog(text.substring(1000,maxLength),printAll: printAll);
    } else {
      debugPrint("$key$text");
    }
  }

}
