import 'package:flutter/material.dart';

import 'package:clover/common/snackbars.dart';

void handleFailure(BuildContext context, String failure) {
  clearSnackBars(context);
  showErrorSnackBar(context, failure);
}
