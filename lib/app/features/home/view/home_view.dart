import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitterclone/app/features/tweet/views/create_tweet_view.dart';
import 'package:twitterclone/app/theme/pallete.dart';
import 'package:twitterclone/app/widgets/default_appbar.dart';
import 'package:twitterclone/data/constants/assets_constans.dart';
import 'package:twitterclone/data/constants/ui_constants.dart';

class HomeView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const HomeView(),
  );
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _page = 0;
  final appBar = DefaultAppBar.appBar();

  void onPageChange(int index) {
    setState(() => _page = index);
  }

  void navigateToCreateTweetView() {
    Navigator.push(context, CreateTweetView.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children: UIConstants.homePages,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
        ),
        onPressed: navigateToCreateTweetView,
        child: SvgPicture.asset(
          AssetsConstants.twitterLogo,
          colorFilter: const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 0 ? AssetsConstants.homeFilledIcon : AssetsConstants.homeOutlinedIcon,
              colorFilter: const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              colorFilter: const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 2 ? AssetsConstants.notifFilledIcon : AssetsConstants.notifOutlinedIcon,
              colorFilter: const ColorFilter.mode(Pallete.whiteColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}