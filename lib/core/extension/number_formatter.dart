
extension UzPhoneNumberFormatter on String {
  String formatUzPhoneNumber() {
    // Remove any non-digit characters
    String cleaned = replaceAll(RegExp(r'\D'), '');

    // Check if the number starts with '998' (Uzbekistan country code)
    if (cleaned.startsWith('998')) {
      // Format as +998 (XX) XXX-XX-XX
      return '+${cleaned.substring(0, 3)} (${cleaned.substring(3, 5)}) ${cleaned.substring(5, 8)}-${cleaned.substring(8, 10)}-${cleaned.substring(10, 12)}';
    } else if (cleaned.length == 9) {
      // Format as (XX) XXX-XX-XX (Assuming it's already a local Uzbekistan number without country code)
      return '(${cleaned.substring(0, 2)}) ${cleaned.substring(2, 5)}-${cleaned.substring(5, 7)}-${cleaned.substring(7, 9)}';
    } else {
      // Return the original string if it doesn't match expected lengths
      return this;
    }
  }
}

