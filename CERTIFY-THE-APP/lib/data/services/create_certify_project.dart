import 'package:dio/dio.dart' show FormData, Response;
import 'dio_mixin.dart';

class CreateProject with DioMixin {
  Future<Response<dynamic>> createProject({required FormData formData}) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/project',
      data: formData,
    );
    return response;
  }

  Future<Response<dynamic>> createASingleNft(
      {required FormData formData}) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
    };
    final response = await connect(customHeaders: customHeaders).post(
      '/nft',
      data: formData,
    );
    return response;
  }
}
