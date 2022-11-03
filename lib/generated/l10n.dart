// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `帳號`
  String get account {
    return Intl.message(
      '帳號',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `複製`
  String get copy {
    return Intl.message(
      '複製',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `請輸入正確E-mail地址`
  String get email_hint {
    return Intl.message(
      '請輸入正確E-mail地址',
      name: 'email_hint',
      desc: '',
      args: [],
    );
  }

  /// `早安`
  String get greeting_morning {
    return Intl.message(
      '早安',
      name: 'greeting_morning',
      desc: '',
      args: [],
    );
  }

  /// `午安`
  String get greeting_afternoon {
    return Intl.message(
      '午安',
      name: 'greeting_afternoon',
      desc: '',
      args: [],
    );
  }

  /// `午安`
  String get greeting_evening {
    return Intl.message(
      '午安',
      name: 'greeting_evening',
      desc: '',
      args: [],
    );
  }

  /// `晚安`
  String get greeting_night {
    return Intl.message(
      '晚安',
      name: 'greeting_night',
      desc: '',
      args: [],
    );
  }

  /// `首頁`
  String get home {
    return Intl.message(
      '首頁',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `列表`
  String get list {
    return Intl.message(
      '列表',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `密碼`
  String get password {
    return Intl.message(
      '密碼',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `密碼不能小於6個字`
  String get password_hint {
    return Intl.message(
      '密碼不能小於6個字',
      name: 'password_hint',
      desc: '',
      args: [],
    );
  }

  /// `設定`
  String get settings {
    return Intl.message(
      '設定',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `登入`
  String get sign_in {
    return Intl.message(
      '登入',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `登出`
  String get sign_out {
    return Intl.message(
      '登出',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `註冊`
  String get sign_up {
    return Intl.message(
      '註冊',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(
          languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
