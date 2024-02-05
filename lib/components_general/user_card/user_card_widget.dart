import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_card_model.dart';
export 'user_card_model.dart';

class UserCardWidget extends StatefulWidget {
  const UserCardWidget({
    super.key,
    required this.userRef,
  });

  final DocumentReference? userRef;

  @override
  State<UserCardWidget> createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget> {
  late UserCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userRef!),
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
        return InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed(
              'vendeur_detail',
              pathParameters: {
                'seller': serializeParam(
                  widget.userRef,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );
          },
          child: Container(
            width: double.infinity,
            height: 80.0,
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
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).secondary,
                            width: 1.0,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(800.0),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 0),
                            fadeOutDuration: Duration(milliseconds: 0),
                            imageUrl: containerUsersRecord.photoUrl,
                            width: 300.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/error_image.png',
                              width: 300.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            containerUsersRecord.displayName
                                .maybeHandleOverflow(
                              maxChars: 20,
                              replacement: '…',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .headlineSmallFamily,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .headlineSmallFamily),
                                ),
                          ),
                          if (containerUsersRecord.cuisinecertifie)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  FFIcons.kchef,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                                Text(
                                  'Cuisine certifiée',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .override(
                                        fontFamily: 'Avenir',
                                        color:
                                            FlutterFlowTheme.of(context).grey2,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w900,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .headlineSmallFamily),
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                        ],
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 10.0,
                    buttonSize: 44.0,
                    fillColor: FlutterFlowTheme.of(context).secondary,
                    icon: Icon(
                      FFIcons.kmenuIcon3,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      size: 20.0,
                    ),
                    onPressed: () async {
                      context.pushNamed(
                        'vendeur_detail',
                        pathParameters: {
                          'seller': serializeParam(
                            widget.userRef,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
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
