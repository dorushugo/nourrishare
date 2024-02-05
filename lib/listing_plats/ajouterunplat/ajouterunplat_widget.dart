import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components_general/choix_component/choix_component_widget.dart';
import '/components_general/no_group/no_group_widget.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'ajouterunplat_model.dart';
export 'ajouterunplat_model.dart';

class AjouterunplatWidget extends StatefulWidget {
  const AjouterunplatWidget({
    super.key,
    this.seller,
  });

  final DocumentReference? seller;

  @override
  State<AjouterunplatWidget> createState() => _AjouterunplatWidgetState();
}

class _AjouterunplatWidgetState extends State<AjouterunplatWidget> {
  late AjouterunplatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AjouterunplatModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!((valueOrDefault<bool>(
                  currentUserDocument?.stripChargesEnabled, false) ==
              true) &&
          (valueOrDefault(currentUserDocument?.stripeAccountID, '') != null &&
              valueOrDefault(currentUserDocument?.stripeAccountID, '') !=
                  ''))) {
        context.pushNamed('stripeCompletion');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Vous devez activer les paiements et vérifier votre compte avant de vendre un plat.',
              style: TextStyle(
                color: FlutterFlowTheme.of(context).primaryText,
                fontWeight: FontWeight.w500,
              ),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    });

    _model.nomPlatController ??= TextEditingController();
    _model.nomPlatFocusNode ??= FocusNode();

    _model.prixController ??= TextEditingController();
    _model.prixFocusNode ??= FocusNode();

    _model.ingredientsController ??= TextEditingController();
    _model.ingredientsFocusNode ??= FocusNode();

    _model.allergenesController ??= TextEditingController();
    _model.allergenesFocusNode ??= FocusNode();
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
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
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
                        Text(
                          'Ajouter un plat',
                          style: FlutterFlowTheme.of(context).headlineSmall,
                        ),
                        Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).grey4,
                            ),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Icon(
                              Icons.close_sharp,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          maxWidth: 1080.00,
                          maxHeight: 1080.00,
                          imageQuality: 80,
                          allowPhoto: true,
                          pickerFontFamily: 'Inter',
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          setState(() => _model.isDataUploading = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          var downloadUrls = <String>[];
                          try {
                            showUploadMessage(
                              context,
                              'Uploading file...',
                              showLoading: true,
                            );
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();

                            downloadUrls = (await Future.wait(
                              selectedMedia.map(
                                (m) async =>
                                    await uploadData(m.storagePath, m.bytes),
                              ),
                            ))
                                .where((u) => u != null)
                                .map((u) => u!)
                                .toList();
                          } finally {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            _model.isDataUploading = false;
                          }
                          if (selectedUploadedFiles.length ==
                                  selectedMedia.length &&
                              downloadUrls.length == selectedMedia.length) {
                            setState(() {
                              _model.uploadedLocalFile =
                                  selectedUploadedFiles.first;
                              _model.uploadedFileUrl = downloadUrls.first;
                            });
                            showUploadMessage(context, 'Success!');
                          } else {
                            setState(() {});
                            showUploadMessage(context, 'Failed to upload data');
                            return;
                          }
                        }

                        if (_model.uploadedFileUrl != null &&
                            _model.uploadedFileUrl != '') {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            barrierColor: Color(0x75EAF4F1),
                            isDismissible: false,
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () => _model.unfocusNode.canRequestFocus
                                    ? FocusScope.of(context)
                                        .requestFocus(_model.unfocusNode)
                                    : FocusScope.of(context).unfocus(),
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.4,
                                    child: ChoixComponentWidget(
                                      titre: 'Voulez-vous utiliser l\'IA ?',
                                      message:
                                          'Voulez-vous laisser l\'IA vous aider à renseigner les ingrédients, les allergènes et le nom de votre plat.',
                                      ctaAccept: 'Oui',
                                      ctaRefus: 'Non',
                                      boolChoice: true,
                                      actionAccept: () async {
                                        _model.analyseImageCopy =
                                            await OpenAIAPIGroup
                                                .createChatCompletionImageCall
                                                .call(
                                          imageUrl: _model.uploadedFileUrl,
                                        );
                                        if ((_model
                                                .analyseImageCopy?.succeeded ??
                                            true)) {
                                          _model.jsonPlatCopy =
                                              await OpenAIAPIGroup
                                                  .createChatCompletionTextCall
                                                  .call(
                                            descriptionPlat: functions
                                                .replaceString(OpenAIAPIGroup
                                                    .createChatCompletionImageCall
                                                    .descriptionPlat(
                                              (_model.analyseImageCopy
                                                      ?.jsonBody ??
                                                  ''),
                                            )!),
                                          );
                                          if ((_model.jsonPlatCopy?.succeeded ??
                                              true)) {
                                            _model.jsonDecodedCopy =
                                                await actions.decodeJsonAPI(
                                              OpenAIAPIGroup
                                                  .createChatCompletionTextCall
                                                  .messageJson(
                                                    (_model.jsonPlatCopy
                                                            ?.jsonBody ??
                                                        ''),
                                                  )
                                                  .toString(),
                                            );
                                            setState(() {
                                              _model.ingredientsController
                                                  ?.text = getJsonField(
                                                _model.jsonDecodedCopy,
                                                r'''$.Ingredients''',
                                              ).toString();
                                            });
                                            setState(() {
                                              _model.nomPlatController?.text =
                                                  getJsonField(
                                                _model.jsonDecodedCopy,
                                                r'''$.Name''',
                                              ).toString();
                                            });
                                            setState(() {
                                              _model.allergenesController
                                                  ?.text = getJsonField(
                                                _model.jsonDecodedCopy,
                                                r'''$.Allergenes''',
                                              ).toString();
                                            });
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Une erreur est survenue.',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                            );
                                          }
                                        } else {
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Une erreur est survenue.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        }

                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: 210.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).grey4,
                            width: 1.0,
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 40.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: true
                                        ? null
                                        : () {
                                            print('Button pressed ...');
                                          },
                                    text: 'Ajouter une photo',
                                    icon: Icon(
                                      FFIcons.kimage3,
                                      size: 15.0,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 60.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 4.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
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
                                      disabledColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_model.uploadedFileUrl != null &&
                                _model.uploadedFileUrl != '')
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  _model.uploadedFileUrl,
                                  width: double.infinity,
                                  height: 220.0,
                                  fit: BoxFit.cover,
                                  alignment: Alignment(0.0, 0.0),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: TextFormField(
                      controller: _model.nomPlatController,
                      focusNode: _model.nomPlatFocusNode,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Nom du plat',
                        labelStyle: FlutterFlowTheme.of(context)
                            .labelSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelSmallFamily),
                            ),
                        alignLabelWithHint: true,
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
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
                            color: FlutterFlowTheme.of(context).primary,
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
                        contentPadding: EdgeInsets.all(20.0),
                        prefixIcon: Icon(
                          FFIcons.kchef,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelSmallFamily),
                          ),
                      validator: _model.nomPlatControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: FlutterFlowDropDown<bool>(
                      controller: _model.typeofdishValueController ??=
                          FormFieldController<bool>(
                        _model.typeofdishValue ??= false,
                      ),
                      options: List<bool>.from([true, false]),
                      optionLabels: ['Ingrédient', 'Plat cuisiné'],
                      onChanged: (val) =>
                          setState(() => _model.typeofdishValue = val),
                      width: double.infinity,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyMediumFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.w900,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyMediumFamily),
                          ),
                      hintText: 'Quel type de plat ?',
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      elevation: 2.0,
                      borderColor: FlutterFlowTheme.of(context).grey4,
                      borderWidth: 2.0,
                      borderRadius: 20.0,
                      margin: EdgeInsets.all(20.0),
                      hidesUnderline: true,
                      isSearchable: false,
                      isMultiSelect: false,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: TextFormField(
                      controller: _model.prixController,
                      focusNode: _model.prixFocusNode,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Prix',
                        labelStyle: FlutterFlowTheme.of(context)
                            .labelSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelSmallFamily),
                            ),
                        alignLabelWithHint: true,
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
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
                            color: FlutterFlowTheme.of(context).primary,
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
                        contentPadding: EdgeInsets.all(20.0),
                        prefixIcon: Icon(
                          FFIcons.kbuy,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelSmallFamily),
                          ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      validator:
                          _model.prixControllerValidator.asValidator(context),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: TextFormField(
                      controller: _model.ingredientsController,
                      focusNode: _model.ingredientsFocusNode,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Ingrédients',
                        labelStyle: FlutterFlowTheme.of(context)
                            .labelSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelSmallFamily),
                            ),
                        alignLabelWithHint: true,
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
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
                            color: FlutterFlowTheme.of(context).primary,
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
                        contentPadding: EdgeInsets.all(20.0),
                        prefixIcon: Icon(
                          FFIcons.kproteins,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelSmallFamily),
                          ),
                      maxLines: 4,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      validator: _model.ingredientsControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: TextFormField(
                      controller: _model.allergenesController,
                      focusNode: _model.allergenesFocusNode,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Allergènes',
                        labelStyle: FlutterFlowTheme.of(context)
                            .labelSmall
                            .override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).labelSmallFamily,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context)
                                      .labelSmallFamily),
                            ),
                        alignLabelWithHint: true,
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .labelMediumFamily,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
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
                            color: FlutterFlowTheme.of(context).primary,
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
                        contentPadding: EdgeInsets.all(20.0),
                        prefixIcon: Icon(
                          FFIcons.kinfoSquare,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).labelSmallFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).labelSmallFamily),
                          ),
                      maxLines: 4,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      validator: _model.allergenesControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantité',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                        ),
                        Container(
                          width: 200.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).grey4,
                              width: 2.0,
                            ),
                          ),
                          child: FlutterFlowCountController(
                            decrementIconBuilder: (enabled) => FaIcon(
                              FontAwesomeIcons.minus,
                              color: enabled
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).alternate,
                              size: 20.0,
                            ),
                            incrementIconBuilder: (enabled) => FaIcon(
                              FontAwesomeIcons.plus,
                              color: enabled
                                  ? FlutterFlowTheme.of(context).primary
                                  : FlutterFlowTheme.of(context).alternate,
                              size: 20.0,
                            ),
                            countBuilder: (count) => Text(
                              count.toString(),
                              style: FlutterFlowTheme.of(context).titleLarge,
                            ),
                            count: _model.nombreValue ??= 1,
                            updateCount: (count) =>
                                setState(() => _model.nombreValue = count),
                            stepSize: 1,
                            minimum: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 8.0),
                            child: Text(
                              'À qui souhaitez vous vendre ce plat ?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w900,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                          ),
                        ),
                        FlutterFlowDropDown<int>(
                          controller: _model.placedeventeValueController ??=
                              FormFieldController<int>(
                            _model.placedeventeValue ??= 4,
                          ),
                          options: List<int>.from([1, 3, 2, 4]),
                          optionLabels: [
                            'Mes voisins',
                            'Toutes les personnes dans mes groupes',
                            'À tout le monde (voisins et groupes)',
                            'À un ou des groupes en particulier'
                          ],
                          onChanged: (val) =>
                              setState(() => _model.placedeventeValue = val),
                          width: double.infinity,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyMediumFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontWeight: FontWeight.w900,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyMediumFamily),
                              ),
                          hintText: 'À qui voulez vous proposer ce plat ?',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          elevation: 2.0,
                          borderColor: FlutterFlowTheme.of(context).grey4,
                          borderWidth: 2.0,
                          borderRadius: 20.0,
                          margin: EdgeInsets.all(20.0),
                          hidesUnderline: true,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (_model.placedeventeValue.toString() == '4')
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 8.0),
                            child: Text(
                              'À quels groupes voulez-vous vendre ?',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w900,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                  ),
                            ),
                          ),
                        ),
                      if (_model.placedeventeValue.toString() == '4')
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 315.0,
                          ),
                          decoration: BoxDecoration(),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 12.0, 24.0, 44.0),
                                  child: StreamBuilder<List<GroupesRecord>>(
                                    stream: queryGroupesRecord(
                                      queryBuilder: (groupesRecord) =>
                                          groupesRecord
                                              .where(
                                                'Users',
                                                arrayContains:
                                                    currentUserReference,
                                              )
                                              .where(
                                                'display_name',
                                                isNotEqualTo: 'Groupe supprimé',
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
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      List<GroupesRecord>
                                          listViewGroupesRecordList =
                                          snapshot.data!;
                                      if (listViewGroupesRecordList.isEmpty) {
                                        return Center(
                                          child: NoGroupWidget(),
                                        );
                                      }
                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            listViewGroupesRecordList.length,
                                        itemBuilder: (context, listViewIndex) {
                                          final listViewGroupesRecord =
                                              listViewGroupesRecordList[
                                                  listViewIndex];
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 0.0, 8.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              26.0),
                                                      child: Image.network(
                                                        listViewGroupesRecord
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
                                                                .fromSTEB(
                                                                    12.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
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
                                                              listViewGroupesRecord
                                                                  .displayName,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Plus Jakarta Sans',
                                                                    color: Color(
                                                                        0xFF14181B),
                                                                    fontSize:
                                                                        14.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyMediumFamily),
                                                                  ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          4.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    '${listViewGroupesRecord.users.length.toString()} membres',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Plus Jakarta Sans',
                                                                          color:
                                                                              Color(0xFF57636C),
                                                                          fontSize:
                                                                              14.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
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
                                                                    .circular(
                                                                        4.0),
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
                                                            listViewGroupesRecord] ??= false,
                                                        onChanged:
                                                            (newValue) async {
                                                          setState(() => _model
                                                                      .checkboxValueMap[
                                                                  listViewGroupesRecord] =
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
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 40.0),
                    child: FFButtonWidget(
                      onPressed: ((_model.nomPlatController.text == null ||
                                  _model.nomPlatController.text == '') &&
                              (_model.prixController.text != null &&
                                  _model.prixController.text != '') &&
                              (_model.uploadedFileUrl != null &&
                                  _model.uploadedFileUrl != '') &&
                              (_model.ingredientsController.text != null &&
                                  _model.ingredientsController.text != ''))
                          ? null
                          : () async {
                              var platsRecordReference =
                                  PlatsRecord.collection.doc();
                              await platsRecordReference.set({
                                ...createPlatsRecordData(
                                  name: _model.nomPlatController.text,
                                  seller: currentUserReference,
                                  ingredients:
                                      _model.ingredientsController.text,
                                  allergnes: _model.allergenesController.text,
                                  etat: _model.placedeventeValue,
                                  quantite: _model.nombreValue,
                                  prix: double.tryParse(
                                      _model.prixController.text),
                                  ingredientstype: _model.typeofdishValue,
                                ),
                                ...mapToFirestore(
                                  {
                                    'images': [_model.uploadedFileUrl],
                                    'created_time':
                                        FieldValue.serverTimestamp(),
                                  },
                                ),
                              });
                              _model.creerPlat =
                                  PlatsRecord.getDocumentFromData({
                                ...createPlatsRecordData(
                                  name: _model.nomPlatController.text,
                                  seller: currentUserReference,
                                  ingredients:
                                      _model.ingredientsController.text,
                                  allergnes: _model.allergenesController.text,
                                  etat: _model.placedeventeValue,
                                  quantite: _model.nombreValue,
                                  prix: double.tryParse(
                                      _model.prixController.text),
                                  ingredientstype: _model.typeofdishValue,
                                ),
                                ...mapToFirestore(
                                  {
                                    'images': [_model.uploadedFileUrl],
                                    'created_time': DateTime.now(),
                                  },
                                ),
                              }, platsRecordReference);
                              if (_model.placedeventeValue == 4) {
                                await _model.creerPlat!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'groupe_destine': _model
                                          .checkboxCheckedItems
                                          .map((e) => e.reference)
                                          .toList(),
                                    },
                                  ),
                                });
                              }
                              if ((_model.placedeventeValue == 4) &&
                                  (_model.placedeventeValue! > 1)) {
                                await _model.creerPlat!.reference.update({
                                  ...mapToFirestore(
                                    {
                                      'groupe_destine': (currentUserDocument
                                              ?.groupes
                                              ?.toList() ??
                                          []),
                                    },
                                  ),
                                });
                              }

                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'plats': FieldValue.arrayUnion(
                                        [_model.creerPlat?.reference]),
                                  },
                                ),
                              });

                              context.goNamed(
                                'Plats_details',
                                queryParameters: {
                                  'plats': serializeParam(
                                    _model.creerPlat?.reference,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );

                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Votre plat à bien été publié'),
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

                              setState(() {});
                            },
                      text: 'Mettre en vente',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 60.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondary,
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
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        disabledColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        disabledTextColor: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 24.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
