import 'package:intl/intl.dart';

extension CustomDateFormat on DateTime {
  String get onlyDateFormat {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return dateFormat.format(this);
  }
}

extension CustomTimeFormat on DateTime {
  String get onlyTimeFormat {
    final dateFormat = DateFormat('HH:mm');

    return dateFormat.format(this);
  }
}

extension CustomDateAndTimeFormat on DateTime {
  String get dateAndTimeFormat {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return dateFormat.format(this);
  }
}
