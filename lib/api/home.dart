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

// 特惠推荐列表
Future<SpecialRecommendResult> getSpecialRecommendListAPI() async {
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.PRODUCT_PREFERENCE)
        as Map<String, dynamic>,
  );
}

// 热榜推荐
Future<SpecialRecommendResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecialRecommendResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}
