// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/actors/actors_view.dart';
import '../ui/login/login_view.dart';
import '../ui/new_actors/new_actors_view.dart';
import '../ui/roaster/roaster_view.dart';
import '../ui/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String actorsView = '/actors-view';
  static const String loginView = '/login-view';
  static const String newActorsView = '/new-actors-view';
  static const String roasterView = '/roaster-view';
  static const all = <String>{
    startupView,
    actorsView,
    loginView,
    newActorsView,
    roasterView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.actorsView, page: ActorsView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.newActorsView, page: NewActorsView),
    RouteDef(Routes.roasterView, page: RoasterView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    ActorsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const ActorsView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    NewActorsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const NewActorsView(),
        settings: data,
      );
    },
    RoasterView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const RoasterView(),
        settings: data,
      );
    },
  };
}
