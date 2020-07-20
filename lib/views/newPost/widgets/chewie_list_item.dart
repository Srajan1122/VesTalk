import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final double aspectRatio;
  final bool looping;

  ChewieListItem({
    @required this.videoPlayerController,
    @required this.aspectRatio,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;
  String name;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 15/16,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
        controller: _chewieController,
      );

  }

  @override
  void setState(fn) {
    dispose();
    super.setState(fn);
  }

  @override
  void dispose() {
    debugPrint(
        "------------------------------------------------------------------------------------------------------>_controller");
    // Ensure disposing of the VideoPlayerController to free up resources.
    //_initializeVideoPlayerFuture = null;
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
