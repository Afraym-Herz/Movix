import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movix/features/tv_series_details/models/tv_series_details_model.dart';
import 'package:movix/features/tv_series_details/cubits/rating_tv_serie/rating_tv_series_cubit.dart';

class RatingTVSeriesBuilderBar extends StatefulWidget {
  const RatingTVSeriesBuilderBar({super.key, required this.tvSeries});

  final TVSeriesDetailsModel tvSeries;

  @override
  State<RatingTVSeriesBuilderBar> createState() =>
      _RatingTVSeriesBuilderBarState();
}  

class _RatingTVSeriesBuilderBarState extends State<RatingTVSeriesBuilderBar> {
  @override
  void initState() {
    super.initState();
    context.read<RatingTVSeriesCubit>().fetchTVSeriesRating(widget.tvSeries.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingTVSeriesCubit, RatingTVSeriesStates>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage ||
          previous.isSubmitting != current.isSubmitting,
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
        return KeyedSubtree(
          key: ValueKey(state.userRating) ,
          child: RatingBar.builder(
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
                    tvSeries: widget.tvSeries,
                    rating: rating,
                  );
                },
          ),
        );
      },
    );
  }
}

