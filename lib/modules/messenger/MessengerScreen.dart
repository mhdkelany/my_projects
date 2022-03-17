import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                'https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg'
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){},icon:
          CircleAvatar
            (
            radius: 15.0,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              )
          ),
          ),
          IconButton(onPressed: (){},icon:
          CircleAvatar
            (
              radius: 15.0,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.edit,
                size: 16,
                color: Colors.white,
              )
          ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.search,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Search'
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 110.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>ShowStorys(),
                    separatorBuilder: (context,index)=>SizedBox(width: 10.0),
                    itemCount: 10,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index)=>ShowMember(),
                  separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                  itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget ShowStorys()=> Container(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg'
              ),
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
            ),

          ],
        ),
        SizedBox(
          height: 10  ,
        ),
        Text(
          'Mohmmad Kelany',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
  Widget ShowMember()=>Row(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
            'https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg'
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              'Mohmmad Kelany',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children:  [
                Expanded(
                  child: Text(
                    'Hello mohmmad.I love you mmmmmmmmmmmmmmmmmmmmmmmm',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(end: 10),
                  child: CircleAvatar(
                    radius: 3.5,

                  ),
                ),
                Text(
                    '4:00 pm'
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
