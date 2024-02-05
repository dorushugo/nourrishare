import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'nav_bar1_model.dart';
export 'nav_bar1_model.dart';

class NavBar1Widget extends StatefulWidget {
  const NavBar1Widget({super.key});

  @override
  State<NavBar1Widget> createState() => _NavBar1WidgetState();
}

class _NavBar1WidgetState extends State<NavBar1Widget> {
  late NavBar1Model _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBar1Model());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.messagenotseen = await queryChatsRecordOnce(
        queryBuilder: (chatsRecord) => chatsRecord
            .where(
              'last_message_seen_by',
              isNotEqualTo: currentUserReference,
            )
            .where(
              'users',
              arrayContains: currentUserReference,
            ),
      );
      _model.nombreCommandeQuery = await queryCommandesRecordCount(
        queryBuilder: (commandesRecord) => commandesRecord
            .where(
              'buyer',
              isEqualTo: currentUserReference,
            )
            .where(
              'status',
              isEqualTo: 'Commandé',
            ),
      );
      setState(() {
        FFAppState().Nomdepage =
            'nourrishare://nourrishare.com${GoRouter.of(context).location}';
        FFAppState().nombreNotif = _model.messagenotseen!
            .where((e) => e.lastMessageSentBy != currentUserReference)
            .toList()
            .length;
        FFAppState().nombreCommande = _model.nombreCommandeQuery!;
      });
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Visibility(
      visible: !(isWeb
          ? MediaQuery.viewInsetsOf(context).bottom > 0
          : _isKeyboardVisible),
      child: Align(
        alignment: AlignmentDirectional(0.0, 1.0),
        child: Container(
          height: 100.0,
          child: Stack(
            alignment: AlignmentDirectional(0.0, 1.0),
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: FlutterFlowTheme.of(context).boxShadow,
                        offset: Offset(0.0, -4.0),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor: Color(0x00409061),
                              borderRadius: 20.0,
                              borderWidth: 0.0,
                              buttonSize: 48.0,
                              fillColor: Color(0x004B39EF),
                              icon: Icon(
                                FFIcons.khomeMenuIcon3,
                                color: valueOrDefault<Color>(
                                  ('nourrishare://nourrishare.com${GoRouter.of(context).location}' ==
                                              'nourrishare://nourrishare.com/') ||
                                          ('nourrishare://nourrishare.com${GoRouter.of(context).location}' ==
                                              'nourrishare://nourrishare.com/accueil')
                                      ? FlutterFlowTheme.of(context).secondary
                                      : FlutterFlowTheme.of(context).grey2,
                                  FlutterFlowTheme.of(context).grey2,
                                ),
                                size: 24.0,
                              ),
                              onPressed: () async {
                                context.pushNamed('Accueil');
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Stack(
                                alignment: AlignmentDirectional(1.0, -1.0),
                                children: [
                                  FlutterFlowIconButton(
                                    borderColor: Color(0x00409061),
                                    borderRadius: 20.0,
                                    borderWidth: 0.0,
                                    buttonSize: 48.0,
                                    fillColor: Color(0x004B39EF),
                                    icon: Icon(
                                      FFIcons.kcallmessage1,
                                      color: valueOrDefault<Color>(
                                        'nourrishare://nourrishare.com${GoRouter.of(context).location}' ==
                                                'nourrishare://nourrishare.com/messageList'
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : FlutterFlowTheme.of(context)
                                                .grey2,
                                        FlutterFlowTheme.of(context).grey2,
                                      ),
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      context.pushNamed('messageList');
                                    },
                                  ),
                                  if (FFAppState().nombreNotif != 0)
                                    badges.Badge(
                                      badgeContent: Text(
                                        valueOrDefault<String>(
                                          FFAppState().nombreNotif < 10
                                              ? FFAppState()
                                                  .nombreNotif
                                                  .toString()
                                              : '9+',
                                          '0',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily,
                                              color: Colors.white,
                                              fontSize: 8.0,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmallFamily),
                                            ),
                                      ),
                                      showBadge: true,
                                      shape: badges.BadgeShape.circle,
                                      badgeColor:
                                          FlutterFlowTheme.of(context).accent1,
                                      elevation: 4.0,
                                      padding: EdgeInsets.all(8.0),
                                      position: badges.BadgePosition.topEnd(),
                                      animationType:
                                          badges.BadgeAnimationType.scale,
                                      toAnimate: true,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(width: 24.0)),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).transparent,
                      borderRadius: 1000.0,
                      borderWidth: 0.0,
                      buttonSize: 64.0,
                      fillColor: FlutterFlowTheme.of(context).secondary,
                      icon: Icon(
                        FFIcons.kchef,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        size: 32.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('ajouterunplat');
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  alignment: AlignmentDirectional(1.0, -1.0),
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: FlutterFlowIconButton(
                                        borderColor: Color(0x00409061),
                                        borderRadius: 20.0,
                                        borderWidth: 0.0,
                                        buttonSize: 48.0,
                                        fillColor: Color(0x004B39EF),
                                        icon: Icon(
                                          FFIcons.knotificationIcon1,
                                          color: valueOrDefault<Color>(
                                            'nourrishare://nourrishare.com${GoRouter.of(context).location}' ==
                                                    'nourrishare://nourrishare.com/Notifications'
                                                ? FlutterFlowTheme.of(context)
                                                    .secondary
                                                : FlutterFlowTheme.of(context)
                                                    .grey2,
                                            FlutterFlowTheme.of(context).grey2,
                                          ),
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          context.pushNamed('Notifications');
                                        },
                                      ),
                                    ),
                                    if (FFAppState().nombreCommande != 0)
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 24.0),
                                          child: Container(
                                            width: 24.0,
                                            height: 24.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              borderRadius:
                                                  BorderRadius.circular(1000.0),
                                            ),
                                            child: Icon(
                                              FFIcons.kcook,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              size: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowIconButton(
                              borderColor: Color(0x00409061),
                              borderRadius: 20.0,
                              borderWidth: 0.0,
                              buttonSize: 48.0,
                              fillColor: Color(0x004B39EF),
                              icon: Icon(
                                FFIcons.kaccountIcon2,
                                color: valueOrDefault<Color>(
                                  'nourrishare://nourrishare.com${GoRouter.of(context).location}' ==
                                          'nourrishare://nourrishare.com/profilPage'
                                      ? FlutterFlowTheme.of(context).secondary
                                      : FlutterFlowTheme.of(context).grey2,
                                  FlutterFlowTheme.of(context).grey2,
                                ),
                                size: 24.0,
                              ),
                              onPressed: () async {
                                context.pushNamed('Profilpage');
                              },
                            ),
                          ],
                        ),
                      ].divide(SizedBox(width: 24.0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
