import 'package:flutter/material.dart';
import '../tokens/typography_tokens.dart';

class MinyTypography extends ThemeExtension<MinyTypography> {
  final TextStyle titleRegular;
  final TextStyle titleBold;
  final TextStyle headingSmallRegular;
  final TextStyle headingSmallMeduim;
  final TextStyle headingLargeBold;
  final TextStyle lableRegular;
  final TextStyle lableBold;
  final TextStyle bodyRegular;
  final TextStyle bodyBold;
  final TextStyle caption;
  final TextStyle quote;

  MinyTypography({
    TextStyle? titleRegular,
    TextStyle? titleBold,
    TextStyle? headingSmallRegular,
    TextStyle? headingSmallMeduim,
    TextStyle? headingLargeBold,
    TextStyle? lableRegular,
    TextStyle? lableBold,
    TextStyle? bodyRegular,
    TextStyle? bodyBold,
    TextStyle? caption,
    TextStyle? quote,
  })  : titleRegular = titleRegular ?? TypographyTokens.titleRegular,
        titleBold = titleBold ?? TypographyTokens.titleBold,
        headingSmallRegular =
            headingSmallRegular ?? TypographyTokens.headingSmallRegular,
        headingSmallMeduim =
            headingSmallMeduim ?? TypographyTokens.headingSmallMeduim,
        headingLargeBold =
            headingLargeBold ?? TypographyTokens.headingLargeBold,
        lableRegular = lableRegular ?? TypographyTokens.lableRegular,
        lableBold = lableBold ?? TypographyTokens.lableBold,
        bodyRegular = bodyRegular ?? TypographyTokens.bodyRegular,
        bodyBold = bodyBold ?? TypographyTokens.bodyBold,
        caption = caption ?? TypographyTokens.caption,
        quote = quote ?? TypographyTokens.quote;

  @override
  ThemeExtension<MinyTypography> copyWith({
    final TextStyle? titleRegular,
    final TextStyle? titleBold,
    final TextStyle? headingSmallRegular,
    final TextStyle? headingSmallMeduim,
    final TextStyle? headingLargeBold,
    final TextStyle? lableRegular,
    final TextStyle? lableBold,
    final TextStyle? bodyRegular,
    final TextStyle? bodyBold,
    final TextStyle? bodySmall,
    final TextStyle? caption,
    final TextStyle? quote,
  }) =>
      MinyTypography(
        titleRegular: titleRegular ?? this.titleRegular,
        titleBold: titleBold ?? this.titleBold,
        headingSmallRegular: headingSmallRegular ?? this.headingSmallRegular,
        headingSmallMeduim: headingSmallMeduim ?? this.headingSmallMeduim,
        headingLargeBold: headingLargeBold ?? this.headingLargeBold,
        lableRegular: lableRegular ?? this.lableRegular,
        lableBold: lableBold ?? this.lableBold,
        bodyRegular: bodyRegular ?? this.bodyRegular,
        bodyBold: bodyBold ?? this.bodyBold,
        caption: caption ?? this.caption,
        quote: quote ?? this.quote,
      );

  @override
  ThemeExtension<MinyTypography> lerp(
    final ThemeExtension<MinyTypography>? other,
    final double t,
  ) {
    if (other is! MinyTypography) {
      return this;
    }
    return MinyTypography(
      titleRegular:
          TextStyle.lerp(titleRegular, other.titleRegular, t) ?? titleRegular,
      titleBold: TextStyle.lerp(titleBold, other.titleBold, t) ?? titleBold,
      headingSmallRegular:
          TextStyle.lerp(headingSmallRegular, other.headingSmallRegular, t) ??
              headingSmallRegular,
      headingSmallMeduim:
          TextStyle.lerp(headingSmallMeduim, other.headingSmallMeduim, t) ??
              headingSmallMeduim,
      headingLargeBold:
          TextStyle.lerp(headingLargeBold, other.headingLargeBold, t) ??
              headingLargeBold,
      lableRegular:
          TextStyle.lerp(lableRegular, other.lableRegular, t) ?? lableRegular,
      lableBold: TextStyle.lerp(lableBold, other.lableBold, t) ?? lableBold,
      bodyRegular:
          TextStyle.lerp(bodyRegular, other.bodyRegular, t) ?? bodyRegular,
      bodyBold: TextStyle.lerp(bodyBold, other.bodyBold, t) ?? bodyBold,
      caption: TextStyle.lerp(caption, other.caption, t) ?? caption,
      quote: TextStyle.lerp(quote, other.quote, t) ?? quote,
    );
  }
}
