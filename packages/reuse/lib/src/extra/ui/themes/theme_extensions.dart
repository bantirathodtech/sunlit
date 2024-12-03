import 'package:flutter/material.dart';

import '../assets/colors.dart';
import '../assets/text_styles.dart';

/// Defines custom theme properties for consistent styling throughout the app.
@immutable
class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;
  final TextStyle? headingStyle;
  final TextStyle? bodyStyle;

  const CustomThemeExtension({
    this.primaryColor,
    this.secondaryColor,
    this.accentColor,
    this.headingStyle,
    this.bodyStyle,
  });

  @override
  CustomThemeExtension copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? accentColor,
    TextStyle? headingStyle,
    TextStyle? bodyStyle,
  }) {
    return CustomThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      headingStyle: headingStyle ?? this.headingStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
    );
  }

  @override
  CustomThemeExtension lerp(
      ThemeExtension<CustomThemeExtension>? other, double t) {
    if (other is! CustomThemeExtension) {
      return this;
    }

    return CustomThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      headingStyle: TextStyle.lerp(headingStyle, other.headingStyle, t),
      bodyStyle: TextStyle.lerp(bodyStyle, other.bodyStyle, t),
    );
  }

  // Optional: A method to convert this extension to a map for debugging purposes
  Map<String, dynamic> toMap() {
    return {
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'accentColor': accentColor,
      'headingStyle': headingStyle,
      'bodyStyle': bodyStyle,
    };
  }

  // Factory method to create light theme extension
  factory CustomThemeExtension.light() {
    return CustomThemeExtension(
      primaryColor: AppColors.primaryColor,
      secondaryColor: AppColors.accentColor,
      accentColor: AppColors.accentColor,
      headingStyle: AppTextStyles.lightTextTheme.headlineMedium,
      bodyStyle: AppTextStyles.lightTextTheme.bodyMedium,
    );
  }

  // Factory method to create dark theme extension
  factory CustomThemeExtension.dark() {
    return CustomThemeExtension(
      primaryColor: AppColors.primaryDarkColor,
      secondaryColor: AppColors.accentDarkColor,
      accentColor: AppColors.accentDarkColor,
      headingStyle: AppTextStyles.darkTextTheme.headlineMedium,
      bodyStyle: AppTextStyles.darkTextTheme.bodyMedium,
    );
  }
}

// Extension method to easily access the custom theme properties
extension CustomTheme on BuildContext {
  CustomThemeExtension get customTheme {
    return Theme.of(this).extension<CustomThemeExtension>() ??
        const CustomThemeExtension();
  }
}

// Usage in your main theme data
final ThemeData appTheme = ThemeData(
  primaryColor: Colors.blue,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16),
  ),
  extensions: [
    const CustomThemeExtension(
      primaryColor: Colors.blue,
      secondaryColor: Colors.green,
      accentColor: Colors.orange,
      headingStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      bodyStyle: TextStyle(fontSize: 14),
    ),
  ],
);

// Applying the custom theme in your widget
class CustomStyledWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customTheme = context.customTheme;

    return Container(
      color: customTheme.primaryColor,
      child: Text(
        'Hello, World!',
        style: customTheme.headingStyle,
      ),
    );
  }
}
//Purpose: Defines custom theme properties for consistent styling throughout the app.
// Usage: Used to extend and customize the app's theme.
