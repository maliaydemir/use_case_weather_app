import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  double get safeHeight =>
      mediaQuery.size.height -
      mediaQuery.padding.bottom -
      mediaQuery.padding.top;

  double get safeWidth =>
      mediaQuery.size.width -
      mediaQuery.padding.left -
      mediaQuery.padding.right;

  double get lowValue => height * 0.01;

  double get normalValue => height * 0.02;

  double get mediumValue => height * 0.04;

  double get highValue => height * 0.1;

  double w(double val) => width * val / 100;

  double h(double val) => height * val / 100;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);

  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);

  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);

  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);

  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);

  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);

  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);

  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);

  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);

  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => const Duration(milliseconds: 500);

  Duration get normalDuration => const Duration(seconds: 1);
}

extension WidgetExtension on Widget {
  Widget toVisible(bool val) => val ? this : Container();
}

extension AnimateRoute on NavigatorState {
  Future<dynamic> pushFromBottom(Widget newPage) {
    return Navigator.of(context).push(bottomRoute(newPage));
  }

  Route bottomRoute(newPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => newPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

extension DurationExt on Duration {
  String getString() {
    var seconds = inSeconds;
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    var mStr = minutes < 10 ? '0$minutes' : '$minutes';
    var sStr = seconds < 10 ? '0$seconds' : '$seconds';
    return '$mStr:$sStr';
  }
}

extension DurationExtNull on Duration? {
  String getString() {
    if (this == null) return '00:00';
    var seconds = this?.inSeconds ?? 0;
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    var mStr = minutes < 10 ? '0$minutes' : '$minutes';
    var sStr = seconds < 10 ? '0$seconds' : '$seconds';
    return '$mStr:$sStr';
  }
}

extension DateTimeExt on DateTime {
  String toFormat(String formatStr) {
    var dateFormat = DateFormat(formatStr, 'tr_TR');
    return dateFormat.format(this);
  }

  String toReadableDate() {
    var dateFormat = DateFormat('dd MMMM yyyy EEEE', 'tr_TR');
    return dateFormat.format(this);
  }

  String getAgo() {
    var ago = DateTime.now().difference(this);
    if (ago.inDays > 1) {
      return '$day/$month/$year';
    }
    if (ago.inHours > 0) return '${ago.inHours.toInt()}sa önce';
    if (ago.inMinutes > 0) {
      return '${ago.inMinutes.toInt()}dk önce';
    }
    if (ago.inSeconds > 0) {
      return '${ago.inSeconds.toInt()}sn önce';
    }
    return 'az önce';
  }
}

extension StringExt on String {
  String limit({int limitCount = 24}) {
    if (length < limitCount) return this;
    return '${substring(0, limitCount - 3)}..';
  }

  String reverse() {
    var tmp = '';
    var array = split('');
    for (int i = array.length - 1; i > -1; i--) {
      tmp += array[i];
    }
    return tmp;
  }

  String take(int count) {
    return substring(0, count);
  }

  String takeLast(int count) {
    return reverse().substring(0, count).reverse();
  }
  String capitalize() {
   var words=split(' ');
   var tmp="";
   for(var word in words ){
     tmp+="${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ";
   }
   return tmp.substring(0,tmp.length-1);
  }
}

extension DoubleExt on double {
  String limit({int max = 20}) {
    if (this > max) {
      return '+$max';
    } else {
      return toStringAsFixed(1);
    }
  }
}

extension TextExt on Text {
  Text fromJson(Map<String, dynamic> json) {
    var widget = Text(
      json['text'],
      textAlign: TextAlign.values[json['textAlign']],
      style: TextStyle(
          color: json['color'] == null ? null : Color(json['color']),
          fontSize: json['size']),
    );
    return widget;
  }
}

extension IterableExt on Iterable {
  double avarage() {
    if (every((element) => element is num)) {
      double result = 0;
      if (isEmpty) {
        return result;
      }
      return reduce((a, b) => a + b) / length;
    }
    return 0;
  }

  num min() {
    if (every((element) => element is num) && isNotEmpty) {
      num result = first;
      for (var e in this) {
        if (e < result) result = 0;
      }
      return result;
    }
    return 0;
  }
  num max() {
    if (every((element) => element is num) && isNotEmpty) {
      num result = first;
      for (var e in this) {
        if (e > result) result = 0;
      }
      return result;
    }
    return 0;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
