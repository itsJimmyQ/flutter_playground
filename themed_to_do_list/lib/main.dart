import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themed_to_do_list/presentation/cubits/app_theme_cubit.dart';
import 'package:themed_to_do_list/presentation/views/overview/overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppThemeCubit(),
        child: BlocBuilder<AppThemeCubit, AppTheme>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor:
                      context.read<AppThemeCubit>().state == AppTheme.light
                          ? Colors.orange
                          : Colors.blueGrey,
                ),
                useMaterial3: true,
              ),
              home: const MyHomePage(title: 'Themed ToDo App'),
            );
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemeCubit, AppTheme>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: const OverviewPage(),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.brightness_4),
              onPressed: () => context.read<AppThemeCubit>().toggleTheme()),
        );
      },
    );
  }
}
