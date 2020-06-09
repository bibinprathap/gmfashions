import 'package:flutter/material.dart';

class DraggableBottomSheetWidget extends StatefulWidget {
  DraggableBottomSheetWidget({Key key}) : super(key: key);

  @override
  _DraggableBottomSheetWidgetState createState() =>
      _DraggableBottomSheetWidgetState();
}

class _DraggableBottomSheetWidgetState
    extends State<DraggableBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.1,
          maxChildSize: 0.8,
          builder: (BuildContext context, myscrollController) {
            return Container(
              color: Colors.tealAccent[200],
              child: ListView.builder(
                controller: myscrollController,
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(
                        'Dish',
                        style: TextStyle(color: Colors.black54),
                      ));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}