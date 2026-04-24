import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  // final dioRequest = Diorequest();
  return ((await (dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((
    item,
  ) {
    return BannerItem.formJSON(item as Map<String, dynamic>);
  }).toList());
}

// 分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  return ((await (dioRequest.get(HttpConstants.CATEGORY_HEAD)) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList());
}
