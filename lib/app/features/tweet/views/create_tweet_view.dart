import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitterclone/app/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/app/theme/pallete.dart';
import 'package:twitterclone/app/widgets/deafult_loading.dart';
import 'package:twitterclone/app/widgets/default_button.dart';
import 'package:twitterclone/data/constants/assets_constans.dart';

class CreateTweetView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const CreateTweetView(),
  );
  const CreateTweetView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateTweetViewState();
}

class _CreateTweetViewState extends ConsumerState<CreateTweetView> {

  final TextEditingController tweetController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    tweetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDataProvider).value;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close, 
            size: 30,
          ),
        ),
        actions: <Widget> [
          DefaultButton(
            onPressed: () {}, 
            label: 'Tweet', 
            backgroundColor: Pallete.blueColor, 
            labelColor: Pallete.whiteColor,
          ),
        ],
      ),
      body: user == null ? const DefaultLoading() : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Row(
                children: <Widget> [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.profilePicture,
                    ),
                    radius: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: tweetController,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'What\'s happning', 
                        hintStyle: TextStyle(
                          color: Pallete.greyColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35, left: 25, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget> [
              SvgPicture.asset(AssetsConstants.galleryIcon),
              SvgPicture.asset(AssetsConstants.gifIcon),
              SvgPicture.asset(AssetsConstants.emojiIcon),
            ],
          ),
        ),
      ),
    );
  }
}