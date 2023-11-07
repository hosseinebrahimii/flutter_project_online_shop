import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_bloc.dart';
import 'package:flutter_project_online_shop/bloc/category_page/category_page_state.dart';
import 'package:flutter_project_online_shop/constants/colors.dart';
import 'package:flutter_project_online_shop/widgets/cached_image.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 44,
                  right: 44,
                  bottom: 32,
                  top: 20,
                ),
                height: 46,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset('assets/images/icon_apple_blue.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Text(
                        'دسته بندی',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: CustomColors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              sliver: _getGridWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGridWidget() {
    return BlocBuilder<CategoryPageBloc, CategoryPageState>(
      builder: (context, state) {
        if (state is CategoryPageInitState) {
          return _getSliverGrid(
            childCount: 8,
            builder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const CircularProgressIndicator(),
              );
            },
          );
        }

        if (state is CategoryPageLoadingState) {
          return _getSliverGrid(
            childCount: 8,
            builder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const CircularProgressIndicator(),
              );
            },
          );
        }

        if (state is CategoryPageResponseState) {
          return state.response.fold(
            (error) {
              return _getSliverGrid(
                childCount: 8,
                builder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(error),
                  );
                },
              );
            },
            (list) {
              return _getSliverGrid(
                childCount: 8,
                builder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: CachedImage(
                        imageUrl: list[index]
                            .getImageUrl() //?? 'http://startflutter.ir/api/files/f5pm8kntkfuwbn1/2t5787n46p0v2z1/rectangle_69_oDxUKZrFve.png',
                        ),
                  );
                },
              );
            },
          );
        }
        return const Text('Something Happened');
      },
    );
  }

  SliverGrid _getSliverGrid(
      {required int childCount, required Widget? Function(BuildContext context, int index) builder}) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: childCount,
        builder,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
    );
  }
}
