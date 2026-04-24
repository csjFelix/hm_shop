// 基于Dio二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';

class Diorequest {
  final _dio = Dio();
  Diorequest() {
    _dio.options
      ..baseUrl = GlobalConstans.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstans.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstans.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstans.TIME_OUT);
    _addInterceptor();
  }
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          handler.next(request);
        },
        onResponse: (respose, handler) {
          if (respose.statusCode! >= 200 && respose.statusCode! < 300) {
            handler.next(respose);
            return;
          }
          handler.reject(DioException(requestOptions: respose.requestOptions));
          // requestOptions是DioException 构造函数必填参数，标识是哪个请求出的错
        },
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handlerResponse(_dio.get(url, queryParameters: params));
  }

  // 进一步处理返回的结果
  Future<dynamic> _handlerResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstans.SUCCESS_CODE) {
        // 才认定http状态和业务状态均正常，就可以正常的放行通过
        return data["result"]; //只要result结果
      }
      throw Exception(data["msg"] ?? "加载数据异常");
    } catch (e) {
      throw Exception(e);
    }
  }
}

// 单例对象 这里只是一个模块级别的单例，并不算严格意义上的单例模式，外部仍然可以通过new Diorequest()创建一个新的实例
// 在实际使用中，只要项目里统一使用 dioRequest 这个顶层变量，行为上和单例完全一致，
// 这是 Flutter/Dart 项目中最常见也最简洁的做法，没有问题
final dioRequest = Diorequest();
