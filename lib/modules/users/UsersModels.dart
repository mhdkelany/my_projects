import 'package:firstpro/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Users extends StatelessWidget {
 List<InformationUsers> users=[
   InformationUsers(
       id: 1,
       name: 'mohmmad kelany',
       phone: '0999125454'),
   InformationUsers(
       id: 2,
       name: 'sayah kelany',
       phone: '09901254'),
   InformationUsers(
       id: 3,
       name: 'mohmmad khaled',
       phone: '092546855'),
   InformationUsers(
       id: 4,
       name: 'Rami Diar',
       phone: '058952292'),
   InformationUsers(
       id: 5,
       name: 'wael khalf',
       phone: '0966465285'),
   InformationUsers(
       id: 6,
       name: 'bassam kl',
       phone: '0993656755'),
   InformationUsers(
       id: 7,
       name: 'sameer ash',
       phone: '055565555'),
   InformationUsers(
       id: 8,
       name: 'sedra teba',
       phone: '0999999999'),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users'
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context,index)=>InfoUsers(users[index]),
          separatorBuilder: (contxt,index)=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 1,
              color: Colors.grey,
              width: double.infinity,
            ),
          ),
          itemCount:users.length,
      ),
    );
  }
  Widget InfoUsers(InformationUsers users)=>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
  children: [
  CircleAvatar(
  radius: 30.0,
  child: Text(
  '${users.id}',
  style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 35.0,
  ),
  ),
  ),
  SizedBox(
  width: 15.0,
  ),
  Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(
  '${users.name}',
  style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25.0,
  ),
  ),
  Text(
  '${users.phone}'
  ),
  ],
  ),
  ],
  ),
  );
}
