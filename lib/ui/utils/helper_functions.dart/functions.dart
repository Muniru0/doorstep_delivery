





  String monthFormator(int? index){
  
   var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

   return months[index! - 1];

  }
  
   String weekdayFormator(int index){
  
   var weekdays = ['Mon','Tue','Wed','Thur','Fri','Sat','Sun'];

   return weekdays[index - 1];

  }
  
  
  void myPrint(msg,{String type = '-',String heading = '',String endText = 'END'}){


   print('$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type${heading.toUpperCase()}$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type');
   print(msg);
    print('$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type${endText.toUpperCase()}$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type$type');


}

String valueFormator(value,{bool isCurrency = false}){

var k = 1000;
var m = 1000000;
if(!isCurrency){
   return  value < k ? value.toString() : ( value >= k && value < m ?
      "${(value / k).toStringAsFixed(2)}" : "${(value / m).toStringAsFixed(4)}"
    );
}
  return  value < k ? value.toStringAsFixed(2) : ( value >= k && value < m ?
      "${(value / k).toStringAsFixed(2)}k" : "${(value / m).toStringAsFixed(4)}"
    );
}



String calculateDeliveryPersonelRating(int rating,int numberOfDeliveries){

    return (rating / (numberOfDeliveries * 5)).toStringAsFixed(1);
}