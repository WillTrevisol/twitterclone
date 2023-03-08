import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitterclone/app/features/auth/controller/auth_controller.dart';
import 'package:twitterclone/app/features/tweet/controller/tweet_controller.dart';
import 'package:twitterclone/app/theme/pallete.dart';
import 'package:twitterclone/app/widgets/deafult_loading.dart';
import 'package:twitterclone/app/widgets/default_button.dart';
import 'package:twitterclone/app/widgets/default_circle_avatar.dart';
import 'package:twitterclone/data/constants/assets_constans.dart';
import 'package:twitterclone/data/core/utils.dart';

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
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetController.dispose();
  }

  void onPickImages() async {
    images = await pickImages();
    setState((){});
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier)
      .shareTweet(context: context, images: images, text: tweetController.text, repliedTo:'');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDataProvider).value;
    final isLoading = ref.watch(tweetControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => isLoading ? null : Navigator.pop(context),
          icon: const Icon(
            Icons.close, 
            size: 30,
          ),
        ),
        actions: <Widget> [
          DefaultButton(
            onPressed: isLoading ? null : shareTweet,
            label: 'Tweet', 
            backgroundColor: Pallete.blueColor, 
            labelColor: Pallete.whiteColor,
          ),
        ],
      ),
      body: isLoading || user == null ? const DefaultLoading() : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              Row(
                children: <Widget> [
                  DefaultCircleAvatar(
                    profilePicure: user.profilePicture, 
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
              if (images.isNotEmpty)
                CarouselSlider(
                  items: images.map((file) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.file(file),
                      );
                    } ,
                  ).toList(), 
                  options: CarouselOptions(
                    height: 400,
                    enableInfiniteScroll: false,
                  ),
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
              GestureDetector(
                onTap: onPickImages,
                child: SvgPicture.asset(AssetsConstants.galleryIcon),
              ),
              SvgPicture.asset(AssetsConstants.gifIcon),
              SvgPicture.asset(AssetsConstants.emojiIcon),
            ],
          ),
        ),
      ),
    );
  }
}