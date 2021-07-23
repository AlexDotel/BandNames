import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDialogWidget extends StatelessWidget {
  CupertinoDialogWidget(this.nameController, this.addingNewBand);
  final TextEditingController nameController;
  final addingNewBand;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Add New Band'),
      content: Column(
        children: [
          CupertinoTextField(
              keyboardType: TextInputType.text,
              placeholder: 'Band Name',
              controller: nameController),
          SizedBox(height: 10),
        ],
      ),
      actions: [
        CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'),
            onPressed: () => addingNewBand(nameController.text)),
        CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Dismiss'),
            onPressed: () => Navigator.pop(context)),
      ],
    );
  }
}
