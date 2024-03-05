import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/aucunelement/aucunelement_widget.dart';
import '/components_general/no_ingredient/no_ingredient_widget.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'group_detail_model.dart';
export 'group_detail_model.dart';

class GroupDetailWidget extends StatefulWidget {
  const GroupDetailWidget({
    super.key,
    required this.groupRef,
  });

  final DocumentReference? groupRef;

  @override
  State<GroupDetailWidget> createState() => _GroupDetailWidgetState();
}

class _GroupDetailWidgetState extends State<GroupDetailWidget> {
  late GroupDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GroupDetailModel());
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
          child: StreamBuilder<GroupesRecord>(
            stream: GroupesRecord.getDocument(widget.groupRef!),
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
              final stackGroupesRecord = snapshot.data!;
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      decoration: const BoxDecoration(),
                      child: Builder(builder: (context) {
                        final googleMapMarker = stackGroupesRecord.latlng;
                        return FlutterFlowGoogleMap(
                          controller: _model.googleMapsController,
                          onCameraIdle: (latLng) =>
                              _model.googleMapsCenter = latLng,
                          initialLocation: _model.googleMapsCenter ??=
                              stackGroupesRecord.latlng!,
                          markers: [
                            if (googleMapMarker != null)
                              FlutterFlowMarker(
                                googleMapMarker.serialize(),
                                googleMapMarker,
                              ),
                          ],
                          markerColor: GoogleMarkerColor.green,
                          mapType: MapType.normal,
                          style: GoogleMapStyle.standard,
                          initialZoom: 11.0,
                          allowInteraction: true,
                          allowZoom: true,
                          showZoomControls: false,
                          showLocation: true,
                          showCompass: false,
                          showMapToolbar: false,
                          showTraffic: false,
                          centerMapOnMarkerTap: false,
                        );
                      }),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: StreamBuilder<List<UsersRecord>>(
                        stream: queryUsersRecord(
                          queryBuilder: (usersRecord) => usersRecord.where(
                            'groupes',
                            arrayContains: widget.groupRef,
                          ),
                          limit: 1000,
                        ),
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
                          List<UsersRecord> containerUsersRecordList = snapshot
                              .data!
                              .where((u) => u.uid != currentUserUid)
                              .toList();
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.6,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0),
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1.0, -1.0),
                              child: SingleChildScrollView(
                                primary: false,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 24.0, 24.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.55,
                                            decoration: const BoxDecoration(),
                                            child: Text(
                                              stackGroupesRecord.displayName,
                                              maxLines: 2,
                                              style:
                                                  FlutterFlowTheme.of(context)
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
                                          if (stackGroupesRecord.users
                                              .contains(currentUserReference))
                                            FFButtonWidget(
                                              onPressed: () async {
                                                _model.chatDuGroupe2 =
                                                    await queryChatsRecordCount(
                                                  queryBuilder: (chatsRecord) =>
                                                      chatsRecord.where(
                                                    'group_ref',
                                                    isEqualTo:
                                                        stackGroupesRecord
                                                            .reference,
                                                  ),
                                                );
                                                if (_model.chatDuGroupe2 != 0) {
                                                  _model.chatDuGroupeItem =
                                                      await queryChatsRecordOnce(
                                                    queryBuilder:
                                                        (chatsRecord) =>
                                                            chatsRecord.where(
                                                      'group_ref',
                                                      isEqualTo:
                                                          stackGroupesRecord
                                                              .reference,
                                                    ),
                                                    singleRecord: true,
                                                  ).then((s) => s.firstOrNull);

                                                  context.goNamed(
                                                    'chatGroupPage',
                                                    queryParameters: {
                                                      'chat': serializeParam(
                                                        _model.chatDuGroupeItem
                                                            ?.reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                      'group': serializeParam(
                                                        stackGroupesRecord
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                } else {
                                                  var chatsRecordReference =
                                                      ChatsRecord.collection
                                                          .doc();
                                                  await chatsRecordReference
                                                      .set({
                                                    ...createChatsRecordData(
                                                      lastMessage:
                                                          'Nouvelle conversation',
                                                      lastMessageTime:
                                                          getCurrentTimestamp,
                                                      lastMessageSentBy:
                                                          currentUserReference,
                                                      lastMessageSeenBy:
                                                          currentUserReference,
                                                      groupeChat: true,
                                                      groupRef:
                                                          stackGroupesRecord
                                                              .reference,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'users':
                                                            stackGroupesRecord
                                                                .users,
                                                      },
                                                    ),
                                                  });
                                                  _model.chatGroupeCree =
                                                      ChatsRecord
                                                          .getDocumentFromData({
                                                    ...createChatsRecordData(
                                                      lastMessage:
                                                          'Nouvelle conversation',
                                                      lastMessageTime:
                                                          getCurrentTimestamp,
                                                      lastMessageSentBy:
                                                          currentUserReference,
                                                      lastMessageSeenBy:
                                                          currentUserReference,
                                                      groupeChat: true,
                                                      groupRef:
                                                          stackGroupesRecord
                                                              .reference,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'users':
                                                            stackGroupesRecord
                                                                .users,
                                                      },
                                                    ),
                                                  }, chatsRecordReference);
                                                  while (_model.compteurUser <
                                                      stackGroupesRecord
                                                          .users.length) {
                                                    await stackGroupesRecord
                                                        .users[1]
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'chats': FieldValue
                                                              .arrayUnion([
                                                            _model
                                                                .chatGroupeCree
                                                                ?.reference
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    _model.compteurUser =
                                                        _model.compteurUser + 1;
                                                  }
                                                  _model.compteurUser = 0;

                                                  context.goNamed(
                                                    'chatGroupPage',
                                                    queryParameters: {
                                                      'chat': serializeParam(
                                                        _model.chatGroupeCree
                                                            ?.reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                      'group': serializeParam(
                                                        stackGroupesRecord
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                }

                                                setState(() {});
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                '5tiu53zc' /* Chat */,
                                              ),
                                              icon: const Icon(
                                                FFIcons.kcallmessage,
                                                size: 15.0,
                                              ),
                                              options: FFButtonOptions(
                                                height: 48.0,
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 4.0, 0.0),
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
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 2.0),
                                            child: Icon(
                                              FFIcons.klocation1,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .grey1,
                                              size: 18.0,
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await Clipboard.setData(
                                                  ClipboardData(
                                                      text: stackGroupesRecord
                                                          .adresse));
                                            },
                                            child: Text(
                                              stackGroupesRecord.adresse
                                                  .maybeHandleOverflow(
                                                      maxChars: 15),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleLarge
                                                  .override(
                                                    fontFamily:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLargeFamily,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .grey1,
                                                    fontSize: 16.0,
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
                                          Icon(
                                            Icons.circle_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .grey1,
                                            size: 6.0,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 2.0),
                                            child: Icon(
                                              FFIcons.kaccountIcon2,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .grey1,
                                              size: 18.0,
                                            ),
                                          ),
                                          Text(
                                            '${stackGroupesRecord.users.length.toString()} membres',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLargeFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .grey1,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w900,
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
                                    ),
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: Text(
                                          stackGroupesRecord.bio,
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .grey1,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                        ),
                                      ),
                                    ),
                                    if (stackGroupesRecord.users
                                            .contains(currentUserReference) ==
                                        true)
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'h0blhuuc' /* Plats proposés dans le groupe */,
                                                ),
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
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 260.0,
                                            decoration: const BoxDecoration(),
                                            child: Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: StreamBuilder<
                                                  List<PlatsRecord>>(
                                                stream: queryPlatsRecord(
                                                  queryBuilder: (platsRecord) =>
                                                      platsRecord
                                                          .whereIn(
                                                              'Seller',
                                                              stackGroupesRecord
                                                                  .users)
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
                                                  if (listViewPlatsRecordList
                                                      .isEmpty) {
                                                    return const NoIngredientWidget();
                                                  }
                                                  return ListView.separated(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 24.0),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        listViewPlatsRecordList
                                                            .length,
                                                    separatorBuilder: (_, __) =>
                                                        const SizedBox(width: 24.0),
                                                    itemBuilder: (context,
                                                        listViewIndex) {
                                                      final listViewPlatsRecord =
                                                          listViewPlatsRecordList[
                                                              listViewIndex];
                                                      return Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Container(
                                                          width: 200.0,
                                                          height: 240.0,
                                                          decoration:
                                                              const BoxDecoration(),
                                                          child:
                                                              PlatsVoisinsWidget(
                                                            key: Key(
                                                                'Key4zg_${listViewIndex}_of_${listViewPlatsRecordList.length}'),
                                                            plat:
                                                                listViewPlatsRecord
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
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'h0xztt5b' /* Membres du groupe */,
                                                ),
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
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final containerVar =
                                                    containerUsersRecordList
                                                        .toList();
                                                if (containerVar.isEmpty) {
                                                  return const Center(
                                                    child: AucunelementWidget(),
                                                  );
                                                }
                                                return ReorderableListView
                                                    .builder(
                                                  padding: EdgeInsets.zero,
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      containerVar.length,
                                                  itemBuilder: (context,
                                                      containerVarIndex) {
                                                    final containerVarItem =
                                                        containerVar[
                                                            containerVarIndex];
                                                    return Container(
                                                      key: ValueKey(
                                                          "ListView_nctqi1qo" '_' +
                                                              containerVarIndex
                                                                  .toString()),
                                                      child: Visibility(
                                                        visible:
                                                            (containerVarIndex <
                                                                    3) ||
                                                                _model
                                                                    .showUsers,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      8.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 60.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      4.0,
                                                                  color: Color(
                                                                      0x32000000),
                                                                  offset:
                                                                      Offset(
                                                                          0.0,
                                                                          2.0),
                                                                )
                                                              ],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          0.0,
                                                                          8.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            26.0),
                                                                    child: Image
                                                                        .network(
                                                                      containerVarItem
                                                                          .photoUrl,
                                                                      width:
                                                                          36.0,
                                                                      height:
                                                                          36.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/images/error_image.png',
                                                                        width:
                                                                            36.0,
                                                                        height:
                                                                            36.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          12.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            containerVarItem.displayName,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Avenir',
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 14.0,
                                                                                  fontWeight: FontWeight.w900,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey('Avenir'),
                                                                                ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  stackGroupesRecord.administrateurs.contains(containerVarItem.reference) ? 'Administrateur' : 'Membre',
                                                                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        fontFamily: 'Avenir',
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: 14.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey('Avenir'),
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if ((stackGroupesRecord.administrateurs.contains(containerVarItem
                                                                              .reference)
                                                                          ? false
                                                                          : true) &&
                                                                      stackGroupesRecord
                                                                          .administrateurs
                                                                          .contains(
                                                                              currentUserReference) &&
                                                                      (containerVarItem
                                                                              .reference !=
                                                                          currentUserReference))
                                                                    Padding(
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          8.0,
                                                                          0.0),
                                                                      child:
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          var confirmDialogResponse = await showDialog<bool>(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return AlertDialog(
                                                                                    title: const Text('Êtes vous sur ?'),
                                                                                    content: const Text('L\'utilisateur quittera le groupe automatiquement.'),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                        child: const Text('Conserver'),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                        child: const Text('Supprimer'),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              ) ??
                                                                              false;
                                                                          if (confirmDialogResponse) {
                                                                            await stackGroupesRecord.reference.update({
                                                                              ...mapToFirestore(
                                                                                {
                                                                                  'administrateurs': FieldValue.arrayRemove([
                                                                                    containerVarItem.reference
                                                                                  ]),
                                                                                  'Users': FieldValue.arrayRemove([
                                                                                    containerVarItem.reference
                                                                                  ]),
                                                                                },
                                                                              ),
                                                                            });

                                                                            await containerVarItem.reference.update({
                                                                              ...mapToFirestore(
                                                                                {
                                                                                  'groupes': FieldValue.arrayRemove([
                                                                                    widget.groupRef
                                                                                  ]),
                                                                                },
                                                                              ),
                                                                            });
                                                                            context.safePop();
                                                                          }
                                                                        },
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          't5ns8ti9' /*  */,
                                                                        ),
                                                                        icon:
                                                                            const Icon(
                                                                          FFIcons
                                                                              .kdelete,
                                                                          size:
                                                                              15.0,
                                                                        ),
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              60.0,
                                                                          height:
                                                                              40.0,
                                                                          padding:
                                                                              const EdgeInsets.all(0.0),
                                                                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                              4.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Outfit',
                                                                                color: Colors.white,
                                                                                fontSize: 14.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey('Outfit'),
                                                                              ),
                                                                          elevation:
                                                                              2.0,
                                                                          borderSide:
                                                                              const BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(200.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  FFButtonWidget(
                                                                    onPressed:
                                                                        () async {
                                                                      context
                                                                          .pushNamed(
                                                                        'vendeur_detail',
                                                                        pathParameters:
                                                                            {
                                                                          'seller':
                                                                              serializeParam(
                                                                            containerVarItem.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    text: FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'h7sbbqn2' /* Voir */,
                                                                    ),
                                                                    options:
                                                                        FFButtonOptions(
                                                                      height:
                                                                          40.0,
                                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      textStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Avenir',
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                14.0,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                            useGoogleFonts:
                                                                                GoogleFonts.asMap().containsKey('Avenir'),
                                                                          ),
                                                                      elevation:
                                                                          2.0,
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: Colors
                                                                            .transparent,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              200.0),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  onReorder: (int
                                                          reorderableOldIndex,
                                                      int reorderableNewIndex) async {},
                                                );
                                              },
                                            ),
                                          ),
                                          if (containerUsersRecordList.length >
                                              5)
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 24.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  setState(() {
                                                    _model.showUsers =
                                                        !_model.showUsers;
                                                  });
                                                },
                                                text: _model.showUsers
                                                    ? 'Cacher les membres'
                                                    : 'Afficher les membres',
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 60.0,
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          24.0, 0.0, 24.0, 0.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              8.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .transparent,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmallFamily,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmallFamily),
                                                      ),
                                                  elevation: 0.0,
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
                                        ].divide(const SizedBox(height: 16.0)),
                                      ),
                                    if (!stackGroupesRecord.users
                                        .contains(currentUserReference))
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              'connexionGroupe',
                                              queryParameters: {
                                                'groupe': serializeParam(
                                                  widget.groupRef,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'rx69qktg' /* Rejoindre le groupe */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 60.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
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
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    if (stackGroupesRecord.users
                                        .contains(currentUserReference))
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                              'ajouterUserGroupe',
                                              queryParameters: {
                                                'group': serializeParam(
                                                  widget.groupRef,
                                                  ParamType.DocumentReference,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'el9r89mv' /* Inviter des utilisateurs */,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 60.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
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
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    if (stackGroupesRecord.administrateurs
                                        .contains(currentUserReference))
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Êtes vous sur ?'),
                                                          content: const Text(
                                                              'Votre groupe et tous ses messages seront supprimés.'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child: const Text(
                                                                  'Conserver'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: const Text(
                                                                  'Supprimer'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              await widget.groupRef!.update({
                                                ...createGroupesRecordData(
                                                  displayName:
                                                      'Groupe supprimé',
                                                  supprime: true,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'photo_url':
                                                        FieldValue.delete(),
                                                    'edited_time': FieldValue
                                                        .serverTimestamp(),
                                                    'bio': FieldValue.delete(),
                                                    'Users':
                                                        FieldValue.delete(),
                                                    'adresse':
                                                        FieldValue.delete(),
                                                    'latlng':
                                                        FieldValue.delete(),
                                                    'groupepublic':
                                                        FieldValue.delete(),
                                                    'codeconnexion':
                                                        FieldValue.delete(),
                                                    'administrateurs':
                                                        FieldValue.delete(),
                                                  },
                                                ),
                                              });

                                              context.pushNamed('messageList');
                                            }
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'zopfx3z0' /* Supprimer le groupe */,
                                          ),
                                          icon: const FaIcon(
                                            FontAwesomeIcons.times,
                                            size: 20.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 60.0,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding: const EdgeInsets.all(0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .error,
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
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    if (stackGroupesRecord.users
                                        .contains(currentUserReference))
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 40.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Êtes vous sur ?'),
                                                          content: const Text(
                                                              'Vous allez quitter le groupe.'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child: const Text(
                                                                  'Rester'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: const Text(
                                                                  'Quitter'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              await stackGroupesRecord.reference
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'administrateurs':
                                                        FieldValue.arrayRemove([
                                                      currentUserReference
                                                    ]),
                                                    'Users':
                                                        FieldValue.arrayRemove([
                                                      currentUserReference
                                                    ]),
                                                  },
                                                ),
                                              });

                                              await currentUserReference!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'groupes':
                                                        FieldValue.arrayRemove(
                                                            [widget.groupRef]),
                                                  },
                                                ),
                                              });
                                              context.safePop();
                                            }
                                          },
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'ou92cxnd' /* Quitter le groupe */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  fontWeight: FontWeight.w900,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMediumFamily),
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
                    Align(
                      alignment: const AlignmentDirectional(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 24.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('messageList');
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
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24.0,
                              ),
                            ),
                          ),
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
