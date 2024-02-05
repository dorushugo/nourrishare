import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components_general/demarrerconv/demarrerconv_widget.dart';
import '/components_general/user_card_back/user_card_back_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'chat_page_model.dart';
export 'chat_page_model.dart';

class ChatPageWidget extends StatefulWidget {
  const ChatPageWidget({
    super.key,
    required this.chat,
  });

  final DocumentReference? chat;

  @override
  State<ChatPageWidget> createState() => _ChatPageWidgetState();
}

class _ChatPageWidgetState extends State<ChatPageWidget>
    with TickerProviderStateMixin {
  late ChatPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 440.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await widget.chat!.update(createChatsRecordData(
        lastMessageSeenBy: currentUserReference,
      ));
      _model.currentChat = await ChatsRecord.getDocumentOnce(widget.chat!);
      setState(() {
        _model.otherUser = _model.currentChat?.users
            ?.where((e) => e.id != currentUserReference?.id)
            .toList()
            ?.first;
      });
    });

    _model.messageFieldController ??= TextEditingController();
    _model.messageFieldFocusNode ??= FocusNode();
    _model.messageFieldFocusNode!.addListener(
      () async {
        await _model.columnController?.animateTo(
          _model.columnController!.position.maxScrollExtent,
          duration: Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      },
    );
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
            stream: UsersRecord.getDocument(_model.otherUser!),
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
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                child: StreamBuilder<ChatsRecord>(
                  stream: ChatsRecord.getDocument(widget.chat!),
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
                    final stackChatsRecord = snapshot.data!;
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 85.0, 0.0, 56.0),
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 1.0,
                                decoration: BoxDecoration(),
                                child: SingleChildScrollView(
                                  controller: _model.columnController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: StreamBuilder<
                                                  List<ChatMessagesRecord>>(
                                                stream: queryChatMessagesRecord(
                                                  queryBuilder:
                                                      (chatMessagesRecord) =>
                                                          chatMessagesRecord
                                                              .where(
                                                                'chat',
                                                                isEqualTo:
                                                                    widget.chat,
                                                              )
                                                              .orderBy('time',
                                                                  descending:
                                                                      true),
                                                  limit: 100,
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
                                                  List<ChatMessagesRecord>
                                                      listViewChatMessagesRecordList =
                                                      snapshot.data!;
                                                  if (listViewChatMessagesRecordList
                                                      .isEmpty) {
                                                    return Center(
                                                      child:
                                                          DemarrerconvWidget(),
                                                    );
                                                  }
                                                  return ListView.separated(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0),
                                                    reverse: true,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        listViewChatMessagesRecordList
                                                            .length,
                                                    separatorBuilder: (_, __) =>
                                                        SizedBox(height: 8.0),
                                                    itemBuilder: (context,
                                                        listViewIndex) {
                                                      final listViewChatMessagesRecord =
                                                          listViewChatMessagesRecordList[
                                                              listViewIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    24.0,
                                                                    0.0,
                                                                    24.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            if ((listViewChatMessagesRecord
                                                                        .user ==
                                                                    currentUserReference) &&
                                                                (listViewChatMessagesRecord
                                                                            .text !=
                                                                        null &&
                                                                    listViewChatMessagesRecord
                                                                            .text !=
                                                                        ''))
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            15.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onLongPress:
                                                                          () async {
                                                                        var confirmDialogResponse = await showDialog<bool>(
                                                                              context: context,
                                                                              builder: (alertDialogContext) {
                                                                                return AlertDialog(
                                                                                  title: Text('Voulez vous supprimer ce message ?'),
                                                                                  content: Text('Votre interlocuteur verra que vous avez supprimé votre message.'),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                      child: Text('Conserver'),
                                                                                    ),
                                                                                    TextButton(
                                                                                      onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                      child: Text('Supprimer'),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              },
                                                                            ) ??
                                                                            false;
                                                                        if (confirmDialogResponse) {
                                                                          await listViewChatMessagesRecord
                                                                              .reference
                                                                              .update(createChatMessagesRecordData(
                                                                            text:
                                                                                'Ce message a été retiré.',
                                                                          ));
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          maxWidth:
                                                                              MediaQuery.sizeOf(context).width * 0.7,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              blurRadius: 16.0,
                                                                              color: FlutterFlowTheme.of(context).boxShadow,
                                                                              offset: Offset(0.0, 2.0),
                                                                            )
                                                                          ],
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(20.0),
                                                                            bottomRight:
                                                                                Radius.circular(0.0),
                                                                            topLeft:
                                                                                Radius.circular(20.0),
                                                                            topRight:
                                                                                Radius.circular(20.0),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16.0,
                                                                              10.0,
                                                                              16.0,
                                                                              10.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            children: [
                                                                              Wrap(
                                                                                spacing: 0.0,
                                                                                runSpacing: 0.0,
                                                                                alignment: WrapAlignment.start,
                                                                                crossAxisAlignment: WrapCrossAlignment.start,
                                                                                direction: Axis.horizontal,
                                                                                runAlignment: WrapAlignment.start,
                                                                                verticalDirection: VerticalDirection.down,
                                                                                clipBehavior: Clip.none,
                                                                                children: [
                                                                                  Text(
                                                                                    listViewChatMessagesRecord.text,
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          fontSize: 14.0,
                                                                                          useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyLargeFamily),
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              4.0),
                                                                          child:
                                                                              Text(
                                                                            ((dateTimeFormat(
                                                                                              'relative',
                                                                                              listViewChatMessagesRecord.time,
                                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                                            ) !=
                                                                                            'il y a moins d\'une minute') &&
                                                                                        (dateTimeFormat(
                                                                                              'relative',
                                                                                              listViewChatMessagesRecord.time,
                                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                                            ) !=
                                                                                            'd\'ici moins d\'une minute')) &&
                                                                                    true
                                                                                ? dateTimeFormat(
                                                                                    'relative',
                                                                                    listViewChatMessagesRecord.time!,
                                                                                    locale: FFLocalizations.of(context).languageShortCode ?? FFLocalizations.of(context).languageCode,
                                                                                  )
                                                                                : 'à l\'instant',
                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                  color: FlutterFlowTheme.of(context).grey2,
                                                                                  fontSize: 12.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            if ((listViewChatMessagesRecord
                                                                        .user !=
                                                                    currentUserReference) &&
                                                                (listViewChatMessagesRecord
                                                                            .text !=
                                                                        null &&
                                                                    listViewChatMessagesRecord
                                                                            .text !=
                                                                        ''))
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                      tabletLandscape:
                                                                          false,
                                                                      desktop:
                                                                          false,
                                                                    ))
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            context.pushNamed(
                                                                              'vendeur_detail',
                                                                              pathParameters: {
                                                                                'seller': serializeParam(
                                                                                  listViewChatMessagesRecord.user,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                              }.withoutNulls,
                                                                            );
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                40.0,
                                                                            height:
                                                                                40.0,
                                                                            clipBehavior:
                                                                                Clip.antiAlias,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Image.network(
                                                                              containerUsersRecord.photoUrl,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    Container(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxWidth:
                                                                            MediaQuery.sizeOf(context).width *
                                                                                0.7,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                16.0,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).boxShadow,
                                                                            offset:
                                                                                Offset(0.0, 2.0),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(0.0),
                                                                          bottomRight:
                                                                              Radius.circular(20.0),
                                                                          topLeft:
                                                                              Radius.circular(20.0),
                                                                          topRight:
                                                                              Radius.circular(20.0),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            16.0,
                                                                            10.0,
                                                                            16.0,
                                                                            10.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Wrap(
                                                                              spacing: 0.0,
                                                                              runSpacing: 0.0,
                                                                              alignment: WrapAlignment.start,
                                                                              crossAxisAlignment: WrapCrossAlignment.start,
                                                                              direction: Axis.horizontal,
                                                                              runAlignment: WrapAlignment.start,
                                                                              verticalDirection: VerticalDirection.down,
                                                                              clipBehavior: Clip.none,
                                                                              children: [
                                                                                Text(
                                                                                  listViewChatMessagesRecord.text,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        fontWeight: FontWeight.w900,
                                                                                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                                      ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          8.0,
                                                                          0.0,
                                                                          4.0),
                                                                      child:
                                                                          Text(
                                                                        ((dateTimeFormat(
                                                                                          'relative',
                                                                                          listViewChatMessagesRecord.time,
                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                        ) !=
                                                                                        'il y a moins d\'une minute') &&
                                                                                    (dateTimeFormat(
                                                                                          'relative',
                                                                                          listViewChatMessagesRecord.time,
                                                                                          locale: FFLocalizations.of(context).languageCode,
                                                                                        ) !=
                                                                                        'd\'ici moins d\'une minute')) &&
                                                                                true
                                                                            ? dateTimeFormat(
                                                                                'relative',
                                                                                listViewChatMessagesRecord.time!,
                                                                                locale: FFLocalizations.of(context).languageShortCode ?? FFLocalizations.of(context).languageCode,
                                                                              )
                                                                            : 'à l\'instant',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                              color: FlutterFlowTheme.of(context).grey2,
                                                                              fontSize: 12.0,
                                                                              fontWeight: FontWeight.normal,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            if ((listViewChatMessagesRecord
                                                                        .user ==
                                                                    currentUserReference) &&
                                                                (listViewChatMessagesRecord
                                                                            .image !=
                                                                        null &&
                                                                    listViewChatMessagesRecord
                                                                            .image !=
                                                                        ''))
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onLongPress:
                                                                            () async {
                                                                          var confirmDialogResponse = await showDialog<bool>(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return AlertDialog(
                                                                                    title: Text('Voulez vous supprimer ce message ?'),
                                                                                    content: Text('Votre interlocuteur verra que vous avez supprimé votre message.'),
                                                                                    actions: [
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                        child: Text('Conserver'),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                        child: Text('Supprimer'),
                                                                                      ),
                                                                                    ],
                                                                                  );
                                                                                },
                                                                              ) ??
                                                                              false;
                                                                          if (confirmDialogResponse) {
                                                                            await listViewChatMessagesRecord.reference.update({
                                                                              ...createChatMessagesRecordData(
                                                                                text: 'Ce message a été retiré.',
                                                                              ),
                                                                              ...mapToFirestore(
                                                                                {
                                                                                  'image': FieldValue.delete(),
                                                                                },
                                                                              ),
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                          child:
                                                                              InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              await Navigator.push(
                                                                                context,
                                                                                PageTransition(
                                                                                  type: PageTransitionType.fade,
                                                                                  child: FlutterFlowExpandedImageView(
                                                                                    image: CachedNetworkImage(
                                                                                      fadeInDuration: Duration(milliseconds: 500),
                                                                                      fadeOutDuration: Duration(milliseconds: 500),
                                                                                      imageUrl: listViewChatMessagesRecord.image,
                                                                                      fit: BoxFit.contain,
                                                                                    ),
                                                                                    allowRotation: false,
                                                                                    tag: listViewChatMessagesRecord.image,
                                                                                    useHeroAnimation: true,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                Hero(
                                                                              tag: listViewChatMessagesRecord.image,
                                                                              transitionOnUserGestures: true,
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                                child: CachedNetworkImage(
                                                                                  fadeInDuration: Duration(milliseconds: 500),
                                                                                  fadeOutDuration: Duration(milliseconds: 500),
                                                                                  imageUrl: listViewChatMessagesRecord.image,
                                                                                  width: 300.0,
                                                                                  height: 200.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            8.0,
                                                                            0.0,
                                                                            4.0),
                                                                        child:
                                                                            Text(
                                                                          ((dateTimeFormat(
                                                                                            'relative',
                                                                                            listViewChatMessagesRecord.time,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ) !=
                                                                                          'il y a moins d\'une minute') &&
                                                                                      (dateTimeFormat(
                                                                                            'relative',
                                                                                            listViewChatMessagesRecord.time,
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ) !=
                                                                                          'd\'ici moins d\'une minute')) &&
                                                                                  true
                                                                              ? dateTimeFormat(
                                                                                  'relative',
                                                                                  listViewChatMessagesRecord.time!,
                                                                                  locale: FFLocalizations.of(context).languageShortCode ?? FFLocalizations.of(context).languageCode,
                                                                                )
                                                                              : 'à l\'instant',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                color: FlutterFlowTheme.of(context).grey2,
                                                                                fontSize: 12.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            if ((listViewChatMessagesRecord
                                                                        .user !=
                                                                    currentUserReference) &&
                                                                (listViewChatMessagesRecord
                                                                            .image !=
                                                                        null &&
                                                                    listViewChatMessagesRecord
                                                                            .image !=
                                                                        ''))
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.0),
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          splashColor:
                                                                              Colors.transparent,
                                                                          focusColor:
                                                                              Colors.transparent,
                                                                          hoverColor:
                                                                              Colors.transparent,
                                                                          highlightColor:
                                                                              Colors.transparent,
                                                                          onTap:
                                                                              () async {
                                                                            await Navigator.push(
                                                                              context,
                                                                              PageTransition(
                                                                                type: PageTransitionType.fade,
                                                                                child: FlutterFlowExpandedImageView(
                                                                                  image: Image.network(
                                                                                    listViewChatMessagesRecord.image,
                                                                                    fit: BoxFit.contain,
                                                                                  ),
                                                                                  allowRotation: false,
                                                                                  tag: listViewChatMessagesRecord.image,
                                                                                  useHeroAnimation: true,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child:
                                                                              Hero(
                                                                            tag:
                                                                                listViewChatMessagesRecord.image,
                                                                            transitionOnUserGestures:
                                                                                true,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                              child: Image.network(
                                                                                listViewChatMessagesRecord.image,
                                                                                width: 300.0,
                                                                                height: 200.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              8.0,
                                                                              0.0,
                                                                              4.0),
                                                                          child:
                                                                              Text(
                                                                            ((dateTimeFormat(
                                                                                              'relative',
                                                                                              listViewChatMessagesRecord.time,
                                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                                            ) !=
                                                                                            'il y a moins d\'une minute') &&
                                                                                        (dateTimeFormat(
                                                                                              'relative',
                                                                                              listViewChatMessagesRecord.time,
                                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                                            ) !=
                                                                                            'd\'ici moins d\'une minute')) &&
                                                                                    true
                                                                                ? dateTimeFormat(
                                                                                    'relative',
                                                                                    listViewChatMessagesRecord.time!,
                                                                                    locale: FFLocalizations.of(context).languageShortCode ?? FFLocalizations.of(context).languageCode,
                                                                                  )
                                                                                : 'à l\'instant',
                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                                                                  color: FlutterFlowTheme.of(context).grey2,
                                                                                  fontSize: 12.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                          ].divide(SizedBox(
                                                              height: 0.0)),
                                                        ),
                                                      );
                                                    },
                                                    controller: _model
                                                        .listViewController,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 4.0, 0.0, 0.0),
                                child: wrapWithModel(
                                  model: _model.userCardBackModel,
                                  updateCallback: () => setState(() {}),
                                  child: UserCardBackWidget(
                                    userRef: _model.otherUser!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 0.0,
                                    sigmaY: 0.0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 4.0, 24.0, 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .grey4,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 0.0, 0.0),
                                                child: TextFormField(
                                                  controller: _model
                                                      .messageFieldController,
                                                  focusNode: _model
                                                      .messageFieldFocusNode,
                                                  onFieldSubmitted: (_) async {
                                                    var chatMessagesRecordReference =
                                                        ChatMessagesRecord
                                                            .collection
                                                            .doc();
                                                    await chatMessagesRecordReference
                                                        .set({
                                                      ...createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget.chat,
                                                        text: _model
                                                            .messageFieldController
                                                            .text,
                                                        time:
                                                            getCurrentTimestamp,
                                                        image: '',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'users':
                                                              stackChatsRecord
                                                                  .users,
                                                        },
                                                      ),
                                                    });
                                                    _model.messageCreated =
                                                        ChatMessagesRecord
                                                            .getDocumentFromData({
                                                      ...createChatMessagesRecordData(
                                                        user:
                                                            currentUserReference,
                                                        chat: widget.chat,
                                                        text: _model
                                                            .messageFieldController
                                                            .text,
                                                        time:
                                                            getCurrentTimestamp,
                                                        image: '',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'users':
                                                              stackChatsRecord
                                                                  .users,
                                                        },
                                                      ),
                                                    }, chatMessagesRecordReference);
                                                    if (_model.messageCreated
                                                                ?.image ==
                                                            null ||
                                                        _model.messageCreated
                                                                ?.image ==
                                                            '') {
                                                      await widget.chat!.update(
                                                          createChatsRecordData(
                                                        lastMessage: _model
                                                            .messageCreated
                                                            ?.text,
                                                        lastMessageTime: _model
                                                            .messageCreated
                                                            ?.time,
                                                        lastMessageSentBy:
                                                            currentUserReference,
                                                        lastMessageSeenBy:
                                                            currentUserReference,
                                                      ));
                                                    } else {
                                                      await widget.chat!.update(
                                                          createChatsRecordData(
                                                        lastMessage: 'Image',
                                                        lastMessageTime: _model
                                                            .messageCreated
                                                            ?.time,
                                                        lastMessageSentBy:
                                                            currentUserReference,
                                                        lastMessageSeenBy:
                                                            currentUserReference,
                                                      ));
                                                    }

                                                    setState(() {
                                                      _model
                                                          .messageFieldController
                                                          ?.clear();
                                                    });
                                                    triggerPushNotification(
                                                      notificationTitle:
                                                          'Nouveau message de ${currentUserDisplayName}',
                                                      notificationText: _model
                                                          .messageCreated!.text,
                                                      notificationImageUrl:
                                                          currentUserPhoto,
                                                      notificationSound:
                                                          'default',
                                                      userRefs: [
                                                        _model.otherUser!
                                                      ],
                                                      initialPageName:
                                                          'chatPage',
                                                      parameterData: {
                                                        'chat': widget.chat,
                                                      },
                                                    );

                                                    await NotificationRecord
                                                            .createDoc(_model
                                                                .otherUser!)
                                                        .set({
                                                      ...createNotificationRecordData(
                                                        text: _model
                                                            .messageCreated
                                                            ?.text,
                                                        image: currentUserPhoto,
                                                        seenBool: false,
                                                        isCommande: false,
                                                        isChat: true,
                                                        isFriendRequest: false,
                                                        chatRef: widget.chat,
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'userRef': [
                                                            _model.otherUser
                                                          ],
                                                          'timestamp': FieldValue
                                                              .serverTimestamp(),
                                                        },
                                                      ),
                                                    });

                                                    setState(() {});
                                                  },
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  textInputAction:
                                                      TextInputAction.send,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Commencez à écrire',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmallFamily,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmallFamily),
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    filled: true,
                                                    fillColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .transparent,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  validator: _model
                                                      .messageFieldControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderWidth: 1.0,
                                              buttonSize: 54.0,
                                              icon: Icon(
                                                FFIcons.kimage3,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 36.0,
                                              ),
                                              onPressed: () async {
                                                final selectedMedia =
                                                    await selectMediaWithSourceBottomSheet(
                                                  context: context,
                                                  maxHeight: 1000.00,
                                                  imageQuality: 70,
                                                  allowPhoto: true,
                                                  allowVideo: true,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) =>
                                                        validateFileFormat(
                                                            m.storagePath,
                                                            context))) {
                                                  setState(() => _model
                                                      .isDataUploading = true);
                                                  var selectedUploadedFiles =
                                                      <FFUploadedFile>[];

                                                  var downloadUrls = <String>[];
                                                  try {
                                                    showUploadMessage(
                                                      context,
                                                      'Uploading file...',
                                                      showLoading: true,
                                                    );
                                                    selectedUploadedFiles =
                                                        selectedMedia
                                                            .map((m) =>
                                                                FFUploadedFile(
                                                                  name: m
                                                                      .storagePath
                                                                      .split(
                                                                          '/')
                                                                      .last,
                                                                  bytes:
                                                                      m.bytes,
                                                                  height: m
                                                                      .dimensions
                                                                      ?.height,
                                                                  width: m
                                                                      .dimensions
                                                                      ?.width,
                                                                  blurHash: m
                                                                      .blurHash,
                                                                ))
                                                            .toList();

                                                    downloadUrls = (await Future
                                                            .wait(
                                                      selectedMedia.map(
                                                        (m) async =>
                                                            await uploadData(
                                                                m.storagePath,
                                                                m.bytes),
                                                      ),
                                                    ))
                                                        .where((u) => u != null)
                                                        .map((u) => u!)
                                                        .toList();
                                                  } finally {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    _model.isDataUploading =
                                                        false;
                                                  }
                                                  if (selectedUploadedFiles
                                                              .length ==
                                                          selectedMedia
                                                              .length &&
                                                      downloadUrls.length ==
                                                          selectedMedia
                                                              .length) {
                                                    setState(() {
                                                      _model.uploadedLocalFile =
                                                          selectedUploadedFiles
                                                              .first;
                                                      _model.uploadedFileUrl =
                                                          downloadUrls.first;
                                                    });
                                                    showUploadMessage(
                                                        context, 'Success!');
                                                  } else {
                                                    setState(() {});
                                                    showUploadMessage(context,
                                                        'Failed to upload data');
                                                    return;
                                                  }
                                                }

                                                var chatMessagesRecordReference =
                                                    ChatMessagesRecord
                                                        .collection
                                                        .doc();
                                                await chatMessagesRecordReference
                                                    .set({
                                                  ...createChatMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: widget.chat,
                                                    text: '',
                                                    image:
                                                        _model.uploadedFileUrl,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'time': FieldValue
                                                          .serverTimestamp(),
                                                      'users': stackChatsRecord
                                                          .users,
                                                    },
                                                  ),
                                                });
                                                _model.imageEnvoye =
                                                    ChatMessagesRecord
                                                        .getDocumentFromData({
                                                  ...createChatMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: widget.chat,
                                                    text: '',
                                                    image:
                                                        _model.uploadedFileUrl,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'time': DateTime.now(),
                                                      'users': stackChatsRecord
                                                          .users,
                                                    },
                                                  ),
                                                }, chatMessagesRecordReference);
                                                triggerPushNotification(
                                                  notificationTitle:
                                                      'Nouveau message de ${currentUserDisplayName}',
                                                  notificationText: 'Image',
                                                  notificationImageUrl:
                                                      currentUserPhoto,
                                                  notificationSound: 'default',
                                                  userRefs: [_model.otherUser!],
                                                  initialPageName: 'chatPage',
                                                  parameterData: {
                                                    'chat': widget.chat,
                                                  },
                                                );

                                                await NotificationRecord
                                                        .createDoc(
                                                            _model.otherUser!)
                                                    .set({
                                                  ...createNotificationRecordData(
                                                    text: 'Image',
                                                    image: currentUserPhoto,
                                                    seenBool: false,
                                                    isCommande: false,
                                                    isChat: true,
                                                    isFriendRequest: false,
                                                    chatRef: widget.chat,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'userRef': [
                                                        _model.otherUser
                                                      ],
                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                    },
                                                  ),
                                                });

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 16.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 8.0,
                                              borderWidth: 0.0,
                                              buttonSize: 36.0,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              icon: Icon(
                                                Icons.arrow_upward,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                size: 20.0,
                                              ),
                                              onPressed: () async {
                                                var chatMessagesRecordReference =
                                                    ChatMessagesRecord
                                                        .collection
                                                        .doc();
                                                await chatMessagesRecordReference
                                                    .set({
                                                  ...createChatMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: widget.chat,
                                                    text: _model
                                                        .messageFieldController
                                                        .text,
                                                    time: getCurrentTimestamp,
                                                    image: '',
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'users': stackChatsRecord
                                                          .users,
                                                    },
                                                  ),
                                                });
                                                _model.messageCreatedCopy =
                                                    ChatMessagesRecord
                                                        .getDocumentFromData({
                                                  ...createChatMessagesRecordData(
                                                    user: currentUserReference,
                                                    chat: widget.chat,
                                                    text: _model
                                                        .messageFieldController
                                                        .text,
                                                    time: getCurrentTimestamp,
                                                    image: '',
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'users': stackChatsRecord
                                                          .users,
                                                    },
                                                  ),
                                                }, chatMessagesRecordReference);
                                                if (_model.messageCreated
                                                            ?.image ==
                                                        null ||
                                                    _model.messageCreated
                                                            ?.image ==
                                                        '') {
                                                  await widget.chat!.update(
                                                      createChatsRecordData(
                                                    lastMessage: _model
                                                        .messageCreatedCopy
                                                        ?.text,
                                                    lastMessageTime: _model
                                                        .messageCreated?.time,
                                                    lastMessageSentBy:
                                                        currentUserReference,
                                                    lastMessageSeenBy:
                                                        currentUserReference,
                                                  ));
                                                } else {
                                                  await widget.chat!.update(
                                                      createChatsRecordData(
                                                    lastMessage: 'Image',
                                                    lastMessageTime: _model
                                                        .messageCreated?.time,
                                                    lastMessageSentBy:
                                                        currentUserReference,
                                                    lastMessageSeenBy:
                                                        currentUserReference,
                                                  ));
                                                }

                                                setState(() {
                                                  _model.messageFieldController
                                                      ?.clear();
                                                });
                                                triggerPushNotification(
                                                  notificationTitle:
                                                      'Nouveau message de ${currentUserDisplayName}',
                                                  notificationText: _model
                                                      .messageCreatedCopy!.text,
                                                  notificationImageUrl:
                                                      currentUserPhoto,
                                                  notificationSound: 'default',
                                                  userRefs: [_model.otherUser!],
                                                  initialPageName: 'chatPage',
                                                  parameterData: {
                                                    'chat': widget.chat,
                                                  },
                                                );

                                                await NotificationRecord
                                                        .createDoc(
                                                            _model.otherUser!)
                                                    .set({
                                                  ...createNotificationRecordData(
                                                    text: _model
                                                        .messageCreatedCopy
                                                        ?.text,
                                                    image: currentUserPhoto,
                                                    seenBool: false,
                                                    isCommande: false,
                                                    isChat: true,
                                                    isFriendRequest: false,
                                                    chatRef: widget.chat,
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'userRef': [
                                                        _model.otherUser
                                                      ],
                                                      'timestamp': FieldValue
                                                          .serverTimestamp(),
                                                    },
                                                  ),
                                                });

                                                setState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
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
              ).animateOnPageLoad(
                  animationsMap['containerOnPageLoadAnimation']!);
            },
          ),
        ),
      ),
    );
  }
}
