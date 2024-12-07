import 'package:flutter/material.dart';
import '../tokens/typography_tokens.dart';

class MinyTypography extends ThemeExtension<MinyTypography> {
  final TextStyle titleRegular;
  final TextStyle titleBold;
  final TextStyle headingSmallRegular;
  final TextStyle headingSmallMedium;
  final TextStyle headingLargeBold;
  final TextStyle labelRegular;
  final TextStyle labelBold;
  final TextStyle bodyRegular;
  final TextStyle bodyBold;
  final TextStyle caption;
  final TextStyle quote;

  MinyTypography({
    TextStyle? titleRegular,
    TextStyle? titleBold,
    TextStyle? headingSmallRegular,
    TextStyle? headingSmallMedium,
    TextStyle? headingLargeBold,
    TextStyle? labelRegular,
    TextStyle? labelBold,
    TextStyle? bodyRegular,
    TextStyle? bodyBold,
    TextStyle? caption,
    TextStyle? quote,
  })  : titleRegular = titleRegular ?? TypographyTokens.titleRegular,
        titleBold = titleBold ?? TypographyTokens.titleBold,
        headingSmallRegular =
            headingSmallRegular ?? TypographyTokens.headingSmallRegular,
        headingSmallMedium =
            headingSmallMedium ?? TypographyTokens.headingSmallMedium,
        headingLargeBold =
            headingLargeBold ?? TypographyTokens.headingLargeBold,
        labelRegular = labelRegular ?? TypographyTokens.labelRegular,
        labelBold = labelBold ?? TypographyTokens.labelBold,
        bodyRegular = bodyRegular ?? TypographyTokens.bodyRegular,
        bodyBold = bodyBold ?? TypographyTokens.bodyBold,
        caption = caption ?? TypographyTokens.caption,
        quote = quote ?? TypographyTokens.quote;

  @override
  ThemeExtension<MinyTypography> copyWith({
    final TextStyle? titleRegular,
    final TextStyle? titleBold,
    final TextStyle? headingSmallRegular,
    final TextStyle? headingSmallMedium,
    final TextStyle? headingLargeBold,
    final TextStyle? labelRegular,
    final TextStyle? labelBold,
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
        headingSmallMedium: headingSmallMedium ?? this.headingSmallMedium,
        headingLargeBold: headingLargeBold ?? this.headingLargeBold,
        labelRegular: labelRegular ?? this.labelRegular,
        labelBold: labelBold ?? this.labelBold,
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
      headingSmallMedium:
          TextStyle.lerp(headingSmallMedium, other.headingSmallMedium, t) ??
              headingSmallMedium,
      headingLargeBold:
          TextStyle.lerp(headingLargeBold, other.headingLargeBold, t) ??
              headingLargeBold,
      labelRegular:
          TextStyle.lerp(labelRegular, other.labelRegular, t) ?? labelRegular,
      labelBold: TextStyle.lerp(labelBold, other.labelBold, t) ?? labelBold,
      bodyRegular:
          TextStyle.lerp(bodyRegular, other.bodyRegular, t) ?? bodyRegular,
      bodyBold: TextStyle.lerp(bodyBold, other.bodyBold, t) ?? bodyBold,
      caption: TextStyle.lerp(caption, other.caption, t) ?? caption,
      quote: TextStyle.lerp(quote, other.quote, t) ?? quote,
    );
  }
}
