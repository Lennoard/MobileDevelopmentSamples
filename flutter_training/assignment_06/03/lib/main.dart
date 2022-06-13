import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Slider', style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(child: SliderPage()),
      ),
    ),
  );
}

class SliderPage extends StatefulWidget {
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  static const String KEY_PREF_LIKE_IDS = 'likedIds';
  int currentImageId = 0;
  List<String> imageAssets =
      List.generate(4, (index) => 'images/img$index.jpg');
  Set<int> likedIds = Set();

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: sliderImageCard(),
          )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FloatingActionButton(
                    child: Icon(Icons.chevron_left),
                    onPressed: previous,
                  ),
                ),
                Expanded(
                  child: FloatingActionButton(
                    backgroundColor: Colors.red.shade50,
                    child: Icon(Icons.favorite,
                        color: likedIds.contains(currentImageId)
                            ? Colors.red.shade800
                            : Colors.black38),
                    onPressed: toggleLike,
                  ),
                ),
                Expanded(
                  child: FloatingActionButton(
                    child: Icon(Icons.chevron_right),
                    onPressed: next,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList(KEY_PREF_LIKE_IDS);
    if (items == null) return;

    setState(() {
      likedIds.addAll(items.map((e) => int.parse(e)));
    });
  }

  void next() {
    setState(() {
      if (currentImageId == imageAssets.length) return;
      currentImageId++;
    });
  }

  void previous() {
    setState(() {
      if (currentImageId == 0) return;
      currentImageId--;
    });
  }

  Future<void> toggleLike() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bool canAdd = likedIds.add(currentImageId);
      if (!canAdd) {
        likedIds.remove(currentImageId);
      }

      prefs.setStringList(
          KEY_PREF_LIKE_IDS, likedIds.map((e) => e.toString()).toList());
    });
  }

  Card sliderImageCard() {
    BorderRadius border = BorderRadius.circular(20);

    return Card(
      child: ClipRRect(
        borderRadius: border,
        child: Image.asset('images/img$currentImageId.jpg', fit: BoxFit.cover),
      ),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: border),
    );
  }
}
