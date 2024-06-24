import 'package:bible_studies_wing/src/data/network/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/styles_manager.dart';
import '../../../resources/values_manager.dart';

class CustomListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final VoidCallback callback;

  const CustomListTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.1,
      width: context.height * 0.8,
      padding: const EdgeInsets.all(Spacing.s10),
      decoration:
          StyleManager.boxDecoration.copyWith(borderRadius: BorderRadius.circular(Spacing.s28)),
      child: Row(
        children: [
          Container(
            width: Spacing.s70,
            height: Spacing.s70,
            decoration: StyleManager.boxDecoration.copyWith(
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () =>
                  AppService.viewPicture(CachedNetworkImage(imageUrl: imageUrl), title, imageUrl),
              child: Hero(
                tag: imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, progress) => Center(
                      child: CircularProgressIndicator.adaptive(
                        value: progress.progress,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: Spacing.s10,
          ),
          GestureDetector(
            onTap: callback,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  subTitle,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
