import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'mes_plats_model.dart';
export 'mes_plats_model.dart';

class MesPlatsWidget extends StatefulWidget {
  const MesPlatsWidget({
    super.key,
    required this.plat,
  });

  final DocumentReference? plat;

  @override
  State<MesPlatsWidget> createState() => _MesPlatsWidgetState();
}

class _MesPlatsWidgetState extends State<MesPlatsWidget> {
  late MesPlatsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MesPlatsModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((currentUserDocument?.platsFavoris.toList() ?? [])
              .contains(widget.plat) ==
          true) {
        setState(() {
          _model.selecteur = true;
        });
      } else {
        setState(() {
          _model.selecteur = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<PlatsRecord>(
      stream: PlatsRecord.getDocument(widget.plat!),
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
        final containerPlatsRecord = snapshot.data!;
        return InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed(
              'Plats_details',
              queryParameters: {
                'plats': serializeParam(
                  widget.plat,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );
          },
          child: Container(
            width: 200.0,
            height: 240.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 16.0,
                  color: FlutterFlowTheme.of(context).boxShadow,
                  offset: const Offset(0.0, 2.0),
                  spreadRadius: 0.0,
                )
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, -1.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: CachedNetworkImage(
                              fadeInDuration: const Duration(milliseconds: 0),
                              fadeOutDuration: const Duration(milliseconds: 0),
                              imageUrl: containerPlatsRecord.images.first,
                              width: 168.0,
                              height: 128.0,
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/error_image.png',
                                width: 168.0,
                                height: 128.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 8.0, 0.0),
                              child: Container(
                                width: 100.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  color: valueOrDefault<Color>(
                                    () {
                                      if ((containerPlatsRecord.etat <= 4) &&
                                          (containerPlatsRecord.etat > 0)) {
                                        return FlutterFlowTheme.of(context)
                                            .primaryBackground;
                                      } else if (containerPlatsRecord.etat >=
                                          5) {
                                        return FlutterFlowTheme.of(context)
                                            .secondary;
                                      } else {
                                        return FlutterFlowTheme.of(context)
                                            .secondaryBackground;
                                      }
                                    }(),
                                    FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 16.0,
                                      color: FlutterFlowTheme.of(context)
                                          .boxShadow,
                                      offset: const Offset(0.0, 2.0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      () {
                                        if ((containerPlatsRecord.etat <= 4) &&
                                            (containerPlatsRecord.etat > 0)) {
                                          return 'En vente';
                                        } else if (containerPlatsRecord.etat >=
                                            5) {
                                          return 'Vendu';
                                        } else {
                                          return 'Brouillon';
                                        }
                                      }(),
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily,
                                            color: valueOrDefault<Color>(
                                              () {
                                                if ((containerPlatsRecord
                                                            .etat <=
                                                        4) &&
                                                    (containerPlatsRecord.etat >
                                                        0)) {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText;
                                                } else if (containerPlatsRecord
                                                        .etat >=
                                                    5) {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground;
                                                } else {
                                                  return FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText;
                                                }
                                              }(),
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                            ),
                                            fontWeight: FontWeight.w900,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      containerPlatsRecord.name,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleLargeFamily,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).titleLargeFamily),
                          ),
                    ),
                  ),
                  StreamBuilder<UsersRecord>(
                    stream:
                        UsersRecord.getDocument(containerPlatsRecord.seller!),
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
                      final rowUsersRecord = snapshot.data!;
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Text(
                              rowUsersRecord.displayName.maybeHandleOverflow(
                                maxChars: 8,
                                replacement: '…',
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelLargeFamily,
                                    fontSize: 14.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelLargeFamily),
                                  ),
                            ),
                          ),
                          Icon(
                            Icons.circle_sharp,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 4.0,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => Text(
                                valueOrDefault<String>(
                                  functions.calculateDistance(
                                      valueOrDefault(
                                          currentUserDocument?.latitude, 0.0),
                                      valueOrDefault(
                                          currentUserDocument?.longitude, 0.0),
                                      rowUsersRecord.latitude,
                                      rowUsersRecord.longitude),
                                  'Inconnue',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      fontSize: 14.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily),
                                    ),
                              ),
                            ),
                          ),
                        ].divide(const SizedBox(width: 8.0)),
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
