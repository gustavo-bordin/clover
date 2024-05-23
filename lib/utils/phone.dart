import 'package:intl_phone_field/countries.dart';

import 'package:clover/common/typedefs.dart';

ErrorString validatePhoneNumber(String phoneNumber, Country country) {
  if (phoneNumber.length < country.minLength) {
    return "Numero invalido; muito curto";
  }

  if (phoneNumber.length > country.maxLength) {
    return "Numero invalido; muito longo";
  }

  return null;
}

ErrorString validateOtpCode(String otpCode) {
  if (otpCode.length != 6) {
    return "Código de confirmação incompleto.";
  }

  return null;
}

String getCompleteNumber(String phoneNumber, Country country) {
  return "+${country.dialCode}$phoneNumber";
}
