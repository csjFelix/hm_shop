import 'package:flutter/cupertino.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: List.empty()
  );
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    // BannerItem(
    //   id: "1",
    //   imgUrl:
    //       "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    // ),
    // BannerItem(
    //   id: "2",
    //   imgUrl:
    //       "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    // ),
    // BannerItem(
    //   id: "3",
    //   imgUrl:
    //       "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    // ),
  ];

  List<Widget> _getScrollChildren() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // slivergrid和sliverList只能纵向排列
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(child: HmSuggestion(specialRecommendResult: _specialRecommendResult)), // 推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot(result: _inVogueResult, type: "hot",)), // 热榜推荐组件
              SizedBox(width: 10),
              Expanded(child: HmHot(result: _oneStopResult, type: "step",)), // 一站式推荐组件
            ],
          ),
        ),
      ), // 推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  void _getBannerList() async {
    final list = await getBannerListAPI();
    if (!mounted) return;
    setState(() {
      _bannerList = list;
    });
  }
  void _getCategoryList() async {
    final list = await getCategoryListAPI();
    if (!mounted) return;
    setState(() {
      _categoryList = list;
    });
  }
  void _getSpecialRecommendList() async {
    final result = await getSpecialRecommendListAPI();
    if (!mounted) return;
    setState(() {
      _specialRecommendResult = result;
    });
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

 // 获取推荐列表
  void _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
    // 获取推荐组件数据
    _getSpecialRecommendList();
    // setState(() {});

    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren()); // sliver家族的内容
  }
}
