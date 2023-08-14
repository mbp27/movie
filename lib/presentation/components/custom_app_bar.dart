import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/logic/cubits/theme/theme_cubit.dart';
import 'package:movie/presentation/screens/about/about_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.bottom,
    this.title,
  })  : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize.width ?? 0)),
        super(key: key);

  final PreferredSizeWidget? bottom;
  final Widget? title;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  final Size preferredSize;
}

class _CustomAppBarState extends State<CustomAppBar> {
  void _setTheme() {
    context.read<ThemeCubit>().onToggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness = Theme.of(context).brightness;
    final IconData themeIcon = brightness == Brightness.light
        ? Icons.brightness_4
        : Icons.brightness_5;

    return AppBar(
      title: widget.title,
      actions: [
        IconButton(
          splashRadius: 20.0,
          onPressed: _setTheme,
          icon: Icon(themeIcon),
        ),
        IconButton(
          splashRadius: 20.0,
          onPressed: () =>
              Navigator.of(context).pushNamed(AboutScreen.routeName),
          icon: const Icon(Icons.info_outline),
        ),
      ],
      backgroundColor: appBarTheme.backgroundColor ?? theme.primaryColor,
    );
  }
}
