import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components_general/item_commandes/item_commandes_widget.dart';
import '/components_general/proove_shipping/proove_shipping_widget.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
    'itemCommandesOnPageLoadAnimation1': AnimationInfo(
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
    'itemCommandesOnPageLoadAnimation2': AnimationInfo(
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
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.38,
                      child: Stack(
                        children: [
                          Builder(builder: (context) {
                            final googleMapMarker = stackCommandesRecord;
                            return FlutterFlowGoogleMap(
                              controller: _model.googleMapsController,
                              onCameraIdle: (latLng) =>
                                  _model.googleMapsCenter = latLng,
                              initialLocation: _model.googleMapsCenter ??=
                                  stackCommandesRecord.latlngLivraison!,
                              markers: [
                                FlutterFlowMarker(
                                  googleMapMarker.reference.path,
                                  googleMapMarker.latlngLivraison!,
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
                            alignment: const AlignmentDirectional(-1.0, -1.0),
                            child: PointerInterceptor(
                              intercepting: isWeb,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
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
                                      alignment: const AlignmentDirectional(0.0, 0.0),
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
                    if ((stackCommandesRecord.statusNumber == 2) &&
                        (stackCommandesRecord.vendorRef ==
                            currentUserReference))
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
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
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 24.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.5,
                                                decoration: const BoxDecoration(),
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
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.5,
                                                height: 125.0,
                                                decoration: const BoxDecoration(
                                                  color: Color(0x00ECF4ED),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 16.0, 0.0),
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
                                                ].divide(const SizedBox(width: 8.0)),
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
                                                ].divide(const SizedBox(width: 8.0)),
                                              ),
                                          ]
                                              .divide(const SizedBox(width: 8.0))
                                              .addToStart(const SizedBox(width: 24.0))
                                              .addToEnd(const SizedBox(width: 24.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                                  const SizedBox(height: 24.0),
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
                                                    'itemCommandesOnPageLoadAnimation1']!);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
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
                                            model: _model.userCardModel1,
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
                                              const EdgeInsetsDirectional.fromSTEB(
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
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'ot1fovda' /* Annuler votre commande */,
                                                  ),
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsets.all(0.0),
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
                                                    borderSide: const BorderSide(
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
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'vn5whvp4' /* Refuser la commande */,
                                                  ),
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsets.all(0.0),
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
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                            ].divide(const SizedBox(height: 24.0)),
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
                                              const EdgeInsetsDirectional.fromSTEB(
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
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'invpw1w0' /* Annuler votre commande */,
                                                  ),
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsets.all(0.0),
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
                                                    borderSide: const BorderSide(
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
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'huj005x0' /* Refuser la commande */,
                                                  ),
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 20.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsets.all(0.0),
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
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                            ].divide(const SizedBox(height: 24.0)),
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 40.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if ((currentUserReference !=
                                                    stackCommandesRecord
                                                        .buyer) &&
                                                (stackCommandesRecord
                                                        .statusNumber ==
                                                    1))
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
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
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        stackCommandesRecord
                                                            .buyer!
                                                      ],
                                                      initialPageName:
                                                          'Livraison',
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
                                                        isCommande: true,
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
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'ybvtrqsw' /* La commande est prête a être l... */,
                                                  ),
                                                  icon: const Icon(
                                                    FFIcons.kcook,
                                                    size: 15.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                8.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
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
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              ),
                                            if ((currentUserReference !=
                                                    stackCommandesRecord
                                                        .buyer) &&
                                                (stackCommandesRecord
                                                        .statusNumber ==
                                                    2))
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    await launchMap(
                                                      location:
                                                          stackCommandesRecord
                                                              .latlngLivraison,
                                                      title:
                                                          'Adresse livraison',
                                                    );
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '3u0hsqzo' /* Obtenir l'itinéraire */,
                                                  ),
                                                  icon: Icon(
                                                    FFIcons.klocation1,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 15.0,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                8.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .transparent,
                                                    textStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .override(
                                                              fontFamily:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              useGoogleFonts: GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmallFamily),
                                                            ),
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              ),
                                            if ((currentUserReference !=
                                                    stackCommandesRecord
                                                        .buyer) &&
                                                (stackCommandesRecord
                                                        .statusNumber ==
                                                    2))
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Votre commande a été livré',
                                                      notificationText:
                                                          'Votre commande ${stackCommandesRecord.name} viens d\'être livrée ! Si il s\'agit d\'une erreur, vous pouvez contester la livraison.',
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        stackCommandesRecord
                                                            .buyer!
                                                      ],
                                                      initialPageName:
                                                          'Livraison',
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
                                                            'Votre commande ${stackCommandesRecord.name} viens d\'être livrée ! Si il s\'agit d\'une erreur, vous pouvez contester la livraison.',
                                                        seenBool: false,
                                                        isCommande: true,
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
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      barrierColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .backgroundBottomSheet,
                                                      useSafeArea: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return GestureDetector(
                                                          onTap: () => _model
                                                                  .unfocusNode
                                                                  .canRequestFocus
                                                              ? FocusScope.of(
                                                                      context)
                                                                  .requestFocus(
                                                                      _model
                                                                          .unfocusNode)
                                                              : FocusScope.of(
                                                                      context)
                                                                  .unfocus(),
                                                          child: Padding(
                                                            padding: MediaQuery
                                                                .viewInsetsOf(
                                                                    context),
                                                            child: SizedBox(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.75,
                                                              child:
                                                                  ProoveShippingWidget(
                                                                commandeRef: widget
                                                                    .commandeRef!,
                                                                actionProof:
                                                                    () async {
                                                                  await stackCommandesRecord
                                                                      .reference
                                                                      .update(
                                                                          createCommandesRecordData(
                                                                    status:
                                                                        'Commande livrée',
                                                                    statusNumber:
                                                                        3,
                                                                  ));
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        safeSetState(() {}));
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '1tb2hvs0' /* Confirmer la livraison */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: 60.0,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                8.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
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
                                                    borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              ),
                                          ].divide(const SizedBox(height: 24.0)),
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 24.0)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if ((stackCommandesRecord.statusNumber == 1) &&
                        (stackCommandesRecord.vendorRef !=
                            currentUserReference))
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        decoration: const BoxDecoration(),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'd5tuc0nd' /* En attente de la confirmation ... */,
                                          ),
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
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 8.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        height: 125.0,
                                        decoration: const BoxDecoration(
                                          color: Color(0x00ECF4ED),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 60.0, 24.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await launchURL(
                                        stackCommandesRecord.paymentUrl);
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'om83k9q1' /* Recommencer le paiement */,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Votre commande va être annulée'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: const Text('Retour'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: const Text(
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
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'u0kke6rm' /* Annuler votre commande */,
                                  ),
                                  icon: const FaIcon(
                                    FontAwesomeIcons.times,
                                    size: 20.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: const EdgeInsets.all(0.0),
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
                                    borderSide: const BorderSide(
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
                    if ((stackCommandesRecord.statusNumber == 0) &&
                        (stackCommandesRecord.vendorRef !=
                            currentUserReference))
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 24.0, 24.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 24.0, 0.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.75,
                                        decoration: const BoxDecoration(),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'h5lgeann' /* Le paiement a échoué */,
                                          ),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 60.0, 0.0, 0.0),
                                child: Icon(
                                  FFIcons.kcloseSquare,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 200.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 60.0, 24.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await launchURL(
                                        stackCommandesRecord.paymentUrl);
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'cugasmx0' /* Recommencer le paiement */,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 60.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
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
                                    borderSide: const BorderSide(
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
                    if ((stackCommandesRecord.statusNumber == 3) &&
                        (stackCommandesRecord.vendorRef ==
                            currentUserReference))
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
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
                                alignment: const AlignmentDirectional(-1.0, -1.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 24.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.43,
                                                decoration: const BoxDecoration(),
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
                                            if (stackCommandesRecord
                                                    .proofsUrl.isNotEmpty)
                                              Flexible(
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.5,
                                                  height: 100.0,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0x00ECF4ED),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (stackCommandesRecord
                                                              .proofsUrl
                                                              .length ==
                                                          1)
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 100.0,
                                                          child: CarouselSlider(
                                                            items: [
                                                              SizedBox(
                                                                width: 150.0,
                                                                child: Stack(
                                                                  children: [
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          PageTransition(
                                                                            type:
                                                                                PageTransitionType.fade,
                                                                            child:
                                                                                FlutterFlowExpandedImageView(
                                                                              image: Image.network(
                                                                                stackCommandesRecord.proofsUrl.first,
                                                                                fit: BoxFit.contain,
                                                                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                  'assets/images/error_image.png',
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                              allowRotation: false,
                                                                              tag: stackCommandesRecord.proofsUrl.first,
                                                                              useHeroAnimation: true,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Hero(
                                                                        tag: stackCommandesRecord
                                                                            .proofsUrl
                                                                            .first,
                                                                        transitionOnUserGestures:
                                                                            true,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          child:
                                                                              Image.network(
                                                                            stackCommandesRecord.proofsUrl.first,
                                                                            width:
                                                                                double.infinity,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorBuilder: (context, error, stackTrace) =>
                                                                                Image.asset(
                                                                              'assets/images/error_image.png',
                                                                              width: double.infinity,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            8.0,
                                                                            0.0),
                                                                        child:
                                                                            FlutterFlowIconButton(
                                                                          borderColor:
                                                                              FlutterFlowTheme.of(context).transparent,
                                                                          borderRadius:
                                                                              20.0,
                                                                          borderWidth:
                                                                              0.0,
                                                                          buttonSize:
                                                                              36.0,
                                                                          fillColor:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          icon:
                                                                              Icon(
                                                                            FFIcons.kdelete,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            size:
                                                                                18.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            await stackCommandesRecord.reference.update({
                                                                              ...mapToFirestore(
                                                                                {
                                                                                  'proofs_url': FieldValue.arrayRemove([
                                                                                    stackCommandesRecord.proofsUrl.first
                                                                                  ]),
                                                                                },
                                                                              ),
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                            carouselController:
                                                                _model.carouselController1 ??=
                                                                    CarouselController(),
                                                            options:
                                                                CarouselOptions(
                                                              initialPage: 0,
                                                              viewportFraction:
                                                                  1.0,
                                                              disableCenter:
                                                                  false,
                                                              enlargeCenterPage:
                                                                  true,
                                                              enlargeFactor:
                                                                  0.25,
                                                              enableInfiniteScroll:
                                                                  false,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              autoPlay: false,
                                                              onPageChanged:
                                                                  (index, _) =>
                                                                      _model.carouselCurrentIndex1 =
                                                                          index,
                                                            ),
                                                          ),
                                                        ),
                                                      if (stackCommandesRecord
                                                              .proofsUrl
                                                              .length ==
                                                          2)
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 100.0,
                                                          child: CarouselSlider(
                                                            items: [
                                                              Stack(
                                                                children: [
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        PageTransition(
                                                                          type:
                                                                              PageTransitionType.fade,
                                                                          child:
                                                                              FlutterFlowExpandedImageView(
                                                                            image:
                                                                                Image.network(
                                                                              stackCommandesRecord.proofsUrl.first,
                                                                              fit: BoxFit.contain,
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.png',
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                            allowRotation:
                                                                                false,
                                                                            tag:
                                                                                stackCommandesRecord.proofsUrl.first,
                                                                            useHeroAnimation:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Hero(
                                                                      tag: stackCommandesRecord
                                                                          .proofsUrl
                                                                          .first,
                                                                      transitionOnUserGestures:
                                                                          true,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          stackCommandesRecord
                                                                              .proofsUrl
                                                                              .first,
                                                                          width:
                                                                              double.infinity,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.png',
                                                                            width:
                                                                                double.infinity,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          8.0,
                                                                          0.0),
                                                                      child:
                                                                          FlutterFlowIconButton(
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).transparent,
                                                                        borderRadius:
                                                                            20.0,
                                                                        borderWidth:
                                                                            0.0,
                                                                        buttonSize:
                                                                            36.0,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).error,
                                                                        icon:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kdelete,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          size:
                                                                              18.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await stackCommandesRecord
                                                                              .reference
                                                                              .update({
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'proofs_url': FieldValue.arrayRemove([
                                                                                  stackCommandesRecord.proofsUrl.first
                                                                                ]),
                                                                              },
                                                                            ),
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        PageTransition(
                                                                          type:
                                                                              PageTransitionType.fade,
                                                                          child:
                                                                              FlutterFlowExpandedImageView(
                                                                            image:
                                                                                Image.network(
                                                                              stackCommandesRecord.proofsUrl[1],
                                                                              fit: BoxFit.contain,
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.png',
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                            allowRotation:
                                                                                false,
                                                                            tag:
                                                                                stackCommandesRecord.proofsUrl[1],
                                                                            useHeroAnimation:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Hero(
                                                                      tag: stackCommandesRecord
                                                                          .proofsUrl[1],
                                                                      transitionOnUserGestures:
                                                                          true,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          stackCommandesRecord
                                                                              .proofsUrl[1],
                                                                          width:
                                                                              double.infinity,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.png',
                                                                            width:
                                                                                double.infinity,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          8.0,
                                                                          0.0),
                                                                      child:
                                                                          FlutterFlowIconButton(
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).transparent,
                                                                        borderRadius:
                                                                            20.0,
                                                                        borderWidth:
                                                                            0.0,
                                                                        buttonSize:
                                                                            36.0,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).error,
                                                                        icon:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kdelete,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          size:
                                                                              18.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await stackCommandesRecord
                                                                              .reference
                                                                              .update({
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'proofs_url': FieldValue.arrayRemove([
                                                                                  stackCommandesRecord.proofsUrl[1]
                                                                                ]),
                                                                              },
                                                                            ),
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                            carouselController:
                                                                _model.carouselController2 ??=
                                                                    CarouselController(),
                                                            options:
                                                                CarouselOptions(
                                                              initialPage: 0,
                                                              viewportFraction:
                                                                  1.0,
                                                              disableCenter:
                                                                  false,
                                                              enlargeCenterPage:
                                                                  true,
                                                              enlargeFactor:
                                                                  0.25,
                                                              enableInfiniteScroll:
                                                                  true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              autoPlay: false,
                                                              onPageChanged:
                                                                  (index, _) =>
                                                                      _model.carouselCurrentIndex2 =
                                                                          index,
                                                            ),
                                                          ),
                                                        ),
                                                      if (stackCommandesRecord
                                                              .proofsUrl
                                                              .length ==
                                                          3)
                                                        SizedBox(
                                                          width:
                                                              double.infinity,
                                                          height: 100.0,
                                                          child: CarouselSlider(
                                                            items: [
                                                              Stack(
                                                                children: [
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        PageTransition(
                                                                          type:
                                                                              PageTransitionType.fade,
                                                                          child:
                                                                              FlutterFlowExpandedImageView(
                                                                            image:
                                                                                Image.network(
                                                                              stackCommandesRecord.proofsUrl.first,
                                                                              fit: BoxFit.contain,
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.png',
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                            allowRotation:
                                                                                false,
                                                                            tag:
                                                                                stackCommandesRecord.proofsUrl.first,
                                                                            useHeroAnimation:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Hero(
                                                                      tag: stackCommandesRecord
                                                                          .proofsUrl
                                                                          .first,
                                                                      transitionOnUserGestures:
                                                                          true,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          stackCommandesRecord
                                                                              .proofsUrl
                                                                              .first,
                                                                          width:
                                                                              300.0,
                                                                          height:
                                                                              200.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.png',
                                                                            width:
                                                                                300.0,
                                                                            height:
                                                                                200.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          8.0,
                                                                          0.0),
                                                                      child:
                                                                          FlutterFlowIconButton(
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).transparent,
                                                                        borderRadius:
                                                                            20.0,
                                                                        borderWidth:
                                                                            0.0,
                                                                        buttonSize:
                                                                            36.0,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).error,
                                                                        icon:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kdelete,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          size:
                                                                              18.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await stackCommandesRecord
                                                                              .reference
                                                                              .update({
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'proofs_url': FieldValue.arrayRemove([
                                                                                  stackCommandesRecord.proofsUrl.first
                                                                                ]),
                                                                              },
                                                                            ),
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        PageTransition(
                                                                          type:
                                                                              PageTransitionType.fade,
                                                                          child:
                                                                              FlutterFlowExpandedImageView(
                                                                            image:
                                                                                Image.network(
                                                                              stackCommandesRecord.proofsUrl[1],
                                                                              fit: BoxFit.contain,
                                                                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                'assets/images/error_image.png',
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                            allowRotation:
                                                                                false,
                                                                            tag:
                                                                                stackCommandesRecord.proofsUrl[1],
                                                                            useHeroAnimation:
                                                                                true,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Hero(
                                                                      tag: stackCommandesRecord
                                                                          .proofsUrl[1],
                                                                      transitionOnUserGestures:
                                                                          true,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .network(
                                                                          stackCommandesRecord
                                                                              .proofsUrl[1],
                                                                          width:
                                                                              300.0,
                                                                          height:
                                                                              200.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.png',
                                                                            width:
                                                                                300.0,
                                                                            height:
                                                                                200.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        const AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          8.0,
                                                                          0.0),
                                                                      child:
                                                                          FlutterFlowIconButton(
                                                                        borderColor:
                                                                            FlutterFlowTheme.of(context).transparent,
                                                                        borderRadius:
                                                                            20.0,
                                                                        borderWidth:
                                                                            0.0,
                                                                        buttonSize:
                                                                            36.0,
                                                                        fillColor:
                                                                            FlutterFlowTheme.of(context).error,
                                                                        icon:
                                                                            Icon(
                                                                          FFIcons
                                                                              .kdelete,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          size:
                                                                              18.0,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await stackCommandesRecord
                                                                              .reference
                                                                              .update({
                                                                            ...mapToFirestore(
                                                                              {
                                                                                'proofs_url': FieldValue.arrayRemove([
                                                                                  stackCommandesRecord.proofsUrl[1]
                                                                                ]),
                                                                              },
                                                                            ),
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Visibility(
                                                                visible: stackCommandesRecord
                                                                        .proofsUrl
                                                                        .length >=
                                                                    3,
                                                                child: Stack(
                                                                  children: [
                                                                    InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          PageTransition(
                                                                            type:
                                                                                PageTransitionType.fade,
                                                                            child:
                                                                                FlutterFlowExpandedImageView(
                                                                              image: Image.network(
                                                                                stackCommandesRecord.proofsUrl[2],
                                                                                fit: BoxFit.contain,
                                                                                errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                  'assets/images/error_image.png',
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                              allowRotation: false,
                                                                              tag: stackCommandesRecord.proofsUrl[2],
                                                                              useHeroAnimation: true,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Hero(
                                                                        tag: stackCommandesRecord
                                                                            .proofsUrl[2],
                                                                        transitionOnUserGestures:
                                                                            true,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          child:
                                                                              Image.network(
                                                                            stackCommandesRecord.proofsUrl[2],
                                                                            width:
                                                                                300.0,
                                                                            height:
                                                                                200.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            errorBuilder: (context, error, stackTrace) =>
                                                                                Image.asset(
                                                                              'assets/images/error_image.png',
                                                                              width: 300.0,
                                                                              height: 200.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          const AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            8.0,
                                                                            0.0),
                                                                        child:
                                                                            FlutterFlowIconButton(
                                                                          borderColor:
                                                                              FlutterFlowTheme.of(context).transparent,
                                                                          borderRadius:
                                                                              20.0,
                                                                          borderWidth:
                                                                              0.0,
                                                                          buttonSize:
                                                                              36.0,
                                                                          fillColor:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          icon:
                                                                              Icon(
                                                                            FFIcons.kdelete,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            size:
                                                                                18.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            await stackCommandesRecord.reference.update({
                                                                              ...mapToFirestore(
                                                                                {
                                                                                  'proofs_url': FieldValue.arrayRemove([
                                                                                    stackCommandesRecord.proofsUrl[2]
                                                                                  ]),
                                                                                },
                                                                              ),
                                                                            });
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                            carouselController:
                                                                _model.carouselController3 ??=
                                                                    CarouselController(),
                                                            options:
                                                                CarouselOptions(
                                                              initialPage: 0,
                                                              viewportFraction:
                                                                  1.0,
                                                              disableCenter:
                                                                  false,
                                                              enlargeCenterPage:
                                                                  true,
                                                              enlargeFactor:
                                                                  0.25,
                                                              enableInfiniteScroll:
                                                                  true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              autoPlay: false,
                                                              onPageChanged:
                                                                  (index, _) =>
                                                                      _model.carouselCurrentIndex3 =
                                                                          index,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ]
                                              .divide(const SizedBox(width: 24.0))
                                              .around(const SizedBox(width: 24.0)),
                                        ),
                                      ),
                                      if (stackCommandesRecord
                                              .proofsUrl.length <
                                          3)
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              final selectedMedia =
                                                  await selectMediaWithSourceBottomSheet(
                                                context: context,
                                                maxWidth: 1920.00,
                                                maxHeight: 1080.00,
                                                imageQuality: 67,
                                                allowPhoto: true,
                                                allowVideo: true,
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                setState(() => _model
                                                    .isDataUploading = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                var downloadUrls = <String>[];
                                                try {
                                                  showUploadMessage(
                                                    context,
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'a05hq3iz' /* Téléchargement du fichier */,
                                                    ),
                                                    showLoading: true,
                                                  );
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();

                                                  downloadUrls =
                                                      (await Future.wait(
                                                    selectedMedia.map(
                                                      (m) async =>
                                                          await uploadData(
                                                              m.storagePath,
                                                              m.bytes),
                                                    ),
                                                  ))
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  _model.isDataUploading =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  setState(() {
                                                    _model.uploadedLocalFile =
                                                        selectedUploadedFiles
                                                            .first;
                                                    _model.uploadedFileUrl =
                                                        downloadUrls.first;
                                                  });
                                                  showUploadMessage(
                                                      context,
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'yjwesk6d' /* Fichier téléchargé !  */,
                                                      ));
                                                } else {
                                                  setState(() {});
                                                  showUploadMessage(
                                                      context,
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'pbrnslxi' /* Le téléchargement a échoué. */,
                                                      ));
                                                  return;
                                                }
                                              }

                                              if (_model.uploadedFileUrl !=
                                                      '') {
                                                await widget.commandeRef!
                                                    .update({
                                                  ...createCommandesRecordData(
                                                    asProof: true,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'proofs_url': FieldValue
                                                          .arrayUnion([
                                                        _model.uploadedFileUrl
                                                      ]),
                                                    },
                                                  ),
                                                });
                                              }
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              '14q1y2mw' /* Ajouter une photo de livraison */,
                                            ),
                                            icon: const Icon(
                                              FFIcons.kimage3,
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 54.0,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
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
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
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
                                                ].divide(const SizedBox(width: 8.0)),
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
                                                ].divide(const SizedBox(width: 8.0)),
                                              ),
                                          ]
                                              .divide(const SizedBox(width: 8.0))
                                              .addToStart(const SizedBox(width: 24.0))
                                              .addToEnd(const SizedBox(width: 24.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: Builder(
                                          builder: (context) {
                                            final platCommandes =
                                                stackCommandesRecord.plats
                                                    .toList();
                                            return ListView.separated(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: platCommandes.length,
                                              separatorBuilder: (_, __) =>
                                                  const SizedBox(height: 24.0),
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
                                                        'Keymsv_${platCommandesIndex}_of_${platCommandes.length}'),
                                                    platRef: platCommandesItem,
                                                  ),
                                                ).animateOnPageLoad(animationsMap[
                                                    'itemCommandesOnPageLoadAnimation2']!);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 40.0),
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
                                            model: _model.userCardModel2,
                                            updateCallback: () =>
                                                setState(() {}),
                                            child: UserCardWidget(
                                              userRef: stackCommandesRecord
                                                  .vendorRef!,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 24.0)),
                                  ),
                                ),
                              ),
                            );
                          },
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
