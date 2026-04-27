import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 推荐列表
  List<GoodDetailItem> _recommendList = [];
  // 定义三个参数
  // 页码
  int _page = 1;
  // 当前正在加载状态
  bool _isLoading = false;
  // 是否还有下一页
  bool _hasMore = true;

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
    subTypes: List.empty(),
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
      SliverToBoxAdapter(
        child: HmCategory(categoryList: _categoryList),
      ), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ), // 推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ), // 热榜推荐组件
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ), // 一站式推荐组件
            ],
          ),
        ),
      ), // 推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  Future<void> _getBannerList() async {
    final list = await getBannerListAPI();
    if (!mounted) return;
    setState(() {
      _bannerList = list;
    });
  }

  Future<void> _getCategoryList() async {
    final list = await getCategoryListAPI();
    if (!mounted) return;
    setState(() {
      _categoryList = list;
    });
  }

  Future<void> _getSpecialRecommendList() async {
    final result = await getSpecialRecommendListAPI();
    if (!mounted) return;
    setState(() {
      _specialRecommendResult = result;
    });
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    // 当目前已经有请求在加载，或者是已经没有下一页了，就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false;

    // 我要10条，你给10条，说明我要的你都给了，接着认为还有下一页
    // 我要10条，你给了9条
    setState(() {});
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++;
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        // 加载下一页数据
        _getRecommendList();
      }
    });
  }

  //
  Future<void> _onRefresh() async {
    _page = 1;
    // 当前正在加载状态
    _isLoading = false;
    // 是否还有下一页
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    ToastUtils.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});

    // 数据获取成功，跳一个toast提示用户刷新成功
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     width: 120,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadiusGeometry.circular(40)
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //     duration: Duration(seconds: 10),
    //     content: Text("刷新成功", textAlign: TextAlign.center),
    //   ),
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getBannerList();
    // _getCategoryList();
    // // 获取推荐组件数据
    // _getSpecialRecommendList();
    // // setState(() {});

    // _getInVogueList();
    // _getOneStopList();
    // _getRecommendList();
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }
  // initState -> build ->下拉刷新组件 -> 才可以操作这个下拉刷新组件

  final ScrollController _controller = ScrollController();
  // GlobalKey是一个方法可以创建一个key绑定到widget部件上，可以操作widget组件
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey();

  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: (_onRefresh),
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),

        duration: Duration(microseconds: 300),
        child: CustomScrollView(
          controller: _controller, // 绑定控制器
          slivers: _getScrollChildren(),
        ),
      ),
    ); // sliver家族的内容
  }
}
