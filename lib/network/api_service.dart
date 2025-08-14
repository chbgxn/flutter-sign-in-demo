import 'package:dio/dio.dart';
import 'package:sign_in_demo/network/app_exception.dart';

class ApiService {
  final Dio _dio;
  
  ApiService(): _dio = Dio(BaseOptions(
    baseUrl: 'http://127.0.0.1:5000',
    connectTimeout: const Duration(seconds: 8),
    // connectTimeout: Duration(milliseconds: 500) 
    receiveTimeout: const Duration(seconds: 8)
  )){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) => handler.next(options),
      onResponse: (response, handler) {
        if(response.data['code'] != 200){
          return handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              error: AppException(
                message: response.data['data']['error'] ?? '业务错误', 
                code: response.data['code'],
                type: ExceptionType.business
              ),
              response: response,
              type: DioExceptionType.badResponse
            )
          );
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        AppException appError;
        if(error.error is AppException){
          appError = error.error as AppException;
        }
        else{
          switch(error.type){
            case DioExceptionType.connectionTimeout:
              appError = AppException(
                message: '连接超时,请检查网络', 
                code: 408, 
                type: ExceptionType.timeout
              );
              break;
            case DioExceptionType.connectionError:
              appError = AppException(
                message: '网络错误,请稍后重试',
                code: 503,
                type: ExceptionType.network
              );
              break;
            default:
              appError = AppException(
                message: error.message ?? '发生未知错误',
                code: -1,
                type: ExceptionType.unknown
              );
          }
        }
        handler.next(
          DioException(
            requestOptions: error.requestOptions, 
            error: appError,
            type: error.type,
            response: error.response
          )
        );
      },
    ));
  }

  Future<Response> post({required Map<String, dynamic> data}) async {
    await Future.delayed(Duration(seconds: 3)); //模拟网络延迟
    return await _dio.post(
      '/signin',
      data: data,
    );
  }
}