import 'dart:convert';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/local/secure_storage_service.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:certify/utils/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:certify/data/services/sign_up_services.dart';

final certifySignUpController =
    ChangeNotifierProvider<SignUpController>((ref) => SignUpController());

class SignUpController extends BaseChangeNotifier {
  SignupService signupService = SignupService();

  Future<bool> signUp(String name, String email, String password) async {
    loadingState = LoadingState.loading;
    try {
      final res = await signupService.signUp(
        name: name,
        credential: email,
        password: password,
      );
      if (res.statusCode == 201) {
        Map<String, dynamic> jsonDataMap = json.decode(res.toString());
        // Extract the "token" value
        String token = jsonDataMap['token'];
        // Print the token
        debugPrint("Token: $token");
        await locator<SecureStorageService>().write(
          key: 'token',
          value: token,
        );
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    }
    return false;
  }
}
