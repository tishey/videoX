import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:video_x/src/features/auth/provider/auth_provider.dart';
import 'package:video_x/src/features/home/provider/home_provider.dart';

final allProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (context) => AuthProvider()),
  ChangeNotifierProvider(create: (context) => HomeProvider()),
];
