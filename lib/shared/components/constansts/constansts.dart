import 'package:firstpro/modules/shop_app/login/login_screen.dart';
import 'package:firstpro/shared/components/components.dart';
import 'package:firstpro/shared/network/local/cache_helper.dart';

String token='';

void logOut(context)
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value)
      navigateToEnd(context, LoginScreenShop());
  });

}