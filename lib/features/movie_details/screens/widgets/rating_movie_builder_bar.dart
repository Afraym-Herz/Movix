import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movix/features/movie_details/cubits/rating_movie_cubit/rating_movie_cubit.dart';

class RatingMovieBuilderBar extends StatefulWidget {
  const RatingMovieBuilderBar({super.key, required this.movieId});

  final int movieId;

  @override
  State<RatingMovieBuilderBar> createState() => _RatingMovieBuilderBarState();
}

class _RatingMovieBuilderBarState extends State<RatingMovieBuilderBar> {
 

  @override
  void initState() {
    context.read<RatingMovieCubit>().getMovieRating(widget.movieId);
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingMovieCubit, RatingMovieState>(
      listenWhen: (previous, current) =>
      previous.errorMessage != current.errorMessage ||
      previous.successMessage != current.successMessage ||
      previous.isSubmitting != current.isSubmitting,
  listener: (context, state) {
    if (state.isSubmitting) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Submitting...')),
        );
    }

    if (state.successMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(state.successMessage!)),
        );
      context.read<RatingMovieCubit>().clearMessages();
    }

    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      context.read<RatingMovieCubit>().clearMessages();
    }
  },
       buildWhen: (previous, current) =>
          previous.userRating != current.userRating ||
          previous.isSubmitting != current.isSubmitting,
      builder: (context, state) {
        return RatingBar.builder(
          initialRating: state.userRating / 2 == 0 ? 3 : state.userRating/2 ,
          minRating: 1,
          direction: Axis.horizontal, 
          allowHalfRating: true,
          itemCount: 5,
          unratedColor: Colors.grey,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            context.read<RatingMovieCubit>().submitRating(
              widget.movieId,
              rating,
            );
          },
        );
      },
    );
  }

}
