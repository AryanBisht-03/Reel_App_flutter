import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player/video_player.dart';

class realTimeDB extends StatefulWidget {
  const realTimeDB({Key? key}) : super(key: key);

  @override
  State<realTimeDB> createState() => _realTimeDBState();
}

class _realTimeDBState extends State<realTimeDB> {
  late DatabaseReference _dbref;
  List<String> videourl = [];

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.reference();
    readDatabase();
    print("initState ");
  }

  //AspectRatio(aspectRatio: 16 / 9)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: videourl.map((url){
          return FullScreenVideo(videoUrl: url);
        }).toList(),
      ),
    );
  }

  void readDatabase()
  {
    List<String> videos = [];
    _dbref.child("Videos").once().then((DatabaseEvent event){
        DataSnapshot snapshot = event.snapshot;
        for(DataSnapshot datasnap in snapshot.children)
        {
          videos.add(datasnap.value.toString());
        }
        print(videos.toString());
        setState(() {
          videourl = videos;
        });
    });
  }


}

class FullScreenVideo extends StatefulWidget {
  String videoUrl;
  FullScreenVideo({required this.videoUrl});

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_){
        setState(() {
          controller.play();
          controller.setLooping(true);
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
