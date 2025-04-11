import 'package:cinemax/Shared/components/movie_item.dart';
import 'package:cinemax/Shared/cubit/cubit.dart';
import 'package:cinemax/Shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MostPopularScreen extends StatelessWidget {
  const MostPopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cinemaxCubit, cinemaxStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image(image: AssetImage("assets/images/Back.png"))),
              title: Text(
                "Most Popular",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 650,
                  child: GridView.builder(
                    itemCount:
                        cinemaxCubit.get(context).popularMoviesList.length,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 320,
                        maxCrossAxisExtent: 280,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) => movieItemMostPopular(
                        cinemaxCubit.get(context).popularMoviesList[index],
                        context),
                  ),
                )
              ],
            ),
          );
        });
  }
}
