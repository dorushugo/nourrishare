import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components_general/item_commandes/item_commandes_widget.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:map_launcher/map_launcher.dart' as $ml;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'livraison_model.dart';
export 'livraison_model.dart';

class LivraisonWidget extends StatefulWidget {
  const LivraisonWidget({
    super.key,
    required this.commandeRef,
  });

  final DocumentReference? commandeRef;

  @override
  State<LivraisonWidget> createState() => _LivraisonWidgetState();
}

class _LivraisonWidgetState extends State<LivraisonWidget>
    with TickerProviderStateMixin {
  late LivraisonModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'itemCommandesOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 70.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 70.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LivraisonModel());
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: StreamBuilder<CommandesRecord>(
            stream: CommandesRecord.getDocument(widget.commandeRef!),
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
              final stackCommandesRecord = snapshot.data!;
              return Container(
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.38,
                      child: Stack(
                        children: [
                          Builder(builder: (context) {
                            final _googleMapMarker = stackCommandesRecord;
                            return FlutterFlowGoogleMap(
                              controller: _model.googleMapsController,
                              onCameraIdle: (latLng) =>
                                  _model.googleMapsCenter = latLng,
                              initialLocation: _model.googleMapsCenter ??=
                                  stackCommandesRecord.latlngLivraison!,
                              markers: [
                                FlutterFlowMarker(
                                  _googleMapMarker.reference.path,
                                  _googleMapMarker.latlngLivraison!,
                                  () async {
                                    await launchMap(
                                      location:
                                          stackCommandesRecord.latlngLivraison,
                                      title: 'Adresse de livraison',
                                    );
                                  },
                                ),
                              ],
                              markerColor: GoogleMarkerColor.green,
                              mapType: MapType.terrain,
                              style: GoogleMapStyle.standard,
                              initialZoom: 14.0,
                              allowInteraction: false,
                              allowZoom: false,
                              showZoomControls: false,
                              showLocation: true,
                              showCompass: false,
                              showMapToolbar: false,
                              showTraffic: false,
                              centerMapOnMarkerTap: true,
                            );
                          }),
                          Align(
                            alignment: AlignmentDirectional(-1.0, -1.0),
                            child: PointerInterceptor(
                              intercepting: isWeb,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed('Notifications');
                                  },
                                  child: Container(
                                    width: 48.0,
                                    height: 48.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Icon(
                                        FFIcons.kcloseSquare,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (stackCommandesRecord.statusNumber > 1)
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: StreamBuilder<UsersRecord>(
                          stream: UsersRecord.getDocument(
                              stackCommandesRecord.vendorRef!),
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
                            final containerUsersRecord = snapshot.data!;
                            return Container(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.68,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(-1.0, -1.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.5,
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  () {
                                                    if (stackCommandesRecord
                                                            .statusNumber ==
                                                        1) {
                                                      return 'Commande en cours...';
                                                    } else if (stackCommandesRecord
                                                            .statusNumber ==
                                                        2) {
                                                      return 'Votre commande est prète à être livrée !';
                                                    } else if (stackCommandesRecord
                                                            .statusNumber ==
                                                        3) {
                                                      return 'Commande livrée';
                                                    } else {
                                                      return stackCommandesRecord
                                                          .name;
                                                    }
                                                  }(),
                                                  maxLines: 4,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 24.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily),
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.5,
                                                height: 125.0,
                                                decoration: BoxDecoration(
                                                  color: Color(0x00ECF4ED),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 8.0, 0.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      'assets/images/Cook.svg',
                                                      width: 1000.0,
                                                      height: 1000.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FFIcons.klocation1,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .grey1,
                                              size: 18.0,
                                            ),
                                            AuthUserStreamWidget(
                                              builder: (context) => Text(
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
                                                      containerUsersRecord
                                                          .latitude,
                                                      containerUsersRecord
                                                          .longitude),
                                                  'Inconnue',
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
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
                                                                      .titleLargeFamily),
                                                        ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.circle_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .grey1,
                                              size: 6.0,
                                            ),
                                            if (stackCommandesRecord
                                                    .isInstant ==
                                                true)
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    FFIcons.ktimeSquare,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grey1,
                                                    size: 18.0,
                                                  ),
                                                  Text(
                                                    '${stackCommandesRecord.delaiMinutes.toString()} minutes',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
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
                                                                      .titleLargeFamily),
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                            if (stackCommandesRecord
                                                    .isInstant !=
                                                true)
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    FFIcons.ktimeSquare,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grey1,
                                                    size: 18.0,
                                                  ),
                                                  Text(
                                                    'Livraison ${stackCommandesRecord.dateLivraison} (${dateTimeFormat(
                                                      'relative',
                                                      stackCommandesRecord
                                                          .datetimeLivraison,
                                                      locale: FFLocalizations
                                                                  .of(context)
                                                              .languageShortCode ??
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    )})',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLargeFamily,
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
                                                                      .titleLargeFamily),
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 8.0)),
                                              ),
                                          ]
                                              .divide(SizedBox(width: 8.0))
                                              .addToStart(SizedBox(width: 24.0))
                                              .addToEnd(SizedBox(width: 24.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: Builder(
                                          builder: (context) {
                                            final platCommandes =
                                                stackCommandesRecord.plats
                                                    .toList();
                                            return ListView.separated(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: platCommandes.length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 24.0),
                                              itemBuilder: (context,
                                                  platCommandesIndex) {
                                                final platCommandesItem =
                                                    platCommandes[
                                                        platCommandesIndex];
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'Plats_details',
                                                      queryParameters: {
                                                        'plats': serializeParam(
                                                          platCommandesItem,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: ItemCommandesWidget(
                                                    key: Key(
                                                        'Keyljo_${platCommandesIndex}_of_${platCommandes.length}'),
                                                    platRef: platCommandesItem,
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'itemCommandesOnPageLoadAnimation']!);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'vendeur_detail',
                                              pathParameters: {
                                                'seller': serializeParam(
                                                  stackCommandesRecord
                                                      .vendorRef,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: wrapWithModel(
                                            model: _model.userCardModel,
                                            updateCallback: () =>
                                                setState(() {}),
                                            child: UserCardWidget(
                                              userRef: stackCommandesRecord
                                                  .vendorRef!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if ((stackCommandesRecord.isInstant ==
                                              true) &&
                                          functions.calculateTime(
                                              stackCommandesRecord.createdAt!))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (currentUserReference ==
                                                  stackCommandesRecord.buyer)
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    await stackCommandesRecord
                                                        .reference
                                                        .update(
                                                            createCommandesRecordData(
                                                      status: 'Annulée',
                                                      statusNumber: 0,
                                                    ));
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Commande annulée',
                                                      notificationText:
                                                          'Votre commande ${stackCommandesRecord.name} a été annulée',
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        stackCommandesRecord
                                                            .vendorRef!
                                                      ],
                                                      initialPageName:
                                                          'Notifications',
                                                      parameterData: {},
                                                    );

                                                    await NotificationRecord
                                                            .createDoc(
                                                                stackCommandesRecord
                                                                    .vendorRef!)
                                                        .set({
                                                      ...createNotificationRecordData(
                                                        text:
                                                            'Votre commande ${stackCommandesRecord.name} a été annulée par l\'acheteur',
                                                        seenBool: false,
                                                        isCommande: false,
                                                        isChat: false,
                                                        isFriendRequest: false,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'userRef': [
                                                            stackCommandesRecord
                                                                .vendorRef
                                                          ],
                                                          'timestamp': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  text:
                                                      'Annuler votre commande',
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsets.all(0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              if (currentUserReference ==
                                                  stackCommandesRecord
                                                      .vendorRef)
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    await stackCommandesRecord
                                                        .reference
                                                        .update(
                                                            createCommandesRecordData(
                                                      status: 'Annulée',
                                                      statusNumber: 0,
                                                    ));
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Commande annulée',
                                                      notificationText:
                                                          'Votre commande ${stackCommandesRecord.name} a été annulée par le vendeur',
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        stackCommandesRecord
                                                            .buyer!
                                                      ],
                                                      initialPageName:
                                                          'Notifications',
                                                      parameterData: {},
                                                    );

                                                    await NotificationRecord
                                                            .createDoc(
                                                                stackCommandesRecord
                                                                    .buyer!)
                                                        .set({
                                                      ...createNotificationRecordData(
                                                        text:
                                                            'Votre commande ${stackCommandesRecord.name} a été annulée par le vendeur',
                                                        seenBool: false,
                                                        isCommande: false,
                                                        isChat: false,
                                                        isFriendRequest: false,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'userRef': [
                                                            stackCommandesRecord
                                                                .buyer
                                                          ],
                                                          'timestamp': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  text: 'Refuser la commande',
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsets.all(0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                            ].divide(SizedBox(height: 24.0)),
                                          ),
                                        ),
                                      if ((stackCommandesRecord.isInstant ==
                                              false) &&
                                          (functions.calculateTime30(
                                                  stackCommandesRecord
                                                      .createdAt!) ==
                                              true))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if (currentUserReference ==
                                                  stackCommandesRecord.buyer)
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    await stackCommandesRecord
                                                        .reference
                                                        .update(
                                                            createCommandesRecordData(
                                                      status: 'Annulée',
                                                      statusNumber: 0,
                                                    ));
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Commande annulée',
                                                      notificationText:
                                                          'Votre commande ${stackCommandesRecord.name} a été annulée',
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        stackCommandesRecord
                                                            .vendorRef!
                                                      ],
                                                      initialPageName:
                                                          'Notifications',
                                                      parameterData: {},
                                                    );

                                                    await NotificationRecord
                                                            .createDoc(
                                                                stackCommandesRecord
                                                                    .vendorRef!)
                                                        .set({
                                                      ...createNotificationRecordData(
                                                        text:
                                                            'Votre commande ${stackCommandesRecord.name} a été annulée par l\'acheteur',
                                                        seenBool: false,
                                                        isCommande: false,
                                                        isChat: false,
                                                        isFriendRequest: false,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'userRef': [
                                                            stackCommandesRecord
                                                                .vendorRef
                                                          ],
                                                          'timestamp': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  text:
                                                      'Annuler votre commande',
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsets.all(0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              if (currentUserReference ==
                                                  stackCommandesRecord
                                                      .vendorRef)
                                                FFButtonWidget(
                                                  onPressed: () async {
                                                    await stackCommandesRecord
                                                        .reference
                                                        .update(
                                                            createCommandesRecordData(
                                                      status: 'Annulée',
                                                      statusNumber: 0,
                                                    ));
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Commande annulée',
                                                      notificationText:
                                                          'Votre commande ${stackCommandesRecord.name} a été annulée par le vendeur',
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        stackCommandesRecord
                                                            .buyer!
                                                      ],
                                                      initialPageName:
                                                          'Notifications',
                                                      parameterData: {},
                                                    );

                                                    await NotificationRecord
                                                            .createDoc(
                                                                stackCommandesRecord
                                                                    .buyer!)
                                                        .set({
                                                      ...createNotificationRecordData(
                                                        text:
                                                            'Votre commande ${stackCommandesRecord.name} a été annulée par le vendeur',
                                                        seenBool: false,
                                                        isCommande: false,
                                                        isChat: false,
                                                        isFriendRequest: false,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'userRef': [
                                                            stackCommandesRecord
                                                                .buyer
                                                          ],
                                                          'timestamp': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  text: 'Refuser la commande',
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsets.all(0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
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
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                            ].divide(SizedBox(height: 24.0)),
                                          ),
                                        ),
                                      if ((currentUserReference !=
                                              stackCommandesRecord.buyer) &&
                                          (stackCommandesRecord.statusNumber ==
                                              1))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 40.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              await stackCommandesRecord
                                                  .reference
                                                  .update(
                                                      createCommandesRecordData(
                                                status: 'Commande prète',
                                                statusNumber: 2,
                                              ));
                                              triggerPushNotification(
                                                notificationTitle:
                                                    'Votre commande est prète',
                                                notificationText:
                                                    'Bonne nouvelle, votre commande est prète ! Elle vous sera livrée à l\'heure prévue.',
                                                notificationSound: 'default',
                                                userRefs: [
                                                  stackCommandesRecord.buyer!
                                                ],
                                                initialPageName: 'Livraison',
                                                parameterData: {
                                                  'commandeRef':
                                                      widget.commandeRef,
                                                },
                                              );

                                              await NotificationRecord
                                                      .createDoc(
                                                          stackCommandesRecord
                                                              .buyer!)
                                                  .set({
                                                ...createNotificationRecordData(
                                                  text:
                                                      'Votre commande ${stackCommandesRecord.name}est prète ! Elle vous sera livré à l\'heure prévue.',
                                                  seenBool: false,
                                                  isCommande: false,
                                                  isChat: false,
                                                  isFriendRequest: false,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'userRef': [
                                                      stackCommandesRecord.buyer
                                                    ],
                                                    'timestamp': FieldValue
                                                        .serverTimestamp(),
                                                  },
                                                ),
                                              });
                                            },
                                            text: 'La commande est prête',
                                            icon: Icon(
                                              FFIcons.kcook,
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 60.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 8.0, 0.0),
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
                              ),
                            );
                          },
                        ),
                      ),
                    if (stackCommandesRecord.statusNumber == 1)
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.68,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'En attente de la confirmation du paiement',
                                          maxLines: 4,
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLargeFamily,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeFamily),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        height: 125.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x00ECF4ED),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: SvgPicture.asset(
                                              'assets/images/Online_delivery.svg',
                                              width: 1000.0,
                                              height: 1000.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 60.0, 0.0, 0.0),
                                child: Lottie.network(
                                  'https://assets2.lottiefiles.com/packages/lf20_aZTdD5.json',
                                  width: 150.0,
                                  height: 130.0,
                                  fit: BoxFit.cover,
                                  animate: true,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 60.0, 24.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await launchURL(
                                        stackCommandesRecord.paymentUrl);
                                  },
                                  text: 'Recommencer le paiement',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 8.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Votre commande va être annulée'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Retour'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: Text(
                                                          'Annuler ma commande'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      await widget.commandeRef!.delete();

                                      context.pushNamed('Accueil');

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Votre commande a été annulée',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Annuler votre commande',
                                  icon: FaIcon(
                                    FontAwesomeIcons.times,
                                    size: 20.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsets.all(0.0),
                                    color: FlutterFlowTheme.of(context).error,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (stackCommandesRecord.statusNumber == 0)
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.68,
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.75,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          'Le paiement a échoué',
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLargeFamily,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeFamily),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 60.0, 0.0, 0.0),
                                child: Icon(
                                  FFIcons.kcloseSquare,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 200.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 60.0, 24.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await launchURL(
                                        stackCommandesRecord.paymentUrl);
                                  },
                                  text: 'Recommencer le paiement',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 8.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
