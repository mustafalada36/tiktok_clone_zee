import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone_zee/video_item.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final videos = snapshot.data!.docs;

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final data = videos[index].data() as Map<String, dynamic>;
              return VideoItem(
                videoUrl: data['url'],
                username: data['username'],
                caption: data['caption'],
              );
            },
          );
        },
      ),
    );
  }
}
