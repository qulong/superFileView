class InheritedWidgetData{
  String userName;
  int userAge;

  InheritedWidgetData({this.userName = "", this.userAge = 0});

  void setUser(String userName, int userAge) {
    this.userName = userName;
    this.userAge = userAge;
  }
}