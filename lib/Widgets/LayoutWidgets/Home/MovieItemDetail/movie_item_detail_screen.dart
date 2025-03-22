import 'dart:ui';

import 'package:cinemax/Shared/components.dart';
import 'package:cinemax/Shared/constants.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieItemDetailScreen extends StatefulWidget {
  final int id;
  final String title;
  final String posterImage;
  final String rate;
  final String year;
  final String overview;
  final String popularity;
  final String runTime;
  final String genre;
  final String trailerURL;
  final List<String> genres;
  final List<Map<String, String>> cast;

  const MovieItemDetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.trailerURL,
    required this.genre,
    required this.genres,
    required this.cast,
    required this.runTime,
    required this.posterImage,
    required this.rate,
    required this.year,
    required this.popularity,
    required this.overview,
  });

  @override
  State<MovieItemDetailScreen> createState() => _MovieItemDetailScreenState();
}

class _MovieItemDetailScreenState extends State<MovieItemDetailScreen> {
  bool isExpanded = false;
  late YoutubePlayerController youtubePlayerController;
  bool isTrailerVisible = false;
  @override
  void initState() {
    super.initState();
    String? videoId = YoutubePlayer.convertUrlToId(widget.trailerURL);
    youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId ?? "",
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ));
  }

  void _showTrailer() {
    setState(() {
      isTrailerVisible = true;
      youtubePlayerController.play();
    });
  }

  void _hideTrailer() {
    setState(() {
      isTrailerVisible = false;
      youtubePlayerController.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Center(
                                    child: Image(
                                        width: double.infinity,
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500${widget.posterImage}"))),
                              ),
                              Positioned.fill(
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 8, sigmaY: 8),
                                      child: Container(
                                        // ignore: deprecated_member_use
                                        color: Colors.black.withOpacity(0.2),
                                      ))),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                                child: Image(
                                    height: 320,
                                    width: double.infinity,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500${widget.posterImage}"))),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Image.asset("assets/images/Back.png")),
                            ),
                            Spacer(),
                            Text(
                              widget.title.length > 18
                                  ? "${widget.title.substring(0, 18)}..."
                                  : widget.title,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                            Spacer(),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[900],
                              child: Icon(Icons.favorite, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, bottom: 50),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          color: Colors.grey[300],
                        ),
                        Text(
                          " ${widget.year}",
                          style:
                              TextStyle(color: Colors.grey[300], fontSize: 16),
                        ),
                        Text(
                          "  |  ",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        Icon(
                          Icons.access_time,
                          color: Colors.grey[300],
                        ),
                        Text(
                          " ${widget.runTime} min",
                          style:
                              TextStyle(color: Colors.grey[300], fontSize: 16),
                        ),
                        Text(
                          "  |  ",
                          style: TextStyle(color: Colors.grey[300]),
                        ),
                        Icon(
                          Icons.movie,
                          color: Colors.grey[300],
                        ),
                        Text(
                          widget.genre.length > 8
                              ? "${widget.genre.substring(0, 8)}..."
                              : widget.genre,
                          style:
                              TextStyle(color: Colors.grey[300], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150, bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Text(
                          widget.rate,
                          style: TextStyle(color: Colors.orange),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: buildDefaultButton(
                          color: primaryColor,
                          text: "Play Trailer",
                          onPressed: () {
                            _showTrailer();
                          },
                          height: 50,
                          width: 150,
                        ),
                      ),
                    ),

                    // Extract movie IDs from watchlistDetails
                    if (!cinemaxCubit
                        .get(context)
                        .watchlistDetails
                        .map((movie) => movie.id)
                        .contains(widget.id))
                      Spacer(),

                    if (!cinemaxCubit
                        .get(context)
                        .watchlistDetails
                        .map((movie) => movie.id)
                        .contains(widget.id))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: buildDefaultButton(
                            color: Colors.orange[800],
                            text: "Add to Watchlist",
                            onPressed: () {
                              cinemaxCubit
                                  .get(context)
                                  .addToWatchlist(id: widget.id);
                              cinemaxCubit
                                  .get(context)
                                  .watchlistDetails
                                  .clear();
                              cinemaxCubit.get(context).getWatchlistDetails();
                              setState(() {});
                            },
                            height: 50,
                            width: 150,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              if (isTrailerVisible)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Positioned.fill(
                    child: Container(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.9), // Dark overlay
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 🎥 YouTube Player
                          YoutubePlayer(
                            controller: youtubePlayerController,
                            showVideoProgressIndicator: true,
                          ),

                          SizedBox(height: 20),

                          // ❌ Close Button
                          ElevatedButton(
                            onPressed: _hideTrailer,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Text(
                              "Close Trailer",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Story Line",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
              ),
              //const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.overview,
                      maxLines: isExpanded ? null : 2, // Show 2 lines initially
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded; // Toggle state on tap
                    });
                  },
                  child: Text(
                    isExpanded ? "Show Less" : "More",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  "Cast and Crew",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: primaryColor,
                                backgroundImage: widget.cast[index]["image"] !=
                                            null &&
                                        widget.cast[index]["image"]!.isNotEmpty
                                    ? NetworkImage(widget.cast[index]["image"]!)
                                    : AssetImage(
                                            "assets/images/placeHolder.png")
                                        as ImageProvider,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.cast[index]["name"]!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.cast[index]["role"]!,
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      separatorBuilder: (context, index) => Container(
                            width: 20,
                          ),
                      itemCount: widget.cast.length),
                ),
              ),
              if (widget.genres.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        "Genres",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.genres[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            separatorBuilder: (context, index) => Container(
                                  width: 20,
                                ),
                            itemCount: widget.genres.length),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
