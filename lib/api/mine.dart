import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<GoodsDetailsItems> getGuessListApi(Map<String, dynamic> params) async {
  return GoodsDetailsItems.formJSON(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
