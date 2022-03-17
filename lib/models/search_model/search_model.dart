class SearchModel
{
  late bool status;
  Data? data;
  SearchModel.fromJson(dynamic json)
  {
    status=json['status'];
    data=json['data']!=null? Data.fromJson(json['data']):null;
  }
}
class Data
{
  late int currentPage;
  List<Products> products=[];
  Data.fromJson(dynamic json)
  {
    currentPage=json['current_page'];
    json['data'].forEach((element)
    {
      products.add(Products.fromJson(element));
    }
    );
  }
}
class Products
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  Products.fromJson(dynamic json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
  }
}