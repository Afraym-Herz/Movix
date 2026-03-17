import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/models/tv_series_model.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/core/services/secure_storage.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/widgets/small_show_card.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';
import 'package:movix/features/saved_movies/cubit/saved_shows_cubit.dart';
import 'package:movix/features/saved_movies/cubit/saved_shows_states.dart';

class SavedMovieScreen extends StatelessWidget {
  const SavedMovieScreen({super.key});

  static const routeName = '/saved-movies-screen';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SavedShowsCubit(getIt.get<SecureStorage>())..fetchSavedShows(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.lightRedBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'My Rated Shows',
              style: AppTextStyles.semiBold24(context).copyWith(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<SavedShowsCubit, SavedShowsStates>(
            builder: (context, state) {
              if (state is SavedShowsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SavedShowsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              if (state is SavedShowsSuccess) {
                if (state.ratedItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star_outline, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'No rated shows yet',
                          style: AppTextStyles.bold16(context).copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth > 500 ? 4 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: state.ratedItems.length,
                  itemBuilder: (context, index) {
                    final item = state.ratedItems[index];
                    final showJson = item['show'] as Map<String, dynamic>;
                    final userRating = (item['userRating'] as num).toDouble();
                    final isMovie = item['isMovie'] as bool;

                    final show = isMovie 
                        ? MovieModel.fromJson(showJson) 
                        : TVSeriesModel.fromJson(showJson);

                    return SmallShowCard(
                      show: show,
                      userRating: userRating,
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          isMovie ? MovieDetailsScreen.routeName : TVSeriesDetailsScreen.routeName,
                          arguments: show.id,
                        );
                        // Refresh after coming back in case rating changed
                        if (context.mounted) {
                          context.read<SavedShowsCubit>().fetchSavedShows();
                        }
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
