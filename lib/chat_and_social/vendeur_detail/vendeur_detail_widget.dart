import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_general/plats_voisins/plats_voisins_widget.dart';
import '/components_general/user_card_back/user_card_back_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'vendeur_detail_model.dart';
export 'vendeur_detail_model.dart';

class VendeurDetailWidget extends StatefulWidget {
  const VendeurDetailWidget({
    super.key,
    this.seller,
  });

  final DocumentReference? seller;

  @override
  State<VendeurDetailWidget> createState() => _VendeurDetailWidgetState();
}

class _VendeurDetailWidgetState extends State<VendeurDetailWidget> {
  late VendeurDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VendeurDetailModel());
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
        body: SafeArea(
          top: true,
          child: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(widget.seller!),
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
              final columnUsersRecord = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.userCardBackModel,
                                updateCallback: () => setState(() {}),
                                child: UserCardBackWidget(
                                  userRef: widget.seller!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<List<PlatsRecord>>(
                      stream: queryPlatsRecord(
                        queryBuilder: (platsRecord) => platsRecord
                            .where(
                              'Seller',
                              isEqualTo: widget.seller,
                            )
                            .where(
                              'Etat',
                              isLessThan: 3,
                            ),
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
                        List<PlatsRecord> containerPlatsRecordList =
                            snapshot.data!;
                        return Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (containerPlatsRecordList.length > 0)
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              'Plats en ventes à ses voisins',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLargeFamily,
                                                        fontSize: 20.0,
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                height: 272.0,
                                                decoration: BoxDecoration(),
                                                child: Builder(
                                                  builder: (context) {
                                                    final platsVoisins =
                                                        containerPlatsRecordList
                                                            .toList()
                                                            .take(50)
                                                            .toList();
                                                    return ListView.separated(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 24.0),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          platsVoisins.length,
                                                      separatorBuilder: (_,
                                                              __) =>
                                                          SizedBox(width: 24.0),
                                                      itemBuilder: (context,
                                                          platsVoisinsIndex) {
                                                        final platsVoisinsItem =
                                                            platsVoisins[
                                                                platsVoisinsIndex];
                                                        return Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Container(
                                                            width: 200.0,
                                                            height: 240.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child:
                                                                PlatsVoisinsWidget(
                                                              key: Key(
                                                                  'Keyp0c_${platsVoisinsIndex}_of_${platsVoisins.length}'),
                                                              plat:
                                                                  platsVoisinsItem
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
                                  AuthUserStreamWidget(
                                    builder: (context) =>
                                        StreamBuilder<List<PlatsRecord>>(
                                      stream: queryPlatsRecord(
                                        queryBuilder: (platsRecord) =>
                                            platsRecord
                                                .where(
                                                  'Seller',
                                                  isEqualTo: widget.seller,
                                                )
                                                .whereArrayContainsAny(
                                                    'groupe_destine',
                                                    (currentUserDocument
                                                            ?.groupes
                                                            ?.toList() ??
                                                        []))
                                                .where(
                                                  'Etat',
                                                  isLessThan: 5,
                                                ),
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
                                            containerPlatsRecordList =
                                            snapshot.data!;
                                        return Container(
                                          decoration: BoxDecoration(),
                                          child: Visibility(
                                            visible: containerPlatsRecordList
                                                    .length >
                                                0,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Plats en ventes dans vos groupes',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLargeFamily,
                                                                fontSize: 20.0,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .titleLargeFamily),
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                1.0,
                                                        height: 272.0,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final platsGroupes =
                                                                containerPlatsRecordList
                                                                    .toList()
                                                                    .take(50)
                                                                    .toList();
                                                            return ListView
                                                                .separated(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          24.0),
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              itemCount:
                                                                  platsGroupes
                                                                      .length,
                                                              separatorBuilder: (_,
                                                                      __) =>
                                                                  SizedBox(
                                                                      width:
                                                                          24.0),
                                                              itemBuilder: (context,
                                                                  platsGroupesIndex) {
                                                                final platsGroupesItem =
                                                                    platsGroupes[
                                                                        platsGroupesIndex];
                                                                return Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        200.0,
                                                                    height:
                                                                        240.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        PlatsVoisinsWidget(
                                                                      key: Key(
                                                                          'Keynx3_${platsGroupesIndex}_of_${platsGroupes.length}'),
                                                                      plat: platsGroupesItem
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
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    StreamBuilder<List<ChatsRecord>>(
                      stream: queryChatsRecord(
                        queryBuilder: (chatsRecord) => chatsRecord
                            .where(
                              'users',
                              arrayContains: currentUserReference,
                            )
                            .where(
                              'groupe_chat',
                              isNotEqualTo: true,
                            ),
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
                        List<ChatsRecord> containerChatsRecordList =
                            snapshot.data!;
                        return Container(
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 40.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (containerChatsRecordList.length != 0) {
                                  if (containerChatsRecordList
                                          .where((e) => valueOrDefault<bool>(
                                                e.users.contains(widget.seller),
                                                false,
                                              ))
                                          .toList()
                                          .length !=
                                      0) {
                                    context.pushNamed(
                                      'chatPage',
                                      queryParameters: {
                                        'chat': serializeParam(
                                          containerChatsRecordList
                                              .where((e) => e.users
                                                  .contains(widget.seller))
                                              .toList()
                                              .first
                                              .reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    // On crée le chat
                                    //

                                    var chatsRecordReference1 =
                                        ChatsRecord.collection.doc();
                                    await chatsRecordReference1.set({
                                      ...createChatsRecordData(
                                        userA: currentUserReference,
                                        userB: widget.seller,
                                        lastMessage: 'Nouvelle conversation',
                                        lastMessageTime: getCurrentTimestamp,
                                        lastMessageSentBy: currentUserReference,
                                        lastMessageSeenBy: currentUserReference,
                                        groupeChat: false,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'users': [currentUserReference],
                                        },
                                      ),
                                    });
                                    _model.convCreeResult =
                                        ChatsRecord.getDocumentFromData({
                                      ...createChatsRecordData(
                                        userA: currentUserReference,
                                        userB: widget.seller,
                                        lastMessage: 'Nouvelle conversation',
                                        lastMessageTime: getCurrentTimestamp,
                                        lastMessageSentBy: currentUserReference,
                                        lastMessageSeenBy: currentUserReference,
                                        groupeChat: false,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'users': [currentUserReference],
                                        },
                                      ),
                                    }, chatsRecordReference1);
                                    // On ajoute le 2 ème user dans la list d'users du chat

                                    await _model.convCreeResult!.reference
                                        .update({
                                      ...mapToFirestore(
                                        {
                                          'users': FieldValue.arrayUnion(
                                              [widget.seller]),
                                        },
                                      ),
                                    });
                                    // On ajoute le chat dans la list de chat de l'autre user

                                    await widget.seller!.update({
                                      ...mapToFirestore(
                                        {
                                          'chats': FieldValue.arrayUnion([
                                            _model.convCreeResult?.reference
                                          ]),
                                        },
                                      ),
                                    });
                                    // On ajoute le chat dans la list de chat de l'utilisateur connecté

                                    await currentUserReference!.update({
                                      ...mapToFirestore(
                                        {
                                          'chats': FieldValue.arrayUnion([
                                            _model.convCreeResult?.reference
                                          ]),
                                        },
                                      ),
                                    });

                                    context.goNamed(
                                      'chatPage',
                                      queryParameters: {
                                        'chat': serializeParam(
                                          _model.convCreeResult?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                      }.withoutNulls,
                                    );
                                  }
                                } else {
                                  // On crée le chat
                                  //

                                  var chatsRecordReference2 =
                                      ChatsRecord.collection.doc();
                                  await chatsRecordReference2.set({
                                    ...createChatsRecordData(
                                      userA: currentUserReference,
                                      userB: widget.seller,
                                      lastMessage: 'Nouvelle conversation',
                                      lastMessageTime: getCurrentTimestamp,
                                      lastMessageSentBy: currentUserReference,
                                      lastMessageSeenBy: currentUserReference,
                                      groupeChat: false,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'users': [currentUserReference],
                                      },
                                    ),
                                  });
                                  _model.convCreeResult2 =
                                      ChatsRecord.getDocumentFromData({
                                    ...createChatsRecordData(
                                      userA: currentUserReference,
                                      userB: widget.seller,
                                      lastMessage: 'Nouvelle conversation',
                                      lastMessageTime: getCurrentTimestamp,
                                      lastMessageSentBy: currentUserReference,
                                      lastMessageSeenBy: currentUserReference,
                                      groupeChat: false,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'users': [currentUserReference],
                                      },
                                    ),
                                  }, chatsRecordReference2);
                                  // On ajoute le 2 ème user dans la list d'users du chat

                                  await _model.convCreeResult2!.reference
                                      .update({
                                    ...mapToFirestore(
                                      {
                                        'users': FieldValue.arrayUnion(
                                            [widget.seller]),
                                      },
                                    ),
                                  });
                                  // On ajoute le chat dans la list de chat de l'autre user

                                  await widget.seller!.update({
                                    ...mapToFirestore(
                                      {
                                        'chats': FieldValue.arrayUnion([
                                          _model.convCreeResult2?.reference
                                        ]),
                                      },
                                    ),
                                  });
                                  // On ajoute le chat dans la list de chat de l'utilisateur connecté

                                  await currentUserReference!.update({
                                    ...mapToFirestore(
                                      {
                                        'chats': FieldValue.arrayUnion([
                                          _model.convCreeResult2?.reference
                                        ]),
                                      },
                                    ),
                                  });

                                  context.goNamed(
                                    'chatPage',
                                    queryParameters: {
                                      'chat': serializeParam(
                                        _model.convCreeResult2?.reference,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );
                                }

                                setState(() {});
                              },
                              text: 'Chatter',
                              icon: Icon(
                                FFIcons.kcallmessage,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 8.0, 0.0),
                                color: FlutterFlowTheme.of(context).secondary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color: Colors.white,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
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
                        );
                      },
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
