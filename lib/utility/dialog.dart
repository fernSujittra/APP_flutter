import 'package:flutter/material.dart';
import 'package:roi_et_swine/utility/my_style.dart';

Future<Null> normakDialog(BuildContext context, String string) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: ListTile(
              leading: Image.asset('image/logo_nb.png'),
              title: Text(
                'กรุณาตรวจสอบ',
                style: MyStyle().redboldStyle(),
              ),
              subtitle: Text(string),
            ),
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('OK'))
            ],
          ));
}
