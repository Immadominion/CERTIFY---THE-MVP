// ignore_for_file: prefer_is_empty

import 'dart:async';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/model_data/all_certified_projects_model.dart';
import 'package:certify/data/model_data/qr_data.dart';
import 'package:certify/data/model_data/scanned_code_model.dart';
import 'package:certify/data/services/all_certified_service.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allCertifiedProjectsController =
    ChangeNotifierProvider<AllProjectsController>(
        (ref) => AllProjectsController());

class AllProjectsController extends BaseChangeNotifier {
  AllCertifiedServices allCertifiedServices = AllCertifiedServices();
  AllCertifiedProjectsModel allCertifiedProjectsModel =
      AllCertifiedProjectsModel();
  QRDataModel qrDataModel = QRDataModel();
  ScannedCodeModel _scannedCodeModel = ScannedCodeModel();
  ScannedCodeModel get scannedCodeModel => _scannedCodeModel;
  bool _shouldReload = false;
  bool get shouldReload => _shouldReload;

  set shouldReload(bool reload) {
    _shouldReload = reload;
    notifyListeners();
  }

  set scannedCodeModel(res) {
    _scannedCodeModel = ScannedCodeModel.fromJson(res);
  }

  void disposeAllCertifiedProjectsController() {
    allCertifiedProjectsModel = AllCertifiedProjectsModel();
  }

  Future<bool> toGetAllCertifyProjects() async {
    // Check if the entire model has data
    if (shouldReload || allCertifiedProjectsModel.results?.length == null) {
      try {
        // loadingState = LoadingState.loading;
        debugPrint('shh To Get All Manufacturer Projects');
        final res = await allCertifiedServices.getAllCertifiedProjects();
        if (res.statusCode == 200) {
          debugPrint("INFO: Bearer shh ${res.data}");
          allCertifiedProjectsModel =
              AllCertifiedProjectsModel.fromJson(res.data);
          debugPrint("INFO: Done");
          // loadingState = LoadingState.idle;
          _shouldReload = false;
          return true;
        } else {
          // loadingState = LoadingState.idle;
          _shouldReload = false;
          throw Error();
        }
      } on DioException catch (e) {
        // loadingState = LoadingState.idle;
        _shouldReload = false;
        ErrorService.handleErrors(e);
        return false;
      } catch (e) {
        // loadingState = LoadingState.idle;
        _shouldReload = false;
        ErrorService.handleErrors(e);
        return false;
      }
    }
    return true;
  }

  Future<bool> toGetQRData(String projectID, String nftID) async {
    try {
      loadingState = LoadingState.loading;
      debugPrint('shh To Get QR Code data from scan');
      final res = await allCertifiedServices.getNftsByScan(projectID, nftID);
      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer shh ${res.data}");
        qrDataModel = QRDataModel.fromJson(res.data);
        debugPrint("INFO: Done");
        loadingState = LoadingState.idle;
        return true;
      } else {
        _shouldReload = false;
        loadingState = LoadingState.idle;
        throw Error();
      }
    } on DioException catch (e) {
      _shouldReload = false;
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      _shouldReload = false;
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    }
  }
}
