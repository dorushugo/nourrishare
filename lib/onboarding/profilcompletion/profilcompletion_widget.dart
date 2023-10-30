import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/place.dart';
import 'dart:io';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profilcompletion_model.dart';
export 'profilcompletion_model.dart';

class ProfilcompletionWidget extends StatefulWidget {
  const ProfilcompletionWidget({Key? key}) : super(key: key);

  @override
  _ProfilcompletionWidgetState createState() => _ProfilcompletionWidgetState();
}

class _ProfilcompletionWidgetState extends State<ProfilcompletionWidget> {
  late ProfilcompletionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilcompletionModel());

    _model.phoneNumberController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          _model.phoneNumberController?.text = '0612345678';
        }));
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
        title: 'Profilcompletion',
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
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/Food_delivery_craft_package_-_Moyenne.png',
                                width: double.infinity,
                                height: 318.0,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 40.0),
                              child: RichText(
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Bienvenue ',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge,
                                    ),
                                    TextSpan(
                                      text: currentUserDisplayName,
                                      style: TextStyle(),
                                    ),
                                    TextSpan(
                                      text: ' !',
                                      style: TextStyle(),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.phoneNumberController,
                              focusNode: _model.phoneNumberFocusNode,
                              autofocus: true,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Numéro de téléphone',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .labelLargeFamily,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .labelLargeFamily),
                                    ),
                                hintStyle:
                                    FlutterFlowTheme.of(context).labelMedium,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .labelSmallFamily,
                                    fontSize: 16.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .labelSmallFamily),
                                  ),
                              keyboardType: TextInputType.phone,
                              validator: _model.phoneNumberControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'))
                              ],
                            ),
                            FlutterFlowCheckboxGroup(
                              options: ['Je veux vendre des plats'],
                              onChanged: (val) =>
                                  setState(() => _model.chefboxValues = val),
                              controller: _model.chefboxValueController ??=
                                  FormFieldController<List<String>>(
                                ['Je veux vendre des plats'],
                              ),
                              activeColor: FlutterFlowTheme.of(context).primary,
                              checkColor: FlutterFlowTheme.of(context).info,
                              checkboxBorderColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              textStyle:
                                  FlutterFlowTheme.of(context).labelLarge,
                              unselectedTextStyle:
                                  FlutterFlowTheme.of(context).bodyMedium,
                              checkboxBorderRadius: BorderRadius.circular(4.0),
                              initialized: _model.chefboxValues != null,
                            ),
                            FlutterFlowPlacePicker(
                              iOSGoogleMapsApiKey:
                                  'AIzaSyApJ9kk7bYiShcUpRkQtpXgGILrkTFYcH0',
                              androidGoogleMapsApiKey:
                                  'AIzaSyBcXycYHfurxC6bI2Kp0cqlvZ474Ez5nMo',
                              webGoogleMapsApiKey:
                                  'AIzaSyC9lduemygUWHmGX2Dr9qC2LoveDM_xxX8',
                              onSelect: (place) async {
                                setState(
                                    () => _model.addresspickerValue = place);
                              },
                              defaultText: 'Mon adresse',
                              icon: Icon(
                                Icons.place,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 16.0,
                              ),
                              buttonOptions: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                color: Color(0x00FFFFFF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .titleSmallFamily,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                            SizedBox(
                              width: 200.0,
                              child: Divider(
                                thickness: 1.0,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  phoneNumber:
                                      _model.phoneNumberController.text,
                                  address: _model.addresspickerValue.address,
                                  latlong: _model.addresspickerValue.latLng,
                                ));
                                if (_model.chefboxValues?.first == 'True') {
                                  await currentUserReference!
                                      .update(createUsersRecordData(
                                    chief: true,
                                  ));
                                } else {
                                  await currentUserReference!
                                      .update(createUsersRecordData(
                                    chief: false,
                                  ));
                                }

                                context.pushNamed('Accueil');

                                _model.geohash = await actions.geoHashMixed(
                                  currentUserDocument!.latlong!,
                                );

                                await currentUserReference!
                                    .update(createUsersRecordData(
                                  geohash: _model.geohash,
                                ));

                                setState(() {});
                              },
                              text: 'Continuer',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 56.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 0.0),
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
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
