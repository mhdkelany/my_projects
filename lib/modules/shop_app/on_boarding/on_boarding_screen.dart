import 'package:firstpro/modules/shop_app/login/login_screen.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/network/local/cache_helper.dart';
import 'package:firstpro/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class Model{
  String image;
  String title;
  String body;
  Model({required this.body,required this.image,required this.title});
}
class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Model> boarding=[
    Model(
        body: 'Screen Body1',
        image: 'assets/images/shop.jpg',
        title: 'Screen1 Title'
    ),
    Model(
        body: 'Screen Body2',
        image: 'assets/images/shop.jpg',
        title: 'Screen2 Title'
    ),
    Model(
        body: 'Screen Body3',
        image: 'assets/images/shop.jpg',
        title: 'Screen3 Title'
    ),
  ];
bool isLast=false;
  var pageControl=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
                {
                  CacheHelper.putData(key: 'boarding', value: true).then((value) {
                    if(value)
                      navigateToEnd(context, LoginScreenShop());
                  });

                },
              child: Text(
                  'SKIP',

              )
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageControl,
                onPageChanged: (index){
                  if(boarding.length-1==index)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }
                  else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildItem(boarding[index]),
                  itemCount:boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageControl,
                    count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4.0,
                    activeDotColor: defultColor,
                    spacing: 5
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        CacheHelper.putData(key: 'boarding', value: isLast).then((value) {
                          if(value)
                            navigateToEnd(context, LoginScreenShop());
                        });
                      }
                      pageControl.nextPage(
                          duration: Duration(
                            milliseconds: 500
                          ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    },
                  child: Icon(
                    Icons.arrow_forward_ios
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),

      ),
    );
  }

  Widget buildItem(Model model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${model.title}',
        style:TextStyle(
          fontSize: 30.0,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        '${model.body}',
        style:TextStyle(
          fontSize: 19.0,
        ),
      ),
      SizedBox(
        height: 30.0,
      )
    ],
  );
}
