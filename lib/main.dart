import 'package:expense_tracker_self/screens/home_screen.dart';
import 'package:flutter/material.dart';

var kColorSchemee = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 90, 181, 59),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardThemeData().copyWith(
          //what all things we have overrided, it will affect the whole cards in this project
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //in some widgets, .copyWith wont work. so we should do like this. //also check chatgpt how a specific widget is best themed.
            backgroundColor: kDarkColorScheme
                .primaryContainer, //PrimaryContainer:A variant of primary, usually lighter (in light theme) or darker (in dark theme).
            foregroundColor: kDarkColorScheme
                .onPrimaryContainer, //OnPrimaryContainer:The content color that goes on top of primaryContainer.
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kDarkColorScheme
                .onPrimaryContainer, // this wont override the foreground color of tha appbar. therefore green color wont occur in the case of title present in the appbar.
            fontSize: 16,
          ),
          bodyLarge: TextStyle(color: kDarkColorScheme.onSecondaryContainer),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: kDarkColorScheme.onSurface.withOpacity(.5),
          ),
          hintStyle: TextStyle(
            color: kDarkColorScheme.onSurface.withOpacity(0.7),
          ),
          prefixStyle: TextStyle(color: kDarkColorScheme.onSurface),
          floatingLabelStyle: TextStyle(color: kDarkColorScheme.primary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kDarkColorScheme.onSurface.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kDarkColorScheme.primary),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: const AppBarTheme().copyWith(
          //by using .copyWith we r using the default settings of AppBarTheme and weare just overriding background color and foreground color.
          backgroundColor: kDarkColorScheme.onPrimaryContainer,
          foregroundColor: kDarkColorScheme.primaryContainer,
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme:
            kColorSchemee, //by giving color scheme, we have changed the whole coloring scheme of the app which u can see in elevatedbutton color and all.
        appBarTheme: const AppBarTheme().copyWith(
          //by using .copyWith we r using the default settings of AppBarTheme and we are just overriding background color and foreground color.
          backgroundColor: kColorSchemee.onPrimaryContainer,
          foregroundColor: kColorSchemee.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          //what all things we have overrided, it will affect the whole cards in this project
          color: kColorSchemee.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            //in some widgets, .copyWith wont work. so we should do like this. //also check chatgpt how a specific widget is best themed.
            backgroundColor: kColorSchemee.primaryContainer,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: kColorSchemee.onSurface.withOpacity(0.5),
          ),
          hintStyle: TextStyle(
            color: kColorSchemee.onSurface.withOpacity(0.5),
          ),
          prefixStyle: TextStyle(color: kColorSchemee.onSurface),
          floatingLabelStyle: TextStyle(color: kColorSchemee.primary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kColorSchemee.onSurface.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorSchemee.primary),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorSchemee
                .onPrimaryContainer, // this wont override the foreground color of tha appbar. therefore green color wont occur in the case of title present in the appbar.
            fontSize: 16,
          ),
          bodyLarge: TextStyle(color: kColorSchemee.onSecondaryContainer),//Used mainly for normal body text in your app (paragraphs, content text, etc.).
          
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    ),
  );
}
