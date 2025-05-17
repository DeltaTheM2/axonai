import 'package:flutter/material.dart';

class colorPallete{
  static final Color primaryColor = Color(0xFF274060);
  static final Color secondaryColor = Color(0xff589be5);
  static final Color  surfaceColor = Color(0xFFBED6EC);
  static final Color accentColor = Color(0xFF5899e2);
  static final Color onSurfaceColor = Color(0xFF1b2845);
  static final Color onPrimaryColor = Color(0xFFBED6EC);

  static final appScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: secondaryColor,
      onSecondary: onSurfaceColor,
      error: Colors.red,
      onError: Colors.white,
      surface: surfaceColor,
      onSurface: onSurfaceColor
  );

  static final appTheme = ThemeData(
      colorScheme: appScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        elevation: 4,

      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: primaryColor),
        bodySmall: TextStyle(color: primaryColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: primaryColor
          )
      ),
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: primaryColor,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
            return TextStyle(color: onPrimaryColor); // Define the default TextStyle
          }),
          elevation: 2,
          indicatorColor: surfaceColor,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((Set<WidgetState> states){
            if(states.contains(WidgetState.selected)){
              return IconThemeData(color: primaryColor);
            }
            return IconThemeData(color: onPrimaryColor);
          })

      ),
      cardTheme: CardTheme(
        color : secondaryColor,
        elevation: 4,
      ),
      iconTheme: IconThemeData(
          fill: 1,
          color: surfaceColor
      )
  );
}