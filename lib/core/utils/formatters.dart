import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Formatters {
  static final priceFormatter = MaskTextInputFormatter(
      mask: '## ### ### SUM', filter: {"#": RegExp(r'[0-9]')});
  static final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
