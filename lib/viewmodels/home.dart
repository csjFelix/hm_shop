class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id,required this.imgUrl});
  // 扩展一个工厂函数，一般用“factory”来声明，通常被用来创建实例对象
  factory BannerItem.formJSON(Map<String,dynamic> result) {
    return BannerItem(id: result["id"] ?? "", imgUrl: result["imgUrl"] ?? "");
  }
}