extension GetDefferentDateTime on String {
 String get differenceOnDateTime{
    DateTime dateTime = DateTime.parse(this);
    var difference = DateTime.now().difference(dateTime);
    print(difference.inDays);
    if(difference.inDays >= 1){
      return "${difference.inDays} day ago";
    }else if(difference.inHours >=1){
      return "${difference.inHours} hour ago";
    }
    else if(difference.inMinutes >=1){
      return "${difference.inMinutes} minutes ago";
    }
    else{
      return "";
    }
  }
}
