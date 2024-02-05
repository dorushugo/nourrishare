import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'plats_details_model.dart';
export 'plats_details_model.dart';

class PlatsDetailsWidget extends StatefulWidget {
  const PlatsDetailsWidget({
    super.key,
    this.plats,
  });

  final DocumentReference? plats;

  @override
  State<PlatsDetailsWidget> createState() => _PlatsDetailsWidgetState();
}

class _PlatsDetailsWidgetState extends State<PlatsDetailsWidget> {
  late PlatsDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlatsDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((currentUserDocument?.platsFavoris?.toList() ?? [])
              .contains(widget.plats) ==
          true) {
        setState(() {
          _model.favoris = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return StreamBuilder<PlatsRecord>(
      stream: PlatsRecord.getDocument(widget.plats!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).secondary,
                  ),
                ),
              ),
            ),
          );
        }
        final platsDetailsPlatsRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  StreamBuilder<UsersRecord>(
                    stream: UsersRecord.getDocument(
                        platsDetailsPlatsRecord.seller!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).secondary,
                              ),
                            ),
                          ),
                        );
                      }
                      final stackUsersRecord = snapshot.data!;
                      return Stack(
                        children: [
                          if (_model.commanderState == 1)
                            Container(
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.45,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child:
                                                      FlutterFlowExpandedImageView(
                                                    image: Image.network(
                                                      platsDetailsPlatsRecord
                                                          .images.first,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    allowRotation: false,
                                                    tag: platsDetailsPlatsRecord
                                                        .images.first,
                                                    useHeroAnimation: true,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag: platsDetailsPlatsRecord
                                                  .images.first,
                                              transitionOnUserGestures: true,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: Image.network(
                                                  platsDetailsPlatsRecord
                                                      .images.first,
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          1.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 24.0, 0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.safePop();
                                              },
                                              child: Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Icon(
                                                    FFIcons.kcloseSquare,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 24.0, 24.0, 0.0),
                                            child: Container(
                                              width: 48.0,
                                              height: 48.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: ToggleIcon(
                                                  onPressed: () async {
                                                    setState(() =>
                                                        _model.favoris =
                                                            !_model.favoris);
                                                    if ((currentUserDocument
                                                                    ?.platsFavoris
                                                                    ?.toList() ??
                                                                [])
                                                            .contains(
                                                                widget.plats) ==
                                                        true) {
                                                      await currentUserReference!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'plats_favoris':
                                                                FieldValue
                                                                    .arrayRemove([
                                                              widget.plats
                                                            ]),
                                                          },
                                                        ),
                                                      });
                                                    } else {
                                                      await currentUserReference!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'plats_favoris':
                                                                FieldValue
                                                                    .arrayUnion([
                                                              widget.plats
                                                            ]),
                                                          },
                                                        ),
                                                      });
                                                    }
                                                  },
                                                  value: _model.favoris,
                                                  onIcon: Icon(
                                                    FFIcons.kheart2,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 24.0,
                                                  ),
                                                  offIcon: Icon(
                                                    FFIcons.kheart,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.6,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 24.0, 24.0, 0.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 275.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        platsDetailsPlatsRecord
                                                            .name,
                                                        maxLines: 2,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLargeFamily,
                                                                  fontSize:
                                                                      24.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleLargeFamily),
                                                                ),
                                                      ),
                                                    ),
                                                    RichText(
                                                      textScaleFactor:
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                platsDetailsPlatsRecord
                                                                    .prix
                                                                    .toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                          ),
                                                          TextSpan(
                                                            text: ' €',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyMediumFamily),
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FFIcons.klocation1,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .grey1,
                                                      size: 18.0,
                                                    ),
                                                    AuthUserStreamWidget(
                                                      builder: (context) =>
                                                          Text(
                                                        valueOrDefault<String>(
                                                          functions.calculateDistance(
                                                              valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.latitude,
                                                                  0.0),
                                                              valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.longitude,
                                                                  0.0),
                                                              stackUsersRecord
                                                                  .latitude,
                                                              stackUsersRecord
                                                                  .longitude),
                                                          'Inconnue',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLargeFamily,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .grey1,
                                                                  fontSize:
                                                                      16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleLargeFamily),
                                                                ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.circle_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .grey1,
                                                      size: 6.0,
                                                    ),
                                                    Icon(
                                                      FFIcons.kcook,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .grey1,
                                                      size: 18.0,
                                                    ),
                                                    Text(
                                                      '${platsDetailsPlatsRecord.quantite.toString()} portions disponibles',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .grey1,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleLargeFamily),
                                                              ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 8.0)),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 54.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grey4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .transparent,
                                                      width: 0.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              setState(() {
                                                                _model.selecteur =
                                                                    false;
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 46.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  _model.selecteur
                                                                      ? Color(
                                                                          0x00ECF4ED)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .transparent,
                                                                  width: 0.0,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Ingrédients',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).titleSmallFamily,
                                                                            color: _model.selecteur
                                                                                ? FlutterFlowTheme.of(context).primaryText
                                                                                : FlutterFlowTheme.of(context).primaryBackground,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              setState(() {
                                                                _model.selecteur =
                                                                    true;
                                                              });
                                                            },
                                                            child: Container(
                                                              height: 100.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  !_model.selecteur
                                                                      ? Color(
                                                                          0x00ECF4ED)
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  Colors
                                                                      .transparent,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .grey4,
                                                                  width: 0.0,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      'Allergènes',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                            color: !_model.selecteur
                                                                                ? FlutterFlowTheme.of(context).primaryText
                                                                                : FlutterFlowTheme.of(context).primaryBackground,
                                                                            fontSize:
                                                                                16.0,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 8.0)),
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      _model.selecteur == false
                                                          ? platsDetailsPlatsRecord
                                                              .ingredients
                                                          : platsDetailsPlatsRecord
                                                              .allergnes,
                                                      'Aucune information',
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMediumFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .grey1,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                  ),
                                                ),
                                                wrapWithModel(
                                                  model: _model.userCardModel,
                                                  updateCallback: () =>
                                                      setState(() {}),
                                                  child: UserCardWidget(
                                                    userRef:
                                                        platsDetailsPlatsRecord
                                                            .seller!,
                                                  ),
                                                ),
                                                if ((platsDetailsPlatsRecord
                                                            .seller !=
                                                        currentUserReference) &&
                                                    (platsDetailsPlatsRecord
                                                            .etat <
                                                        5))
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      setState(() {
                                                        _model.commanderState =
                                                            2;
                                                      });
                                                    },
                                                    text: 'Commander',
                                                    options: FFButtonOptions(
                                                      width: double.infinity,
                                                      height: 60.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24.0,
                                                                  0.0,
                                                                  24.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  8.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                                color: Colors
                                                                    .white,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily),
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                if (platsDetailsPlatsRecord
                                                        .seller ==
                                                    currentUserReference)
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      context.pushNamed(
                                                        'modifierPlat',
                                                        queryParameters: {
                                                          'plat':
                                                              serializeParam(
                                                            widget.plats,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    text: 'Modifier le plat',
                                                    icon: Icon(
                                                      FFIcons.keditSquare,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: double.infinity,
                                                      height: 60.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24.0,
                                                                  0.0,
                                                                  24.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  4.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                                color: Colors
                                                                    .white,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily),
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                if (platsDetailsPlatsRecord
                                                        .seller ==
                                                    currentUserReference)
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      var confirmDialogResponse =
                                                          await showDialog<
                                                                  bool>(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (alertDialogContext) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Êtes vous sur ?'),
                                                                    content: Text(
                                                                        'Votre plat sera retiré de la vente immédiatement, êtes vous sur de vouloir le supprimer ? '),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                        child: Text(
                                                                            'Conserver'),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () => Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                        child: Text(
                                                                            'Supprimer'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ) ??
                                                              false;
                                                      if (confirmDialogResponse) {
                                                        await platsDetailsPlatsRecord
                                                            .reference
                                                            .delete();

                                                        await stackUsersRecord
                                                            .reference
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'plats': FieldValue
                                                                  .arrayRemove([
                                                                widget.plats
                                                              ]),
                                                            },
                                                          ),
                                                        });
                                                        context.safePop();
                                                      }
                                                    },
                                                    text: 'Supprimer le plat',
                                                    icon: FaIcon(
                                                      FontAwesomeIcons.times,
                                                      size: 20.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: double.infinity,
                                                      height: 60.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24.0,
                                                                  0.0,
                                                                  24.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsets.all(0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                                color: Colors
                                                                    .white,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily),
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                              ].divide(SizedBox(height: 24.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_model.commanderState == 2)
                            Container(
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Commander un plat',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall,
                                              ),
                                              Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grey4,
                                                  ),
                                                ),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.safePop();
                                                  },
                                                  child: Icon(
                                                    Icons.close_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(0.0, 2.0),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: SvgPicture.asset(
                                                      'assets/images/Online_delivery.svg',
                                                      width: double.infinity,
                                                      height: 160.0,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Commander pour maintenant',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    child: Text(
                                                      'Vous serez servie dès que le plat sera prêt. (Ex : Service dans 30 minutes)',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () async {
                                                      _model.prixStripeValueCopy =
                                                          await actions
                                                              .prixStripe(
                                                        platsDetailsPlatsRecord
                                                            .prix,
                                                      );

                                                      var commandesRecordReference =
                                                          CommandesRecord
                                                              .collection
                                                              .doc();
                                                      await commandesRecordReference
                                                          .set({
                                                        ...createCommandesRecordData(
                                                          name:
                                                              platsDetailsPlatsRecord
                                                                  .name,
                                                          amount:
                                                              platsDetailsPlatsRecord
                                                                  .prix,
                                                          status: 'Commandé',
                                                          vendorName:
                                                              stackUsersRecord
                                                                  .displayName,
                                                          vendorRef:
                                                              platsDetailsPlatsRecord
                                                                  .seller,
                                                          isVoisins: false,
                                                          buyer:
                                                              currentUserReference,
                                                          latlngLivraison:
                                                              currentUserDocument
                                                                  ?.latlong,
                                                          adresseLivraison:
                                                              valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.address,
                                                                  ''),
                                                          dateLivraison:
                                                              'Maintenant',
                                                          delaiMinutes:
                                                              platsDetailsPlatsRecord
                                                                  .tempsPreparationMin,
                                                          statusNumber: 1,
                                                          datetimeLivraison:
                                                              getCurrentTimestamp,
                                                          isInstant: true,
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'created_at': FieldValue
                                                                .serverTimestamp(),
                                                            'plats': [
                                                              widget.plats
                                                            ],
                                                          },
                                                        ),
                                                      });
                                                      _model.commandeCreeCopy =
                                                          CommandesRecord
                                                              .getDocumentFromData({
                                                        ...createCommandesRecordData(
                                                          name:
                                                              platsDetailsPlatsRecord
                                                                  .name,
                                                          amount:
                                                              platsDetailsPlatsRecord
                                                                  .prix,
                                                          status: 'Commandé',
                                                          vendorName:
                                                              stackUsersRecord
                                                                  .displayName,
                                                          vendorRef:
                                                              platsDetailsPlatsRecord
                                                                  .seller,
                                                          isVoisins: false,
                                                          buyer:
                                                              currentUserReference,
                                                          latlngLivraison:
                                                              currentUserDocument
                                                                  ?.latlong,
                                                          adresseLivraison:
                                                              valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.address,
                                                                  ''),
                                                          dateLivraison:
                                                              'Maintenant',
                                                          delaiMinutes:
                                                              platsDetailsPlatsRecord
                                                                  .tempsPreparationMin,
                                                          statusNumber: 1,
                                                          datetimeLivraison:
                                                              getCurrentTimestamp,
                                                          isInstant: true,
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'created_at':
                                                                DateTime.now(),
                                                            'plats': [
                                                              widget.plats
                                                            ],
                                                          },
                                                        ),
                                                      }, commandesRecordReference);
                                                      triggerPushNotification(
                                                        notificationTitle:
                                                            'Vous avez reçu une commande',
                                                        notificationText:
                                                            'Votre plat \"${platsDetailsPlatsRecord.name}\" a été commandé par ${currentUserDisplayName}',
                                                        notificationImageUrl:
                                                            platsDetailsPlatsRecord
                                                                .images.first,
                                                        notificationSound:
                                                            'default',
                                                        userRefs: [
                                                          stackUsersRecord
                                                              .reference
                                                        ],
                                                        initialPageName:
                                                            'Livraison',
                                                        parameterData: {
                                                          'commandeRef': _model
                                                              .commandeCreeCopy
                                                              ?.reference,
                                                        },
                                                      );

                                                      await NotificationRecord
                                                              .createDoc(
                                                                  stackUsersRecord
                                                                      .reference)
                                                          .set({
                                                        ...createNotificationRecordData(
                                                          text:
                                                              'Votre plat \"${platsDetailsPlatsRecord.name}\" a été commandé par ${currentUserDisplayName}',
                                                          image:
                                                              platsDetailsPlatsRecord
                                                                  .images.first,
                                                          seenBool: false,
                                                          isCommande: true,
                                                          isChat: false,
                                                          isFriendRequest:
                                                              false,
                                                          commandeRef: _model
                                                              .commandeCreeCopy
                                                              ?.reference,
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'userRef': [
                                                              stackUsersRecord
                                                                  .reference
                                                            ],
                                                            'timestamp': FieldValue
                                                                .serverTimestamp(),
                                                          },
                                                        ),
                                                      });

                                                      await widget.plats!.update(
                                                          createPlatsRecordData(
                                                        etat: 5,
                                                      ));

                                                      context.pushNamed(
                                                        'Livraison',
                                                        queryParameters: {
                                                          'commandeRef':
                                                              serializeParam(
                                                            _model
                                                                .commandeCreeCopy
                                                                ?.reference,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );

                                                      setState(() {});
                                                    },
                                                    text: 'Sélectionner',
                                                    options: FFButtonOptions(
                                                      height: 40.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24.0,
                                                                  0.0,
                                                                  24.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily,
                                                                color: Colors
                                                                    .white,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleSmallFamily),
                                                              ),
                                                      elevation: 3.0,
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 12.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 40.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              setState(() {
                                                _model.commanderState = 3;
                                              });
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 2.0),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 24.0, 0.0, 24.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: SvgPicture.asset(
                                                        'assets/images/Woman_making_a_video_call.svg',
                                                        width: double.infinity,
                                                        height: 160.0,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Commander pour plus tard',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  24.0,
                                                                  0.0,
                                                                  24.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Votre plat sera prêt pour le jour souhaité.  \n(Ex : Service jeudi midi)',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        setState(() {
                                                          _model.commanderState =
                                                              3;
                                                        });
                                                      },
                                                      text: 'Sélectionner',
                                                      options: FFButtonOptions(
                                                        height: 40.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    24.0,
                                                                    0.0,
                                                                    24.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                                  color: Colors
                                                                      .white,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .titleSmallFamily),
                                                                ),
                                                        elevation: 3.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 12.0)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 24.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_model.commanderState == 3)
                            Container(
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Commander un plat',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineSmall,
                                              ),
                                              Container(
                                                width: 48.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grey4,
                                                  ),
                                                ),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.safePop();
                                                  },
                                                  child: Icon(
                                                    Icons.close_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4.0,
                                                  color: Color(0x33000000),
                                                  offset: Offset(0.0, 2.0),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: SvgPicture.asset(
                                                      'assets/images/Woman_making_a_video_call.svg',
                                                      width: double.infinity,
                                                      height: 160.0,
                                                      fit: BoxFit.fitHeight,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Commander pour plus tard',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    child: Text(
                                                      'Votre plat sera prêt pour le jour souhaité.  \n(Ex : Service jeudi midi)',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 12.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: FlutterFlowCalendar(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            weekFormat: true,
                                            weekStartsMonday: true,
                                            rowHeight: 64.0,
                                            onChange: (DateTimeRange?
                                                newSelectedDate) {
                                              setState(() =>
                                                  _model.calendarSelectedDay =
                                                      newSelectedDate);
                                            },
                                            titleStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineSmall,
                                            dayOfWeekStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelLarge
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLargeFamily,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLargeFamily),
                                                      lineHeight: 1.0,
                                                    ),
                                            dateStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium,
                                            selectedDateStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall,
                                            inactiveDateStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium,
                                            locale: FFLocalizations.of(context)
                                                .languageCode,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .momentLivraisonValueController ??=
                                                FormFieldController<String>(
                                                    null),
                                            options: List<String>.from(
                                                ['matin', 'midi', 'soir']),
                                            optionLabels: [
                                              'Le matin',
                                              'Le midi ',
                                              'Le soir'
                                            ],
                                            onChanged: (val) => setState(() =>
                                                _model.momentLivraisonValue =
                                                    val),
                                            width: double.infinity,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontWeight: FontWeight.w900,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
                                                ),
                                            hintText:
                                                'Quand souhaitez-vous être servi(e) ? ',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 20.0,
                                            ),
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .grey4,
                                            borderWidth: 2.0,
                                            borderRadius: 20.0,
                                            margin: EdgeInsets.all(20.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          ),
                                        ),
                                        if ((platsDetailsPlatsRecord.seller !=
                                                currentUserReference) &&
                                            (platsDetailsPlatsRecord.etat < 5))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                _model.prixStripeValue =
                                                    await actions.prixStripe(
                                                  platsDetailsPlatsRecord.prix,
                                                );
                                                _model.comission = await actions
                                                    .calculateComission(
                                                  _model.prixStripeValue!,
                                                  platsDetailsPlatsRecord
                                                      .quantite,
                                                );
                                                _model.prixTotalResult =
                                                    await actions
                                                        .calculateTotal(
                                                  _model.prixStripeValue!,
                                                  platsDetailsPlatsRecord
                                                      .quantite,
                                                );

                                                var commandesRecordReference =
                                                    CommandesRecord.collection
                                                        .doc();
                                                await commandesRecordReference
                                                    .set({
                                                  ...createCommandesRecordData(
                                                    name:
                                                        platsDetailsPlatsRecord
                                                            .name,
                                                    amount:
                                                        platsDetailsPlatsRecord
                                                            .prix,
                                                    status: 'Commandé',
                                                    vendorName: stackUsersRecord
                                                        .displayName,
                                                    vendorRef:
                                                        platsDetailsPlatsRecord
                                                            .seller,
                                                    isVoisins: false,
                                                    buyer: currentUserReference,
                                                    latlngLivraison:
                                                        currentUserDocument
                                                            ?.latlong,
                                                    adresseLivraison:
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.address,
                                                            ''),
                                                    dateLivraison:
                                                        '${dateTimeFormat(
                                                      'EEEE',
                                                      _model.calendarSelectedDay
                                                          ?.start,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    )} ${_model.momentLivraisonValue}',
                                                    statusNumber: 1,
                                                    datetimeLivraison: _model
                                                                .calendarSelectedDay
                                                                ?.end !=
                                                            null
                                                        ? _model
                                                            .calendarSelectedDay
                                                            ?.end
                                                        : dateTimeFromSecondsSinceEpoch(
                                                            getCurrentTimestamp
                                                                .secondsSinceEpoch),
                                                    isInstant: false,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'created_at': FieldValue
                                                          .serverTimestamp(),
                                                      'plats': [widget.plats],
                                                    },
                                                  ),
                                                });
                                                _model.commandeCree =
                                                    CommandesRecord
                                                        .getDocumentFromData({
                                                  ...createCommandesRecordData(
                                                    name:
                                                        platsDetailsPlatsRecord
                                                            .name,
                                                    amount:
                                                        platsDetailsPlatsRecord
                                                            .prix,
                                                    status: 'Commandé',
                                                    vendorName: stackUsersRecord
                                                        .displayName,
                                                    vendorRef:
                                                        platsDetailsPlatsRecord
                                                            .seller,
                                                    isVoisins: false,
                                                    buyer: currentUserReference,
                                                    latlngLivraison:
                                                        currentUserDocument
                                                            ?.latlong,
                                                    adresseLivraison:
                                                        valueOrDefault(
                                                            currentUserDocument
                                                                ?.address,
                                                            ''),
                                                    dateLivraison:
                                                        '${dateTimeFormat(
                                                      'EEEE',
                                                      _model.calendarSelectedDay
                                                          ?.start,
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    )} ${_model.momentLivraisonValue}',
                                                    statusNumber: 1,
                                                    datetimeLivraison: _model
                                                                .calendarSelectedDay
                                                                ?.end !=
                                                            null
                                                        ? _model
                                                            .calendarSelectedDay
                                                            ?.end
                                                        : dateTimeFromSecondsSinceEpoch(
                                                            getCurrentTimestamp
                                                                .secondsSinceEpoch),
                                                    isInstant: false,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'created_at':
                                                          DateTime.now(),
                                                      'plats': [widget.plats],
                                                    },
                                                  ),
                                                }, commandesRecordReference);
                                                _model.sessionCree =
                                                    await StripeGroup
                                                        .sessionsCall
                                                        .call(
                                                  connectedAccount:
                                                      stackUsersRecord
                                                          .stripeAccountID,
                                                  cancelurl:
                                                      'https://testurl.net/cancel',
                                                  successurl:
                                                      'https://nourrishare.com/success-payment/',
                                                  currency: 'eur',
                                                  productName:
                                                      _model.commandeCree?.name,
                                                  unitAmout:
                                                      _model.prixStripeValue,
                                                  quantity:
                                                      platsDetailsPlatsRecord
                                                          .quantite,
                                                );
                                                if ((_model.sessionCree
                                                        ?.succeeded ??
                                                    true)) {
                                                  await _model
                                                      .commandeCree!.reference
                                                      .update(
                                                          createCommandesRecordData(
                                                    stripeSessionId: StripeGroup
                                                        .sessionsCall
                                                        .paymentIntendID(
                                                      (_model.sessionCree
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                    paymentUrl: StripeGroup
                                                        .sessionsCall
                                                        .paymentUrl(
                                                      (_model.sessionCree
                                                              ?.jsonBody ??
                                                          ''),
                                                    ),
                                                  ));
                                                  await launchURL(StripeGroup
                                                      .sessionsCall
                                                      .paymentUrl(
                                                    (_model.sessionCree
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!);

                                                  context.pushNamed(
                                                    'Livraison',
                                                    queryParameters: {
                                                      'commandeRef':
                                                          serializeParam(
                                                        _model.commandeCree
                                                            ?.reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                } else {
                                                  await showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Erreur session stripe'),
                                                        content: Text(
                                                            'Montant unit : ${_model.prixStripeValue?.toString()}Comission :${_model.comission?.toString()}'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }

                                                setState(() {});
                                              },
                                              text: 'Commander',
                                              options: FFButtonOptions(
                                                width: double.infinity,
                                                height: 60.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 8.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmallFamily,
                                                          color: Colors.white,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily),
                                                        ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                      ].divide(SizedBox(height: 24.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
