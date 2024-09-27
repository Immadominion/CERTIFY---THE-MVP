import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/local/secure_storage_service.dart';
import 'package:certify/data/services/create_certify_project.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

final createProjectController = ChangeNotifierProvider<CreateProjectController>(
    (ref) => CreateProjectController());

class CreateProjectController extends BaseChangeNotifier {
  String _imagePath = '';
  String get imagePath => _imagePath;
  File imageFile = File('');
  Uint8List imageBytes = Uint8List(0);
  String base64String = '';
  final ImagePicker picker = ImagePicker();
  late XFile? pickedFile;
  late final Uint8List? image;
  CreateProject createProject = CreateProject();
  final SecureStorageService secureStorageService =
      SecureStorageService(secureStorage: const FlutterSecureStorage());

  set imagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }

  Future<bool> pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Get the file path from the picked image
      imagePath = pickedFile!.path;
      debugPrint('Image Path: $imagePath');
      return true;
    } else {
      debugPrint('No image selected.');
      return false;
    }
  }

  Future<bool> toCreateProject(
    String name,
    String symbol,
    String description,
  ) async {
    loadingState = LoadingState.loading;
    try {
      final fileName = imageFile.path.split('/').last;
      debugPrint('FileName: $fileName');
      debugPrint('FilePath : $imagePath');
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imagePath,
        ),
        'name': name,
        'symbol': symbol,
        'description': description,
      });

      final response = await createProject.createProject(formData: formData);

      log(response.toString());
      if (response.statusCode == 200) {
        // model = ProfileModel.fromJson(response.data);
        loadingState = LoadingState.idle;
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    }
  }

  Future<bool> toCreateSingleNft(
    String nameFotNft,
    String symbol,
    String idOfExistingProject,
  ) async {
    loadingState = LoadingState.loading;
    try {
      final fileName = imageFile.path.split('/').last;
      debugPrint('FileName: $fileName');
      debugPrint('FilePath : $imagePath');
      FormData formData = FormData.fromMap({
        'name': nameFotNft,
        'description': symbol,
        'project_id': idOfExistingProject,
        'image': await MultipartFile.fromFile(
          imagePath,
        ),
      });
      final response = await createProject.createASingleNft(formData: formData);

      log(response.toString());
      if (response.statusCode == 200) {
        // model = ProfileModel.fromJson(response.data);
        loadingState = LoadingState.idle;
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.error;
      ErrorService.handleErrors(e);
      return false;
    }
  }
}
