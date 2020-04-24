class Product {
  String uname;
  String fname;
  String lname;
  String date;
  String email;
  String phone;
  String data;


  Product({this.data,this.uname, this.fname, this.lname,this.email,this.phone,this.date});

  Product.fromMap(Map snapshot) :
        uname = snapshot['uanme'] ?? '',
        fname = snapshot['fname'] ?? '',
        lname = snapshot['lname'] ?? '',
        date = snapshot['date'] ?? '',
        email = snapshot['email'] ?? '',
        data = snapshot['data'] ?? '';


  toJson() {
    return {
      "uname": uname,
      "fname": fname,
      "fname": lname,
      "data":data,

    };
  }
}