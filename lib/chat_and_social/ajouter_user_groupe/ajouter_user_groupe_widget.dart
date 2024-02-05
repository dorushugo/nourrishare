import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/nav_bar1/nav_bar1_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'ajouter_user_groupe_model.dart';
export 'ajouter_user_groupe_model.dart';

class AjouterUserGroupeWidget extends StatefulWidget {
  const AjouterUserGroupeWidget({
    super.key,
    required this.group,
  });

  final DocumentReference? group;

  @override
  State<AjouterUserGroupeWidget> createState() =>
      _AjouterUserGroupeWidgetState();
}

class _AjouterUserGroupeWidgetState extends State<AjouterUserGroupeWidget> {
  late AjouterUserGroupeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AjouterUserGroupeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      currentUserLocationValue =
          await getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0));
      safeSetState(() => _model.algoliaSearchResults = null);
      await UsersRecord.search(
        location: getCurrentUserLocation(
            defaultLocation: LatLng(37.4298229, -122.1735655)),
        maxResults: 6,
        searchRadiusMeters: 10000.0,
      )
          .then((r) => _model.algoliaSearchResults = r)
          .onError((_, __) => _model.algoliaSearchResults = [])
          .whenComplete(() => setState(() {}));
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 54.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF57636C),
              size: 24.0,
            ),
            onPressed: () async {
              context.pushNamed(
                'group_detail',
                queryParameters: {
                  'groupRef': serializeParam(
                    widget.group,
                    ParamType.DocumentReference,
                  ),
                }.withoutNulls,
              );
            },
          ),
          title: Text(
            'Ajouter au groupe',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Outfit',
                  color: Color(0xFF14181B),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineSmallFamily),
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              wrapWithModel(
                model: _model.navBar1Model,
                updateCallback: () => setState(() {}),
                child: NavBar1Widget(),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 100.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 8.0, 24.0, 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.textController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      setState(() => _model
                                          .algoliaRequestCompleter = null);
                                      await _model
                                          .waitForAlgoliaRequestCompleted();
                                    },
                                  ),
                                  onFieldSubmitted: (_) async {
                                    setState(() =>
                                        _model.algoliaRequestCompleter = null);
                                    await _model
                                        .waitForAlgoliaRequestCompleted();
                                  },
                                  textInputAction: TextInputAction.search,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Rechercher un groupe ou un utilisateur',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF4B39EF),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF14181B),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  borderWidth: 1.0,
                                  buttonSize: 44.0,
                                  icon: Icon(
                                    Icons.search_rounded,
                                    color: Color(0xFF14181B),
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Text(
                          'Utilisateurs',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF57636C),
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .labelMediumFamily),
                              ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 12.0, 24.0, 44.0),
                          child: AuthUserStreamWidget(
                            builder: (context) =>
                                FutureBuilder<List<UsersRecord>>(
                              future: (_model.algoliaRequestCompleter ??=
                                      Completer<List<UsersRecord>>()
                                        ..complete(UsersRecord.search(
                                          term: valueOrDefault<String>(
                                            _model.textController.text,
                                            '*',
                                          ),
                                          location:
                                              currentUserDocument?.latlong,
                                          maxResults: 8,
                                          searchRadiusMeters: 10000.0,
                                        )))
                                  .future,
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
                                List<UsersRecord> listViewUsersRecordList =
                                    snapshot.data!;
                                // Customize what your widget looks like with no search results.
                                if (snapshot.data!.isEmpty) {
                                  return Container(
                                    height: 100,
                                    child: Center(
                                      child: Text('No results.'),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewUsersRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewUsersRecord =
                                        listViewUsersRecordList[listViewIndex];
                                    return Visibility(
                                      visible: listViewUsersRecord.reference !=
                                          currentUserReference,
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 8.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 60.0,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4.0,
                                                color: Color(0x32000000),
                                                offset: Offset(0.0, 2.0),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          26.0),
                                                  child: Image.network(
                                                    listViewUsersRecord
                                                        .photoUrl,
                                                    width: 36.0,
                                                    height: 36.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/error_image.png',
                                                      width: 36.0,
                                                      height: 36.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          listViewUsersRecord
                                                              .displayName,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Plus Jakarta Sans',
                                                                color: Color(
                                                                    0xFF14181B),
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyMediumFamily),
                                                              ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions.calculateDistance(
                                                                      listViewUsersRecord
                                                                          .latitude,
                                                                      listViewUsersRecord
                                                                          .longitude,
                                                                      valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.latitude,
                                                                          0.0),
                                                                      valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.longitude,
                                                                          0.0)),
                                                                  'Inconnue',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Plus Jakarta Sans',
                                                                      color: Color(
                                                                          0xFF57636C),
                                                                      fontSize:
                                                                          14.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).labelMediumFamily),
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity
                                                              .standard,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .padded,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                    ),
                                                    unselectedWidgetColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondaryText,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                                .checkboxValueMap[
                                                            listViewUsersRecord] ??=
                                                        listViewUsersRecord
                                                                .groupes
                                                                .contains(widget
                                                                    .group)
                                                            ? true
                                                            : false,
                                                    onChanged:
                                                        (newValue) async {
                                                      setState(() => _model
                                                                  .checkboxValueMap[
                                                              listViewUsersRecord] =
                                                          newValue!);
                                                    },
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                    checkColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            while (_model.compteurUser <=
                                _model.checkboxCheckedItems.length) {
                              // Ajouter le User dans le groupe.

                              await widget.group!.update({
                                ...mapToFirestore(
                                  {
                                    'Users': FieldValue.arrayUnion([
                                      _model
                                          .checkboxCheckedItems[
                                              _model.compteurUser]
                                          .reference
                                    ]),
                                  },
                                ),
                              });
                              // Ajouter le groupe dans le champ User

                              await _model
                                  .checkboxCheckedItems[_model.compteurUser]
                                  .reference
                                  .update({
                                ...mapToFirestore(
                                  {
                                    'groupes':
                                        FieldValue.arrayUnion([widget.group]),
                                  },
                                ),
                              });
                              _model.compteurUser = _model.compteurUser + 1;
                            }
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Utilisateurs ajoutés'),
                                  content: Text(
                                      '${_model.compteurUser.toString()} utilisateurs ont été ajoutés'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                            _model.compteurUser = 0;
                          },
                          text: 'Ajouter les membres',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 60.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
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
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 8.0, 24.0, 40.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              await Share.share(
                                'J\'ai crée un groupe sur NourriShare, rejoins moi sur l\'application ! Installe l\'application ici : https://nourrishare.com.Puis clique ici pour rejoindre le groupe : ',
                                sharePositionOrigin:
                                    getWidgetBoundingBox(context),
                              );
                            },
                            text: 'Partager le lien d\'invitation',
                            icon: Icon(
                              Icons.ios_share,
                              size: 20.0,
                            ),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 60.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 4.0, 0.0),
                              color: FlutterFlowTheme.of(context).transparent,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .titleSmallFamily,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .titleSmallFamily),
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
