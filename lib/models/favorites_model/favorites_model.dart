class FavoritesModel
{
late bool status;
Data? data;
FavoritesModel.fromJson(dynamic json)
{
  status=json['status'];
  data=json['data']!=null? Data.fromJson(json['data']):null;
}
}
class Data
{
 late int currentPage;
  List<FavoritesData> favorites=[];
  Data.fromJson(dynamic json)
  {
    currentPage=json['current_page'];
    json['data'].forEach((element)
    {
      favorites.add(FavoritesData.fromJson(element));
    }
    );
  }
}
class FavoritesData
{
late  int id;
late Products products;
  FavoritesData.fromJson(dynamic json)
  {
    id=json['id'];
    products=(json['product']!=null?Products.fromJson(json['product']) :null)! ;
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