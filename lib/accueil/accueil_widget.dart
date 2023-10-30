import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/ingredients_voisins/ingredients_voisins_widget.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/components_general/profil_card/profil_card_widget.dart';
import '/components_general/switchpage/switchpage_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'accueil_model.dart';
export 'accueil_model.dart';

class AccueilWidget extends StatefulWidget {
  const AccueilWidget({Key? key}) : super(key: key);

  @override
  _AccueilWidgetState createState() => _AccueilWidgetState();
}

class _AccueilWidgetState extends State<AccueilWidget> {
  late AccueilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccueilModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
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

    return Title(
        title: 'Accueil',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
        child: GestureDetector(
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
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          child: wrapWithModel(
                            model: _model.profilCardModel,
                            updateCallback: () => setState(() {}),
                            child: ProfilCardWidget(
                              userRef: currentUserReference!,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 8.0, 24.0, 0.0),
                          child: wrapWithModel(
                            model: _model.switchpageModel,
                            updateCallback: () => setState(() {}),
                            child: SwitchpageWidget(),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Plats proches de vous',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleLargeFamily,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w900,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleLargeFamily),
                                        ),
                                  ),
                                  Text(
                                    'Voir tout',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FutureBuilder<List<UsersRecord>>(
                                    future: UsersRecord.search(
                                      location: getCurrentUserLocation(
                                          defaultLocation:
                                              LatLng(37.4298229, -122.1735655)),
                                      maxResults: 10,
                                      searchRadiusMeters: 10000.0,
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<UsersRecord>
                                          containerUsersRecordList =
                                          snapshot.data!;
                                      return Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 272.0,
                                        decoration: BoxDecoration(),
                                        child: StreamBuilder<List<PlatsRecord>>(
                                          stream: queryPlatsRecord(
                                            queryBuilder: (platsRecord) =>
                                                platsRecord
                                                    .whereIn(
                                                        'Seller',
                                                        containerUsersRecordList
                                                            .map((e) =>
                                                                e.reference)
                                                            .toList())
                                                    .where(
                                                      'Etat',
                                                      isGreaterThan: 1,
                                                    )
                                                    .where(
                                                      'Etat',
                                                      isLessThan: 4,
                                                    ),
                                            limit: 20,
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<PlatsRecord>
                                                listViewPlatsRecordList =
                                                snapshot.data!;
                                            return ListView.separated(
                                              padding: EdgeInsets.fromLTRB(
                                                24.0,
                                                0,
                                                0,
                                                0,
                                              ),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: listViewPlatsRecordList
                                                  .length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(width: 16.0),
                                              itemBuilder:
                                                  (context, listViewIndex) {
                                                final listViewPlatsRecord =
                                                    listViewPlatsRecordList[
                                                        listViewIndex];
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.00, 0.00),
                                                  child: Container(
                                                    width: 200.0,
                                                    height: 240.0,
                                                    decoration: BoxDecoration(),
                                                    child: PlatsVoisinsWidget(
                                                      key: Key(
                                                          'Keyv4o_${listViewIndex}_of_${listViewPlatsRecordList.length}'),
                                                      plat: listViewPlatsRecord
                                                          .reference,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ingrédients proches de vous',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .titleLargeFamily,
                                          fontSize: 20.0,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .titleLargeFamily),
                                        ),
                                  ),
                                  Text(
                                    'Voir tout',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 220.0,
                                    decoration: BoxDecoration(),
                                    child: StreamBuilder<List<PlatsRecord>>(
                                      stream: queryPlatsRecord(
                                        limit: 15,
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<PlatsRecord>
                                            listViewPlatsRecordList =
                                            snapshot.data!;
                                        return ListView.separated(
                                          padding: EdgeInsets.fromLTRB(
                                            24.0,
                                            0,
                                            0,
                                            0,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              listViewPlatsRecordList.length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(width: 16.0),
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewPlatsRecord =
                                                listViewPlatsRecordList[
                                                    listViewIndex];
                                            return Align(
                                              alignment: AlignmentDirectional(
                                                  -1.00, 0.00),
                                              child: Container(
                                                width: 156.0,
                                                height: 200.0,
                                                decoration: BoxDecoration(),
                                                child: IngredientsVoisinsWidget(
                                                  key: Key(
                                                      'Keyxkj_${listViewIndex}_of_${listViewPlatsRecordList.length}'),
                                                  plat: listViewPlatsRecord
                                                      .reference,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, 1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 650.0, 0.0, 0.0),
                      child: wrapWithModel(
                        model: _model.navBar1Model,
                        updateCallback: () => setState(() {}),
                        child: NavBar1Widget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
