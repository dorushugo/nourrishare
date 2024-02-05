import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:io';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profilsettings_model.dart';
export 'profilsettings_model.dart';

class ProfilsettingsWidget extends StatefulWidget {
  const ProfilsettingsWidget({super.key});

  @override
  State<ProfilsettingsWidget> createState() => _ProfilsettingsWidgetState();
}

class _ProfilsettingsWidgetState extends State<ProfilsettingsWidget> {
  late ProfilsettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilsettingsModel());

    _model.prenomController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.lastName, ''));
    _model.prenomFocusNode ??= FocusNode();

    _model.nomController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.firstName, ''));
    _model.nomFocusNode ??= FocusNode();

    _model.mailController ??= TextEditingController(text: currentUserEmail);
    _model.mailFocusNode ??= FocusNode();

    _model.phoneNumberController ??=
        TextEditingController(text: currentPhoneNumber);
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.addressController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.address, ''));
    _model.addressFocusNode ??= FocusNode();

    _model.cityController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.city, ''));
    _model.cityFocusNode ??= FocusNode();

    _model.postalCodeController ??= TextEditingController(
        text: valueOrDefault(currentUserDocument?.postalCode, ''));
    _model.postalCodeFocusNode ??= FocusNode();
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
        resizeToAvoidBottomInset: false,
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
              context.safePop();
            },
          ),
          title: Text(
            'Modifer vos informations',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Avenir',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w900,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineSmallFamily),
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AuthUserStreamWidget(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    final selectedMedia =
                                        await selectMediaWithSourceBottomSheet(
                                      context: context,
                                      imageQuality: 100,
                                      allowPhoto: true,
                                      textColor:
                                          FlutterFlowTheme.of(context).primary,
                                      pickerFontFamily: 'Roboto',
                                    );
                                    if (selectedMedia != null &&
                                        selectedMedia.every((m) =>
                                            validateFileFormat(
                                                m.storagePath, context))) {
                                      setState(
                                          () => _model.isDataUploading = true);
                                      var selectedUploadedFiles =
                                          <FFUploadedFile>[];

                                      var downloadUrls = <String>[];
                                      try {
                                        showUploadMessage(
                                          context,
                                          'Uploading file...',
                                          showLoading: true,
                                        );
                                        selectedUploadedFiles = selectedMedia
                                            .map((m) => FFUploadedFile(
                                                  name: m.storagePath
                                                      .split('/')
                                                      .last,
                                                  bytes: m.bytes,
                                                  height: m.dimensions?.height,
                                                  width: m.dimensions?.width,
                                                  blurHash: m.blurHash,
                                                ))
                                            .toList();

                                        downloadUrls = (await Future.wait(
                                          selectedMedia.map(
                                            (m) async => await uploadData(
                                                m.storagePath, m.bytes),
                                          ),
                                        ))
                                            .where((u) => u != null)
                                            .map((u) => u!)
                                            .toList();
                                      } finally {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                        _model.isDataUploading = false;
                                      }
                                      if (selectedUploadedFiles.length ==
                                              selectedMedia.length &&
                                          downloadUrls.length ==
                                              selectedMedia.length) {
                                        setState(() {
                                          _model.uploadedLocalFile =
                                              selectedUploadedFiles.first;
                                          _model.uploadedFileUrl =
                                              downloadUrls.first;
                                        });
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        setState(() {});
                                        showUploadMessage(
                                            context, 'Failed to upload data');
                                        return;
                                      }
                                    }

                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 120.0,
                                    height: 120.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.network(
                                          currentUserPhoto,
                                        ).image,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        if (_model.uploadedFileUrl != null &&
                                            _model.uploadedFileUrl != '')
                                          Container(
                                            width: 120.0,
                                            height: 120.0,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              _model.uploadedFileUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        if ((_model.uploadedFileUrl == null ||
                                                _model.uploadedFileUrl == '') &&
                                            (currentUserPhoto == null ||
                                                currentUserPhoto == ''))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Icon(
                                              FFIcons.kimage3,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 60.0,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: AuthUserStreamWidget(
                                      builder: (context) => TextFormField(
                                        controller: _model.prenomController,
                                        focusNode: _model.prenomFocusNode,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Prenom',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily),
                                              ),
                                          alignLabelWithHint: true,
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color: Color(0xFFEAF4F1),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAF4F1),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          contentPadding: EdgeInsets.all(17.0),
                                          prefixIcon: Icon(
                                            FFIcons.kaccountIcon2,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w900,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallFamily),
                                            ),
                                        textAlign: TextAlign.start,
                                        validator: _model
                                            .prenomControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: AuthUserStreamWidget(
                                      builder: (context) => TextFormField(
                                        controller: _model.nomController,
                                        focusNode: _model.nomFocusNode,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Nom',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily),
                                              ),
                                          alignLabelWithHint: true,
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                color: Color(0xFFEAF4F1),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAF4F1),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          contentPadding: EdgeInsets.all(16.0),
                                          prefixIcon: Icon(
                                            FFIcons.kaccountIcon2,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w900,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallFamily),
                                            ),
                                        textAlign: TextAlign.start,
                                        validator: _model.nomControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 24.0)),
                              ),
                              TextFormField(
                                controller: _model.mailController,
                                focusNode: _model.mailFocusNode,
                                textCapitalization: TextCapitalization.none,
                                textInputAction: TextInputAction.next,
                                readOnly: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Adresse email',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily),
                                      ),
                                  alignLabelWithHint: true,
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFEAF4F1),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  contentPadding: EdgeInsets.all(16.0),
                                  prefixIcon: Icon(
                                    FFIcons.kmessage,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20.0,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelSmallFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily),
                                    ),
                                keyboardType: TextInputType.emailAddress,
                                validator: _model.mailControllerValidator
                                    .asValidator(context),
                              ),
                              AuthUserStreamWidget(
                                builder: (context) => TextFormField(
                                  controller: _model.phoneNumberController,
                                  focusNode: _model.phoneNumberFocusNode,
                                  textCapitalization: TextCapitalization.none,
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Numéro de téléphone',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmallFamily,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w900,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily),
                                        ),
                                    alignLabelWithHint: true,
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .labelMediumFamily,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .labelMediumFamily),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFEAF4F1),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    prefixIcon: Icon(
                                      FFIcons.kcall,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelSmallFamily),
                                      ),
                                  keyboardType: TextInputType.phone,
                                  validator: _model
                                      .phoneNumberControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet<bool>(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.date,
                                            minimumDate: DateTime(1900),
                                            initialDateTime: functions
                                                .returnDate13YearsAgo(),
                                            maximumDate: functions
                                                .returnDate13YearsAgo(),
                                            use24hFormat: false,
                                            onDateTimeChanged: (newDateTime) =>
                                                safeSetState(() {
                                              _model.datePicked = newDateTime;
                                            }),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context).grey4,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                        child: Icon(
                                          FFIcons.kbirth,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                        child: AuthUserStreamWidget(
                                          builder: (context) => Text(
                                            () {
                                              if (_model.datePicked != null) {
                                                return dateTimeFormat(
                                                  'd/M/y',
                                                  _model.datePicked,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                );
                                              } else if (currentUserDocument
                                                      ?.dateOfBirth !=
                                                  null) {
                                                return dateTimeFormat(
                                                  'd/M/y',
                                                  currentUserDocument!
                                                      .dateOfBirth!,
                                                  locale: FFLocalizations.of(
                                                          context)
                                                      .languageCode,
                                                );
                                              } else {
                                                return 'Date de naissance';
                                              }
                                            }(),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMediumFamily,
                                                  color: () {
                                                    if (_model.datePicked !=
                                                        null) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .primaryText;
                                                    } else if (currentUserDocument
                                                            ?.dateOfBirth !=
                                                        null) {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .primaryText;
                                                    } else {
                                                      return FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryText;
                                                    }
                                                  }(),
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
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Theme(
                                    data: ThemeData(
                                      checkboxTheme: CheckboxThemeData(
                                        visualDensity: VisualDensity.compact,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      unselectedWidgetColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                    ),
                                    child: Checkbox(
                                      value: _model.checkboxValue ??= true,
                                      onChanged: (newValue) async {
                                        setState(() =>
                                            _model.checkboxValue = newValue!);
                                      },
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      checkColor:
                                          FlutterFlowTheme.of(context).info,
                                    ),
                                  ),
                                  Text(
                                    'Je veux vendre des plats',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w900,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMediumFamily),
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 200.0,
                                child: Divider(
                                  thickness: 1.0,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await currentUserReference!.update({
                                        ...createUsersRecordData(
                                          email: _model.mailController.text,
                                          phoneNumber:
                                              _model.phoneNumberController.text,
                                          chief: _model.checkboxValue,
                                          firstName: _model.nomController.text,
                                          lastName:
                                              _model.prenomController.text,
                                          displayName:
                                              '${_model.prenomController.text} ${_model.nomController.text}',
                                          dateOfBirth: _model.datePicked,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'created_time':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      if (_model.uploadedFileUrl != null &&
                                          _model.uploadedFileUrl != '') {
                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          photoUrl: _model.uploadedFileUrl,
                                        ));
                                      }
                                      if (_model.checkboxValue == false) {
                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          chief: false,
                                        ));
                                      }
                                      setState(() {
                                        _model.mapUI = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => TextFormField(
                                          controller: _model.addressController,
                                          focusNode: _model.addressFocusNode,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          textInputAction: TextInputAction.next,
                                          readOnly: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Adresse',
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmallFamily,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmallFamily),
                                                    ),
                                            alignLabelWithHint: true,
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMediumFamily,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMediumFamily),
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFEAF4F1),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            contentPadding:
                                                EdgeInsets.all(16.0),
                                            prefixIcon: Icon(
                                              FFIcons.klocation1,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily),
                                              ),
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          validator: _model
                                              .addressControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    AuthUserStreamWidget(
                                      builder: (context) => TextFormField(
                                        controller: _model.cityController,
                                        focusNode: _model.cityFocusNode,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        textInputAction: TextInputAction.next,
                                        readOnly: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Adresse',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily),
                                              ),
                                          alignLabelWithHint: true,
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAF4F1),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          contentPadding: EdgeInsets.all(16.0),
                                          prefixIcon: Icon(
                                            FFIcons.klocation1,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w900,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallFamily),
                                            ),
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: _model
                                            .cityControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                    tabletLandscape: false,
                                    desktop: false,
                                  ))
                                    AuthUserStreamWidget(
                                      builder: (context) => TextFormField(
                                        controller: _model.postalCodeController,
                                        focusNode: _model.postalCodeFocusNode,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        textInputAction: TextInputAction.next,
                                        readOnly: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Code postal',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmallFamily,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w900,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmallFamily),
                                              ),
                                          alignLabelWithHint: true,
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMediumFamily,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMediumFamily),
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFEAF4F1),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          contentPadding: EdgeInsets.all(16.0),
                                          prefixIcon: Icon(
                                            FFIcons.klocation1,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmallFamily,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w900,
                                              useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                  .containsKey(
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmallFamily),
                                            ),
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        validator: _model
                                            .postalCodeControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                ],
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  await currentUserReference!.update({
                                    ...createUsersRecordData(
                                      email: _model.mailController.text,
                                      phoneNumber:
                                          _model.phoneNumberController.text,
                                      chief: _model.checkboxValue,
                                      firstName: _model.nomController.text,
                                      lastName: _model.prenomController.text,
                                      displayName:
                                          '${_model.prenomController.text} ${_model.nomController.text}',
                                      dateOfBirth: _model.datePicked,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'created_time':
                                            FieldValue.serverTimestamp(),
                                      },
                                    ),
                                  });
                                  if (_model.uploadedFileUrl != null &&
                                      _model.uploadedFileUrl != '') {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      photoUrl: _model.uploadedFileUrl,
                                    ));
                                  }
                                  if (_model.checkboxValue == false) {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      chief: false,
                                    ));
                                  }
                                  setState(() {
                                    _model.mapUI = true;
                                  });
                                },
                                text: 'Modifier mon adresse',
                                icon: Icon(
                                  Icons.place,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 18.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 56.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsets.all(0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .titleSmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 40.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await currentUserReference!.update({
                                      ...createUsersRecordData(
                                        email: _model.mailController.text,
                                        phoneNumber:
                                            _model.phoneNumberController.text,
                                        chief: _model.checkboxValue,
                                        firstName: _model.nomController.text,
                                        lastName: _model.prenomController.text,
                                        displayName:
                                            '${_model.prenomController.text} ${_model.nomController.text}',
                                        dateOfBirth: _model.datePicked,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'created_time':
                                              FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                    if (_model.uploadedFileUrl != null &&
                                        _model.uploadedFileUrl != '') {
                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        photoUrl: _model.uploadedFileUrl,
                                      ));
                                    }
                                    if (_model.checkboxValue == true) {
                                      context.pushNamed('stripeCompletion');
                                    } else {
                                      await currentUserReference!
                                          .update(createUsersRecordData(
                                        chief: false,
                                      ));

                                      context.goNamed('Accueil');
                                    }
                                  },
                                  text: 'Confirmer',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 56.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 12.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily:
                                              FlutterFlowTheme.of(context)
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
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                    ),
                  ),
                ),
                if (_model.mapUI)
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 100.0,
                                  constraints: BoxConstraints(
                                    minWidth: double.infinity,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: AuthUserStreamWidget(
                                    builder: (context) =>
                                        Builder(builder: (context) {
                                      final _googleMapMarker =
                                          _model.addresspickerValue.latLng;
                                      return FlutterFlowGoogleMap(
                                        controller: _model.googleMapsController,
                                        onCameraIdle: (latLng) =>
                                            _model.googleMapsCenter = latLng,
                                        initialLocation:
                                            _model.googleMapsCenter ??=
                                                currentUserDocument!.latlong!,
                                        markers: [
                                          if (_googleMapMarker != null)
                                            FlutterFlowMarker(
                                              _googleMapMarker.serialize(),
                                              _googleMapMarker,
                                            ),
                                        ],
                                        markerColor: GoogleMarkerColor.green,
                                        mapType: MapType.normal,
                                        style: GoogleMapStyle.standard,
                                        initialZoom: 15.0,
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
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 40.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 24.0),
                                      child: FlutterFlowPlacePicker(
                                        iOSGoogleMapsApiKey:
                                            'AIzaSyApJ9kk7bYiShcUpRkQtpXgGILrkTFYcH0',
                                        androidGoogleMapsApiKey:
                                            'AIzaSyBcXycYHfurxC6bI2Kp0cqlvZ474Ez5nMo',
                                        webGoogleMapsApiKey:
                                            'AIzaSyC9lduemygUWHmGX2Dr9qC2LoveDM_xxX8',
                                        onSelect: (place) async {
                                          setState(() => _model
                                              .addresspickerValue = place);
                                          (await _model
                                                  .googleMapsController.future)
                                              .animateCamera(
                                                  CameraUpdate.newLatLng(place
                                                      .latLng
                                                      .toGoogleMaps()));
                                        },
                                        defaultText: 'Rechercher mon adresse',
                                        icon: Icon(
                                          Icons.place,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 16.0,
                                        ),
                                        buttonOptions: FFButtonOptions(
                                          width: double.infinity,
                                          height: 56.0,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmallFamily,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmallFamily),
                                              ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .transparent,
                                            width: 0.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (_model.googleMapsCenter != null) {
                                          await currentUserReference!
                                              .update(createUsersRecordData(
                                            latlong: _model
                                                .addresspickerValue.latLng,
                                            address: _model
                                                .addresspickerValue.address,
                                            city:
                                                _model.addresspickerValue.city,
                                            postalCode: _model
                                                .addresspickerValue.zipCode,
                                          ));
                                          setState(() {
                                            _model.addressController?.text =
                                                valueOrDefault(
                                                    currentUserDocument
                                                        ?.address,
                                                    '');
                                          });
                                          setState(() {
                                            _model.mapUI = false;
                                          });
                                        }
                                      },
                                      text: 'Confirmer',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 56.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 12.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
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
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
