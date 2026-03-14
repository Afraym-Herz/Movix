import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movix/features/tv_series_details/cubits/rating_tv_serie/rating_tv_series_cubit.dart';

class RatingTVSeriesBuilderBar extends StatefulWidget {
  const RatingTVSeriesBuilderBar({super.key, required this.tvSeriesId});

  final int tvSeriesId;

  @override
  State<RatingTVSeriesBuilderBar> createState() =>
      _RatingTVSeriesBuilderBarState();
}

class _RatingTVSeriesBuilderBarState extends State<RatingTVSeriesBuilderBar> {
  @override
  void initState() {
    context.read<RatingTVSeriesCubit>().fetchTVSeriesRating(widget.tvSeriesId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingTVSeriesCubit, RatingTVSeriesStates>(
      listener: (context, state) {
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Submitting...')));
        }

        if (state.successMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.successMessage!)));
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      buildWhen: (previous, current) =>
          previous.userRating != current.userRating ||
          previous.isSubmitting != current.isSubmitting,
      builder: (context, state) {
        return RatingBar.builder(
          initialRating: state.userRating ,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          unratedColor: Colors.grey,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            context.read<RatingTVSeriesCubit>().submitRating(
              tvSeriesId: widget.tvSeriesId,
              rating: rating,
            );
          },
        );
      },
    );
  }
}

