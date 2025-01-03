// ignore_for_file: deprecated_member_use

import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../util/base_utility.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.searchText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String searchText;
  final Function(String)? onChanged;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends BaseState<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BaseUtility.horizontal(
        BaseUtility.paddingSmallValue,
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: BaseUtility.all(
              BaseUtility.paddingNormalValue,
            ),
            child: AppIcons.searchOutline.toSvgImg(
              Theme.of(context).colorScheme.onSurface,
              BaseUtility.iconMediumSize,
              BaseUtility.iconMediumSize,
            ),
          ),
          labelText: widget.searchText,
          labelStyle: context.general.textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: BaseUtility.paddingNormalValue,
            vertical: BaseUtility.paddingNormalValue,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
