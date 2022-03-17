class ShopModel
{
  late bool status;
  HomeDataModel? data;
  ShopModel.formJson(Map<String,dynamic> json)
  {
    status=json['status'];
    data= HomeDataModel.fromJson(json['data']);
  }
}
class HomeDataModel
{
 final List<BannersModel> banners=[] ;
 final List<ProductsModel> products=[] ;
  HomeDataModel.fromJson(dynamic json)
  {
   // banners.addAll(json['banners']);
    json['banners'].forEach(( element)
    {
    banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element)
    {
     products.add(ProductsModel.fromJson(element));
    });
  }
}
class BannersModel
{
late int id;
late String image;
BannersModel({required this.id,required this.image});
BannersModel.fromJson(Map<String,dynamic> json)
   {
      id=json['id'];
      image=json['image'];
   }
}
class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}