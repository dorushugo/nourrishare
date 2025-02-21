import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
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
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'Connexion': ParameterData.none(),
  'Onboarding': ParameterData.none(),
  'Profilpage': ParameterData.none(),
  'Accueil': ParameterData.none(),
  'Plats_details': (data) async => ParameterData(
        allParams: {
          'plats': getParameter<DocumentReference>(data, 'plats'),
        },
      ),
  'vendeur_detail': (data) async {
    final allParams = {
      'seller': getParameter<DocumentReference>(data, 'seller'),
    };
    return ParameterData(
      requiredParams: {
        'seller': serializeParam(
          allParams['seller'],
          ParamType.DocumentReference,
        ),
      },
      allParams: allParams,
    );
  },
  'ajouterunplat': (data) async => ParameterData(
        allParams: {
          'seller': getParameter<DocumentReference>(data, 'seller'),
        },
      ),
  'Profilcompletion': ParameterData.none(),
  'messageList': ParameterData.none(),
  'chatPage': (data) async => ParameterData(
        allParams: {
          'chat': getParameter<DocumentReference>(data, 'chat'),
        },
      ),
  'rechercheMessage': ParameterData.none(),
  'Inscription': ParameterData.none(),
  'stripeCompletion': ParameterData.none(),
  'Profilsettings': ParameterData.none(),
  'chatGroupPage': (data) async => ParameterData(
        allParams: {
          'chat': getParameter<DocumentReference>(data, 'chat'),
          'group': getParameter<DocumentReference>(data, 'group'),
        },
      ),
  'addGroup': (data) async => ParameterData(
        allParams: {
          'group': getParameter<DocumentReference>(data, 'group'),
        },
      ),
  'modifGroup': (data) async => ParameterData(
        allParams: {
          'group': getParameter<DocumentReference>(data, 'group'),
        },
      ),
  'ajouterUserGroupe': (data) async => ParameterData(
        allParams: {
          'group': getParameter<DocumentReference>(data, 'group'),
        },
      ),
  'connexionGroupe': (data) async => ParameterData(
        allParams: {
          'groupe': getParameter<DocumentReference>(data, 'groupe'),
        },
      ),
  'group_detail': (data) async => ParameterData(
        allParams: {
          'groupRef': getParameter<DocumentReference>(data, 'groupRef'),
        },
      ),
  'ConnexionInscription': ParameterData.none(),
  'Livraison': (data) async => ParameterData(
        allParams: {
          'commandeRef': getParameter<DocumentReference>(data, 'commandeRef'),
        },
      ),
  'Notifications': ParameterData.none(),
  'modifierPlat': (data) async => ParameterData(
        allParams: {
          'plat': getParameter<DocumentReference>(data, 'plat'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
