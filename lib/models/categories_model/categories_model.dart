class CategoriesModel
{
 late bool status;
 DataModel? data;
  CategoriesModel.fromJson(dynamic json)
  {
    status=json['status'];
    data=DataModel.fromJson(json['data']);
  }


}
class DataModel{
 late int currentPage;
 List<Data> catData=[];
 DataModel.fromJson(dynamic json)
 {
  currentPage=json['current_page'];
  json['data'].forEach((element){
   catData.add(Data.fromJson(element));
  });
 }
}
class Data
{
 late int id;
 late String image;
 late String name;
 Data.fromJson(dynamic json)
 {
  id=json['id'];
  image=json['image'];
  name=json['name'];
 }
}