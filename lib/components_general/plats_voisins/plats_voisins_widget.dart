import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plats_voisins_model.dart';
export 'plats_voisins_model.dart';

class PlatsVoisinsWidget extends StatefulWidget {
  const PlatsVoisinsWidget({
    Key? key,
    required this.plat,
  }) : super(key: key);

  final DocumentReference? plat;

  @override
  _PlatsVoisinsWidgetState createState() => _PlatsVoisinsWidgetState();
}

class _PlatsVoisinsWidgetState extends State<PlatsVoisinsWidget> {
  late PlatsVoisinsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlatsVoisinsModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
                  offset: Offset(0.0, 2.0),
                  spreadRadius: 0.0,
                )
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              containerPlatsRecord.images.first,
                              width: 168.0,
                              height: 128.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(1.00, -1.00),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 8.0, 0.0),
                              child: Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(1.00, -1.00),
                                  child: ToggleIcon(
                                    onPressed: () async {
                                      setState(() =>
                                          _model.selecteur = !_model.selecteur);
                                    },
                                    value: _model.selecteur,
                                    onIcon: Icon(
                                      FFIcons.kheart,
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.00, 0.00),
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
                            alignment: AlignmentDirectional(-1.00, 0.00),
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
                            alignment: AlignmentDirectional(-1.00, 0.00),
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
                        ].divide(SizedBox(width: 8.0)),
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
