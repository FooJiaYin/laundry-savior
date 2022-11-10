/// Global service, MUST call `init()` when app first launched!
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api/auth_token.dart';
import '../models/api/response.dart';

class API {
  static late Dio instance;
  static String baseUrl = "";
  static late AuthToken? authToken;
  static final authenticated = StreamController<bool>.broadcast();
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    sendTimeout: 30000,
  );
  static Map<String, dynamic>? getHeader({bool useAuth = true}) {
    if (useAuth) {
      return {
        'Accept': 'application/json, text/plain, */*',
        "Authorization": 'Bearer ${authToken!.token}',
        "Content-Type": "application/json",
      };
    }
    return {
      'Accept': 'application/json, text/plain, */*',
      "Content-Type": "application/json",
    };
  }

  static Future init() async {
    final token = (await SharedPreferences.getInstance()).getString('AUTH_TOKEN');
    final refreshToken = (await SharedPreferences.getInstance()).getString('AUTH_TOKEN');
    if (token != null && refreshToken != null) {
      authToken = AuthToken(token, refreshToken);
    }
    instance = Dio(baseOptions);
    instance.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      final status = ResponseStatus.fromMap(response.data['status']);
      if (status.code == 0) {
        return handler.next(response);
      } else {
        handler.reject(
          DioError(
            error: status.description,
            response: response,
            requestOptions: RequestOptions(path: ""),
          ),
          true,
        );
      }
    },),);

    // onListen就要馬上廣播登入狀態，否則會視為未登入
    authenticated.onListen = () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final auth = sharedPreferences.getString('AUTH_TOKEN') != null &&
                   sharedPreferences.getString('API_REFRESH_TOKEN') != null;
      authenticated.add(auth);
    };
  }

  /// 驗證是否為登入狀態
  static Stream<bool> isAuthenticated() {
    return authenticated.stream;
  }

  // static Future signIn(Account account) async {
  //   final response = await instance.post(
  //     '/Auth/SignIn',
  //     data: account.toMap(),
  //     options: Options(headers: getHeader(useAuth: false)),
  //   );
  //   authToken = AuthToken.fromMap(response.data['data']);

  //   // 登入後存下token並廣播登入成功
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setString('AUTH_TOKEN', authToken!.token);
  //   await sharedPreferences.setString('API_REFRESH_TOKEN', authToken!.refreshToken);
  //   authenticated.add(true);
  // }

  // static Future signOut() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.remove('AUTH_TOKEN');
  //   await sharedPreferences.remove('API_REFRESH_TOKEN');
  //   authenticated.add(false);
  // }
  
  /// Example
  /* static Future<List<DataModel>> getData(DateTime date) async {
    final response = await instance.get(
      '/Exercise/Schedule',
      options: Options(headers: getHeader()),
      queryParameters: {
        "start": "0",
        "end": "100",
      }
    );
    List data = response.data['data'] as List;
    if (data.isEmpty) {
      return [];
    }
    return List<DataModel>.from(data.map((e) => DataModel.fromMap(e)));
  } */
}