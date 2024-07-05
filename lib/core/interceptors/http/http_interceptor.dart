import 'package:http_interceptor/http_interceptor.dart';
import 'package:ultrasound_clinic/utils/logger/logger.dart';

class HttpBaseInterceptor implements InterceptorContract {
  final log = CustomLogger.getLogger('BaseHttp');

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    log.i("Request: ${request.url}");
    // data.headers['Authorization'] = 'Bearer your_token_here';
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    log.i("Response: ${response.statusCode}");
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return false;
  }
}
