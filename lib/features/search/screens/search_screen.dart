import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/services/get_it_services.dart';
import 'package:movix/features/search/cubit/search_cubit.dart';
import 'package:movix/features/search/repos/search_repo.dart';
import 'package:movix/features/search/screens/widgets/search_screen_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const routeName = '/search-screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        getIt.get<SearchRepo>(),
      ),
      child: const SearchScreenBody(),
    );
  }
}
