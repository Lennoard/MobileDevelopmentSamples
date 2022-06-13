import 'package:flutter/material.dart';

class SliderImage extends StatefulWidget {
  final int id;

  SliderImage({Key? key, required this.id}) : super(key: key);

  @override
  State<SliderImage> createState() => _SliderImageState(id);
}

class _SliderImageState extends State<SliderImage> {
  int _id;
  _SliderImageState(this._id);


  @override
  Widget build(BuildContext context) {
    BorderRadius border = BorderRadius.circular(20);

    return Card(
      child: ClipRRect(
        borderRadius: border,
        child: Image.asset('images/img$_id.jpg'),
      ),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: border),
    );
  }
}
