import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/models/movie_model.dart';
import 'package:movix/core/models/show_model.dart';
import 'package:movix/core/models/tv_series_model.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/features/movie_details/screens/movie_details_screen.dart';
import 'package:movix/features/tv_series_details/screens/tv_series_details_screen.dart';
import 'package:movix/features/search/cubit/search_cubit.dart';
import 'package:movix/features/search/screens/widgets/search_separated_screens.dart' hide SearchLoadedView;
import 'package:movix/features/search/screens/widgets/search_loaded_view.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  // ✅ Controller must be in StatefulWidget to control it
  final SearchController searchController = SearchController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.openView();
    });
  }

  

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchCubit = context.read<SearchCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: SearchAnchor.bar(
          searchController: searchController,
          viewBackgroundColor: AppColors.lightRedBackground,
          onChanged: (value) {
            searchCubit.searchMethod(showTitle: value);
          },
          viewLeading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back) , color: Colors.white,) ,
          dividerColor: const Color(0xFF2A2A2A),
          suggestionsBuilder: (context, controller) {
            return [
              BlocBuilder<SearchCubit, SearchCubitState>(
                bloc: searchCubit,
                builder: (context, state) {
                  return switch (state) {
                    SearchCubitInitial() => const SearchInitialView(),
                    SearchCubitLoading() => const SearchLoadingView(),
                    SearchCubitSuccess() => SearchLoadedView(
                        results: state.shows!,
                        onTap: (show) {
                          controller.closeView('');
                          _navigate(context, show);
                        },
                      ),
                    SearchCubitEmpty() => SearchEmptyView(
                        query: controller.text,
                      ),
                    SearchCubitFailure() => SearchFailureView(
                        message: state.errMessage,
                      ),
                    SearchCubitState() => const SizedBox.shrink(),
                  };
                },
              ),
            ];
          },
        ),
      ),
    );
    
  }

  void _navigate(BuildContext context, ShowModel show) {
    if (show is MovieModel) {
      Navigator.pushNamed(
        context,
        MovieDetailsScreen.routeName,
        arguments: show.id,
      );
    } else if (show is TVSeriesModel) {
      Navigator.pushNamed(
        context,
        TVSeriesDetailsScreen.routeName,
        arguments: show.id,
      );
    }
  }
  
}
