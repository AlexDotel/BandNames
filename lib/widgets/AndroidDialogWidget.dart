import 'package:flutter/material.dart';

class AndroidDialogWidget extends StatelessWidget {
  AndroidDialogWidget(this.nameController, this.addingNewBand);
  final TextEditingController nameController;
  final addingNewBand;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Band'),
      content: Wrap(
        children: [
          Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Band Name'),
                controller: nameController,
              ),
            ],
          ),
        ],
      ),
      actions: [
        MaterialButton(
            child: Text('Add'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => addingNewBand(nameController.text))
      ],
    );
  }
}
