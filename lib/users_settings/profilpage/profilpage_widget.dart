import '/auth/firebase_auth/auth_util.dart';
import '/components_general/mes_plats/mes_plats_widget.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/components_general/no_plats_favoris/no_plats_favoris_widget.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/components_general/profil_settings_card/profil_settings_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profilpage_model.dart';
export 'profilpage_model.dart';

class ProfilpageWidget extends StatefulWidget {
  const ProfilpageWidget({super.key});

  @override
  State<ProfilpageWidget> createState() => _ProfilpageWidgetState();
}

class _ProfilpageWidgetState extends State<ProfilpageWidget> {
  late ProfilpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilpageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                    child: wrapWithModel(
                      model: _model.profilSettingsCardModel,
                      updateCallback: () => setState(() {}),
                      child: const ProfilSettingsCardWidget(),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'rod7jq2g' /* Plats favoris */,
                                      ),
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
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 272.0,
                                    decoration: const BoxDecoration(),
                                    child: AuthUserStreamWidget(
                                      builder: (context) => Builder(
                                        builder: (context) {
                                          final platFavoris =
                                              (currentUserDocument?.platsFavoris
                                                          .toList() ??
                                                      [])
                                                  .toList()
                                                  .take(100)
                                                  .toList();
                                          if (platFavoris.isEmpty) {
                                            return const NoPlatsFavorisWidget();
                                          }
                                          return ListView.separated(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0),
                                            primary: false,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: platFavoris.length,
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(width: 24.0),
                                            itemBuilder:
                                                (context, platFavorisIndex) {
                                              final platFavorisItem =
                                                  platFavoris[platFavorisIndex];
                                              return Align(
                                                alignment: const AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Container(
                                                  width: 200.0,
                                                  height: 240.0,
                                                  decoration: const BoxDecoration(),
                                                  child: PlatsVoisinsWidget(
                                                    key: Key(
                                                        'Keyd7v_${platFavorisIndex}_of_${platFavoris.length}'),
                                                    plat: platFavorisItem,
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
                        if ((currentUserDocument?.plats.toList() ?? []).isNotEmpty)
                          AuthUserStreamWidget(
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 24.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'uowi0qc1' /* Plats en ventes */,
                                          ),
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
                                        decoration: const BoxDecoration(),
                                        child: Builder(
                                          builder: (context) {
                                            final platUser =
                                                (currentUserDocument?.plats
                                                            .toList() ??
                                                        [])
                                                    .toList()
                                                    .take(100)
                                                    .toList();
                                            return ListView.separated(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 24.0),
                                              primary: false,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: platUser.length,
                                              separatorBuilder: (_, __) =>
                                                  const SizedBox(width: 24.0),
                                              itemBuilder:
                                                  (context, platUserIndex) {
                                                final platUserItem =
                                                    platUser[platUserIndex];
                                                return Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Container(
                                                    width: 200.0,
                                                    height: 240.0,
                                                    decoration: const BoxDecoration(),
                                                    child: MesPlatsWidget(
                                                      key: Key(
                                                          'Key9dm_${platUserIndex}_of_${platUser.length}'),
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        context.goNamedAuth('Onboarding', context.mounted);
                      },
                      text: FFLocalizations.of(context).getText(
                        't569y3uk' /* Déconnexion */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 56.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).error,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).titleSmallFamily,
                              color: Colors.white,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
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
                  if (valueOrDefault<bool>(
                          currentUserDocument?.stripChargesEnabled, false) ==
                      false)
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed('stripeCompletion');
                          },
                          text: FFLocalizations.of(context).getText(
                            'kb9vgzb9' /* Activer les paiements */,
                          ),
                          icon: const Icon(
                            FFIcons.klock,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 56.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
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
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 200.0,
                    child: Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).grey3,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 140.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text(
                                      'En continuant, vous supprimerez votre compte.'),
                                  content: const Text(
                                      'Vos informations seront supprimés. Cette action est irréversible.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: const Text('Annuler'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: const Text('Supprimer mon compte'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          await authManager.deleteUser(context);
                          GoRouter.of(context).prepareAuthEvent();
                          await authManager.signOut();
                          GoRouter.of(context).clearRedirectLocation();
                        }

                        context.goNamedAuth('Onboarding', context.mounted);
                      },
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '0zolelaj' /* Supprimer mon compte */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                              color: FlutterFlowTheme.of(context).error,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .bodyMediumFamily),
                            ),
                      ),
                    ),
                  ),
                ].divide(const SizedBox(height: 24.0)),
              ),
            ),
            wrapWithModel(
              model: _model.navBar1Model,
              updateCallback: () => setState(() {}),
              child: const NavBar1Widget(),
            ),
          ],
        ),
      ),
    );
  }
}
