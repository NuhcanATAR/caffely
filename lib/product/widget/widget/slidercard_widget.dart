import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:caffely/product/model/banner_model/banner_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderCardWidget extends StatelessWidget {
  const SliderCardWidget({
    super.key,
    required this.item,
  });

  final BannerModel item;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: item.img.toString(),
      imageBuilder: (context, imageProvider) {
        return GestureDetector(
          onTap: () async {
            if (item.isUrl == true) {
              if (item.url.isNotEmpty) {
                if (!await launchUrl(
                  Uri.parse(item.url),
                )) {
                  throw ServiceException(
                    'Could not launch',
                  );
                }
              } else {
                Logger().e('Url empty');
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  RadiusUtility.circularMediumValue,
                ),
              ),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              RadiusUtility.circularMediumValue,
            ),
          ),
          color: Colors.grey.withOpacity(0.4),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              RadiusUtility.circularMediumValue,
            ),
          ),
          color: Colors.grey.withOpacity(0.4),
        ),
      ),
    );
  }
}
