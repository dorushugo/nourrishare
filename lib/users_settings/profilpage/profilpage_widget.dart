import '/auth/firebase_auth/auth_util.dart';
import '/components/profil_settings_card_widget.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profilpage_model.dart';
export 'profilpage_model.dart';

class ProfilpageWidget extends StatefulWidget {
  const ProfilpageWidget({Key? key}) : super(key: key);

  @override
  _ProfilpageWidgetState createState() => _ProfilpageWidgetState();
}

class _ProfilpageWidgetState extends State<ProfilpageWidget> {
  late ProfilpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilpageModel());

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

    return Title(
        title: 'Profilpage',
        color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
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
                            24.0, 24.0, 24.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 0.0,
                              child: VerticalDivider(
                                width: 32.0,
                                thickness: 1.0,
                                color: FlutterFlowTheme.of(context).accent4,
                              ),
                            ),
                            Text(
                              'Profil',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleLargeFamily,
                                    fontSize: 24.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleLargeFamily),
                                  ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(1.00, 0.00),
                              child: Icon(
                                FFIcons.ksetting,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 32.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      wrapWithModel(
                        model: _model.profilSettingsCardModel,
                        updateCallback: () => setState(() {}),
                        child: ProfilSettingsCardWidget(),
                      ),
                      Container(
                        height: 620.0,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if ((currentUserDocument?.platsFavoris
                                              ?.toList() ??
                                          [])
                                      .length >
                                  0)
                                AuthUserStreamWidget(
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 24.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Plats favoris',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 20.0,
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
                                            Text(
                                              'Voir tout',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    fontWeight: FontWeight.w900,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily),
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: 272.0,
                                              decoration: BoxDecoration(),
                                              child: Builder(
                                                builder: (context) {
                                                  final platFavoris =
                                                      (currentUserDocument
                                                                  ?.platsFavoris
                                                                  ?.toList() ??
                                                              [])
                                                          .toList()
                                                          .take(10)
                                                          .toList();
                                                  return ListView.separated(
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        platFavoris.length,
                                                    separatorBuilder: (_, __) =>
                                                        SizedBox(width: 16.0),
                                                    itemBuilder: (context,
                                                        platFavorisIndex) {
                                                      final platFavorisItem =
                                                          platFavoris[
                                                              platFavorisIndex];
                                                      return Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.00, 0.00),
                                                        child: Container(
                                                          width: 200.0,
                                                          height: 240.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child:
                                                              PlatsVoisinsWidget(
                                                            key: Key(
                                                                'Keyd7v_${platFavorisIndex}_of_${platFavoris.length}'),
                                                            plat:
                                                                platFavorisItem,
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
                                ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 24.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Plats en ventes',
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLargeFamily,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 272.0,
                                          decoration: BoxDecoration(),
                                          child: AuthUserStreamWidget(
                                            builder: (context) => Builder(
                                              builder: (context) {
                                                final platUser =
                                                    (currentUserDocument?.plats
                                                                ?.toList() ??
                                                            [])
                                                        .toList()
                                                        .take(10)
                                                        .toList();
                                                return ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: platUser.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(width: 16.0),
                                                  itemBuilder:
                                                      (context, platUserIndex) {
                                                    final platUserItem =
                                                        platUser[platUserIndex];
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.00, 0.00),
                                                      child: Container(
                                                        width: 200.0,
                                                        height: 240.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child:
                                                            PlatsVoisinsWidget(
                                                          key: Key(
                                                              'Keyp0w_${platUserIndex}_of_${platUser.length}'),
                                                          plat: platUserItem,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 140.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            GoRouter.of(context).prepareAuthEvent();
                            await authManager.signOut();
                            GoRouter.of(context).clearRedirectLocation();

                            context.goNamedAuth('Connexion', context.mounted);
                          },
                          text: 'Déconnexion',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 56.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).error,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .titleSmallFamily,
                                  color: Colors.white,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
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
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 700.0, 0.0, 0.0),
                  child: wrapWithModel(
                    model: _model.navBar1Model,
                    updateCallback: () => setState(() {}),
                    child: NavBar1Widget(),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
