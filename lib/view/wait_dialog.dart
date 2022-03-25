import 'package:flutter/material.dart';

class WaitDialog extends StatelessWidget {
  const WaitDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Please Wait')),
      content:
          IntrinsicHeight(child: Center(child: CircularProgressIndicator())),
    );
  }
}
