import 'dart:async';

import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_advanced_networkimage/src/utils.dart';

void main() {
  group('Download Test', () {
    test('=> good url', () async {
      var url = 'https://flutter.dev/images/flutter-logo-sharing.png';
      var result = (await http.get(Uri.parse(url))).bodyBytes;

      expect(
          await loadFromRemote(url, null, 5, const Duration(milliseconds: 100),
              1.0, const Duration(seconds: 5), null, null,
              printError: true),
          result);

      url =
          'https://flutter.dev/assets/shared/flutter/logo/square-5f9330e447c2003f6dc382bb753ad4daedf0d58aef2251a976095823ede2aea6.svg';
      result = (await http.get(Uri.parse(url))).bodyBytes;

      expect(
          await loadFromRemote(url, null, 5, const Duration(milliseconds: 100),
              1.0, const Duration(seconds: 5), null, null,
              printError: true),
          result);
    });
    test('=> good url with progress', () async {
      var url = 'this is a label';
      var realUrl = 'https://flutter.dev/images/flutter-logo-sharing.png';
      var result = (await http.get(Uri.parse(realUrl))).bodyBytes;

      expect(
          await loadFromRemote(
            url,
            null,
            5,
            const Duration(milliseconds: 100),
            1.0,
            const Duration(seconds: 5),
            (_, v) => print(v),
            () => Future.value(realUrl),
            printError: true,
          ),
          result);

      url = 'this is another label';
      realUrl =
          'https://flutter.dev/assets/shared/flutter/logo/square-5f9330e447c2003f6dc382bb753ad4daedf0d58aef2251a976095823ede2aea6.svg';
      result = (await http.get(Uri.parse(realUrl))).bodyBytes;

      expect(
          await loadFromRemote(
            url,
            null,
            5,
            const Duration(milliseconds: 100),
            1.0,
            const Duration(seconds: 5),
            (_, v) => print(v),
            () => Future.value(realUrl),
            printError: true,
          ),
          result);
    });
    test('=> bad url', () async {
      var url =
          'https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png';

      expect(
          await loadFromRemote(url, null, 0, const Duration(milliseconds: 100),
              1.0, const Duration(seconds: 5), null, null,
              printError: true),
          null);
    });
    test('=> not a url', () async {
      var url = '/GitHub-Marks.png';

      expect(
          await loadFromRemote(url, null, 0, const Duration(milliseconds: 100),
              1.0, const Duration(seconds: 5), null, null,
              printError: true),
          null);
    });
  });
}
