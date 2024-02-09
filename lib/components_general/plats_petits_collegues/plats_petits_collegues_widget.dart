import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plats_petits_collegues_model.dart';
export 'plats_petits_collegues_model.dart';

class PlatsPetitsColleguesWidget extends StatefulWidget {
  const PlatsPetitsColleguesWidget({
    super.key,
    required this.plat,
  });

  final DocumentReference? plat;

  @override
  State<PlatsPetitsColleguesWidget> createState() =>
      _PlatsPetitsColleguesWidgetState();
}

class _PlatsPetitsColleguesWidgetState
    extends State<PlatsPetitsColleguesWidget> {
  late PlatsPetitsColleguesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlatsPetitsColleguesModel());

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
            width: 156.0,
            height: 200.0,
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
                              width: 132.0,
                              height: 88.0,
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/error_image.png',
                                width: 132.0,
                                height: 88.0,
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
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
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
                                child: ToggleIcon(
                                  onPressed: () async {
                                    setState(() =>
                                        _model.selecteur = !_model.selecteur);
                                    if ((currentUserDocument?.platsFavoris
                                                    .toList() ??
                                                [])
                                            .contains(containerPlatsRecord
                                                .reference) ==
                                        true) {
                                      await currentUserReference!.update({
                                        ...mapToFirestore(
                                          {
                                            'plats_favoris':
                                                FieldValue.arrayRemove([
                                              containerPlatsRecord.reference
                                            ]),
                                          },
                                        ),
                                      });
                                      setState(() {
                                        _model.selecteur = false;
                                      });
                                    } else {
                                      await currentUserReference!.update({
                                        ...mapToFirestore(
                                          {
                                            'plats_favoris':
                                                FieldValue.arrayUnion([
                                              containerPlatsRecord.reference
                                            ]),
                                          },
                                        ),
                                      });
                                      setState(() {
                                        _model.selecteur = true;
                                      });
                                    }
                                  },
                                  value: _model.selecteur,
                                  onIcon: Icon(
                                    FFIcons.kheart2,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 15.0,
                                  ),
                                  offIcon: Icon(
                                    FFIcons.kheart,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 15.0,
                                  ),
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
                                maxChars: 10,
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
