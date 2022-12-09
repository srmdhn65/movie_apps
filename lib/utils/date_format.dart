import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatCustom {
  static tgl(DateTime date) {
    initializeDateFormatting();
    return DateFormat("MMM dd, yyyy", "en_US").format(date);
  }
}
