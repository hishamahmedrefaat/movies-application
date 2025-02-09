import 'package:flutter/material.dart';
import 'package:task_5/services/api_service.dart';
import 'package:task_5/model/TVshow.dart';
import 'package:task_5/screen/TVshowdetails.dart';

class TvShowListPage extends StatefulWidget {
  const TvShowListPage({super.key});

  @override
  State<TvShowListPage> createState() => _TvShowListPageState();
}

class _TvShowListPageState extends State<TvShowListPage> {
  late Future<List<TvShow>> tvShows;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    tvShows = ApiService().getTvShows(currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        getMoreTvShows();
      } else if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        getBeforeTvShows();
      }
    });
  }

  void getMoreTvShows() {
    setState(() {
      currentPage++;
      tvShows = ApiService().getTvShows(currentPage);
    });
  }

  void getBeforeTvShows() {
    setState(() {
      if (currentPage > 1) {
        currentPage--;
        tvShows = ApiService().getTvShows(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('TV Show List Page'),
      ),
      body: FutureBuilder<List<TvShow>>(
        future: tvShows,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              color: Colors.pink,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Exception ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No TV Shows available'),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final tvShow = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TvShowDetailsPage(tvShow: tvShow),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${tvShow.posterPath}'),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tvShow.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            tvShow.overview,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}