import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const AccueilWidget() : const OnboardingWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const AccueilWidget() : const OnboardingWidget(),
        ),
        FFRoute(
          name: 'Connexion',
          path: '/connexion',
          builder: (context, params) => const ConnexionWidget(),
        ),
        FFRoute(
          name: 'Onboarding',
          path: '/onboarding',
          builder: (context, params) => const OnboardingWidget(),
        ),
        FFRoute(
          name: 'Profilpage',
          path: '/profilPage',
          requireAuth: true,
          builder: (context, params) => const ProfilpageWidget(),
        ),
        FFRoute(
          name: 'Accueil',
          path: '/accueil',
          requireAuth: true,
          builder: (context, params) => const AccueilWidget(),
        ),
        FFRoute(
          name: 'Plats_details',
          path: '/platsDetails',
          requireAuth: true,
          builder: (context, params) => PlatsDetailsWidget(
            plats: params.getParam(
                'plats', ParamType.DocumentReference, false, ['Plats']),
          ),
        ),
        FFRoute(
          name: 'vendeur_detail',
          path: '/vendeurDetail/:seller',
          requireAuth: true,
          builder: (context, params) => VendeurDetailWidget(
            seller: params.getParam(
                'seller', ParamType.DocumentReference, false, ['Users']),
          ),
        ),
        FFRoute(
          name: 'ajouterunplat',
          path: '/ajouterplat',
          requireAuth: true,
          builder: (context, params) => AjouterunplatWidget(
            seller: params.getParam(
                'seller', ParamType.DocumentReference, false, ['Users']),
          ),
        ),
        FFRoute(
          name: 'Profilcompletion',
          path: '/profilcompletion',
          requireAuth: true,
          builder: (context, params) => const ProfilcompletionWidget(),
        ),
        FFRoute(
          name: 'messageList',
          path: '/messageList',
          requireAuth: true,
          builder: (context, params) => const MessageListWidget(),
        ),
        FFRoute(
          name: 'chatPage',
          path: '/chatPage',
          requireAuth: true,
          builder: (context, params) => ChatPageWidget(
            chat: params.getParam(
                'chat', ParamType.DocumentReference, false, ['Chats']),
          ),
        ),
        FFRoute(
          name: 'rechercheMessage',
          path: '/rechercheMessage',
          requireAuth: true,
          builder: (context, params) => const RechercheMessageWidget(),
        ),
        FFRoute(
          name: 'Inscription',
          path: '/Inscription',
          builder: (context, params) => const InscriptionWidget(),
        ),
        FFRoute(
          name: 'stripeCompletion',
          path: '/stripeCompletion',
          requireAuth: true,
          builder: (context, params) => const StripeCompletionWidget(),
        ),
        FFRoute(
          name: 'Profilsettings',
          path: '/profilsettings',
          requireAuth: true,
          builder: (context, params) => const ProfilsettingsWidget(),
        ),
        FFRoute(
          name: 'chatGroupPage',
          path: '/chatGroupPage',
          requireAuth: true,
          builder: (context, params) => ChatGroupPageWidget(
            chat: params.getParam(
                'chat', ParamType.DocumentReference, false, ['Chats']),
            group: params.getParam(
                'group', ParamType.DocumentReference, false, ['Groupes']),
          ),
        ),
        FFRoute(
          name: 'addGroup',
          path: '/addGroup',
          requireAuth: true,
          builder: (context, params) => AddGroupWidget(
            group: params.getParam(
                'group', ParamType.DocumentReference, false, ['Groupes']),
          ),
        ),
        FFRoute(
          name: 'modifGroup',
          path: '/modifGroup',
          requireAuth: true,
          builder: (context, params) => ModifGroupWidget(
            group: params.getParam(
                'group', ParamType.DocumentReference, false, ['Groupes']),
          ),
        ),
        FFRoute(
          name: 'ajouterUserGroupe',
          path: '/addUserGroupe',
          requireAuth: true,
          builder: (context, params) => AjouterUserGroupeWidget(
            group: params.getParam(
                'group', ParamType.DocumentReference, false, ['Groupes']),
          ),
        ),
        FFRoute(
          name: 'connexionGroupe',
          path: '/connexionGroupe',
          requireAuth: true,
          builder: (context, params) => ConnexionGroupeWidget(
            groupe: params.getParam(
                'groupe', ParamType.DocumentReference, false, ['Groupes']),
          ),
        ),
        FFRoute(
          name: 'group_detail',
          path: '/groupDetail',
          requireAuth: true,
          builder: (context, params) => GroupDetailWidget(
            groupRef: params.getParam(
                'groupRef', ParamType.DocumentReference, false, ['Groupes']),
          ),
        ),
        FFRoute(
          name: 'ConnexionInscription',
          path: '/connexionInscription',
          builder: (context, params) => const ConnexionInscriptionWidget(),
        ),
        FFRoute(
          name: 'Livraison',
          path: '/livraison',
          builder: (context, params) => LivraisonWidget(
            commandeRef: params.getParam('commandeRef',
                ParamType.DocumentReference, false, ['Commandes']),
          ),
        ),
        FFRoute(
          name: 'Notifications',
          path: '/Notifications',
          requireAuth: true,
          builder: (context, params) => const NotificationsWidget(),
        ),
        FFRoute(
          name: 'modifierPlat',
          path: '/modifierPlat',
          requireAuth: true,
          builder: (context, params) => ModifierPlatWidget(
            plat: params.getParam(
                'plat', ParamType.DocumentReference, false, ['Plats']),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/onboarding';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Logo_avec_texte.png',
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 0),
      );
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
