import 'package:flutter/material.dart';

class PaintingSize extends StatefulWidget {
  final List? paintingSizes;
  final Function(String)? onSelected;
  PaintingSize ({this.paintingSizes, this.onSelected});

  @override
  State<PaintingSize> createState() => _PaintingSizeState();
}

class _PaintingSizeState extends State<PaintingSize> {

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i <widget.paintingSizes!.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected!("${widget.paintingSizes![i]}");
                setState ((){
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selected == i ? Theme.of(context).accentColor : Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text("${widget.paintingSizes![i]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _selected == i ? Colors.white : Colors.black,
                  fontSize: 16.0,
                ),),
              ),
            )
        ],
      ),
    );
  }
}
