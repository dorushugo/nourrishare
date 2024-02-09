import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'stripe_completion_model.dart';
export 'stripe_completion_model.dart';

class StripeCompletionWidget extends StatefulWidget {
  const StripeCompletionWidget({super.key});

  @override
  State<StripeCompletionWidget> createState() => _StripeCompletionWidgetState();
}

class _StripeCompletionWidgetState extends State<StripeCompletionWidget> {
  late StripeCompletionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StripeCompletionModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((valueOrDefault(currentUserDocument?.stripeAccountID, '') != '') &&
          !valueOrDefault<bool>(
              currentUserDocument?.stripChargesEnabled, false)) {
        _model.checkOnboardingOnLoad =
            await StripeGroup.retrieveAccountInformationCall.call(
          accountID: valueOrDefault(currentUserDocument?.stripeAccountID, ''),
        );
        if (StripeGroup.retrieveAccountInformationCall.accountOnboardingFinish(
          (_model.checkOnboardingOnLoad?.jsonBody ?? ''),
        )!) {
          await currentUserReference!.update(createUsersRecordData(
            stripChargesEnabled: true,
          ));
        }
      }
    });
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
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/Online_delivery.svg',
                                width: double.infinity,
                                height: 318.0,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 40.0),
                              child: RichText(
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: (valueOrDefault(
                                                          currentUserDocument
                                                              ?.stripeAccountID,
                                                          '') !=
                                                      '') &&
                                              valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.stripChargesEnabled,
                                                  false)
                                          ? 'Les paiements sont déjà activés. Tout est en règle !'
                                          : 'Activez la réception des paiements sécurisés',
                                      style: FlutterFlowTheme.of(context)
                                          .headlineLarge,
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .headlineLarge,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ].divide(const SizedBox(height: 24.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (valueOrDefault(
                                        currentUserDocument?.stripeAccountID,
                                        '') ==
                                    '')
                              AuthUserStreamWidget(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      stripChargesEnabled: false,
                                    ));
                                    if (valueOrDefault(
                                                currentUserDocument
                                                    ?.stripeAccountID,
                                                '') ==
                                            '') {
                                      _model.createdStripeAccount =
                                          await StripeGroup.accountsCall.call(
                                        businessType: 'individual',
                                        country: 'fr',
                                        email: currentUserEmail,
                                        type: 'express',
                                        firstName: valueOrDefault(
                                            currentUserDocument?.firstName, ''),
                                        lastName: valueOrDefault(
                                            currentUserDocument?.lastName, ''),
                                        productDescription:
                                            'Vente de plats en ligne.',
                                        currency: 'eur',
                                        city: valueOrDefault(
                                            currentUserDocument?.city, ''),
                                        adressLine1: valueOrDefault(
                                            currentUserDocument?.address, ''),
                                        postalCode: valueOrDefault(
                                            currentUserDocument?.postalCode,
                                            ''),
                                        individualDobDay: functions
                                            .returnDobFields(
                                                currentUserDocument!
                                                    .dateOfBirth!)
                                            .first,
                                        individualDobMonth:
                                            functions.returnDobFields(
                                                currentUserDocument!
                                                    .dateOfBirth!)[1],
                                        individualDobYear:
                                            functions.returnDobFields(
                                                currentUserDocument!
                                                    .dateOfBirth!)[2],
                                        phone: currentPhoneNumber,
                                      );
                                      if ((_model.createdStripeAccount
                                              ?.succeeded ??
                                          true)) {
                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          stripeAccountID:
                                              StripeGroup.accountsCall.id(
                                            (_model.createdStripeAccount
                                                    ?.jsonBody ??
                                                ''),
                                          ),
                                        ));
                                        _model.createdAccountLink =
                                            await StripeGroup
                                                .createAccountLinkCall
                                                .call(
                                          account: valueOrDefault(
                                              currentUserDocument
                                                  ?.stripeAccountID,
                                              ''),
                                          type: 'account_onboarding',
                                          refreshUrl:
                                              'https://nourrishare.com/erreur-creation-de-compte/',
                                          returnUrl:
                                              'https://nourrishare.com/sucess-account-link/',
                                        );
                                        if ((_model.createdAccountLink
                                                ?.succeeded ??
                                            true)) {
                                          await currentUserReference!
                                              .update(createUsersRecordData(
                                            createStripeAccountUrl: StripeGroup
                                                .createAccountLinkCall
                                                .url(
                                              (_model.createdAccountLink
                                                      ?.jsonBody ??
                                                  ''),
                                            ),
                                          ));
                                          await launchURL(StripeGroup
                                              .createAccountLinkCall
                                              .url(
                                            (_model.createdAccountLink
                                                    ?.jsonBody ??
                                                ''),
                                          )!);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Erreur lors du lien avec votre compte Stripe',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                          );
                                        }
                                      }
                                    }

                                    setState(() {});
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'q6dxdn05' /* Activer les paiements */,
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
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            if ((valueOrDefault(
                                            currentUserDocument
                                                ?.stripeAccountID,
                                            '') !=
                                        '') &&
                                ((valueOrDefault<bool>(
                                            currentUserDocument
                                                ?.stripChargesEnabled,
                                            false) ==
                                        null) ||
                                    (valueOrDefault<bool>(
                                            currentUserDocument
                                                ?.stripChargesEnabled,
                                            false) ==
                                        false)))
                              Align(
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      if (valueOrDefault(
                                                  currentUserDocument
                                                      ?.createStripeAccountUrl,
                                                  '') ==
                                              '') {
                                        _model.createdAccountLink2 =
                                            await StripeGroup
                                                .createAccountLinkCall
                                                .call(
                                          account: valueOrDefault(
                                              currentUserDocument
                                                  ?.stripeAccountID,
                                              ''),
                                          type: 'account_onboarding',
                                          refreshUrl:
                                              'https://nourrishare.com/erreur-creation-de-compte/',
                                          returnUrl:
                                              'https://nourrishare.com/sucess-account-link/',
                                        );
                                        if ((_model.createdAccountLink2
                                                ?.succeeded ??
                                            true)) {
                                          await currentUserReference!
                                              .update(createUsersRecordData(
                                            createStripeAccountUrl: StripeGroup
                                                .createAccountLinkCall
                                                .url(
                                              (_model.createdAccountLink2
                                                      ?.jsonBody ??
                                                  ''),
                                            ),
                                          ));
                                          await launchURL(StripeGroup
                                              .createAccountLinkCall
                                              .url(
                                            (_model.createdAccountLink2
                                                    ?.jsonBody ??
                                                ''),
                                          )!);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Erreur lors du lien avec votre compte Stripe',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                          );
                                        }
                                      } else {
                                        _model.retrievedAccountID =
                                            await StripeGroup
                                                .retrieveAccountInformationCall
                                                .call(
                                          accountID: valueOrDefault(
                                              currentUserDocument
                                                  ?.stripeAccountID,
                                              ''),
                                        );
                                        if (StripeGroup
                                            .retrieveAccountInformationCall
                                            .accountOnboardingFinish(
                                          (_model.retrievedAccountID
                                                  ?.jsonBody ??
                                              ''),
                                        )!) {
                                          await currentUserReference!
                                              .update(createUsersRecordData(
                                            stripChargesEnabled: true,
                                          ));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Votre compte a bien été validé',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          );
                                        } else {
                                          _model.createdAccountLink3 =
                                              await StripeGroup
                                                  .createAccountLinkCall
                                                  .call(
                                            account: valueOrDefault(
                                                currentUserDocument
                                                    ?.stripeAccountID,
                                                ''),
                                            type: 'account_onboarding',
                                            refreshUrl:
                                                'https://nourrishare.com/erreur-creation-de-compte/',
                                            returnUrl:
                                                'https://nourrishare.com/sucess-account-link/',
                                          );
                                          if ((_model.createdAccountLink3
                                                  ?.succeeded ??
                                              true)) {
                                            await currentUserReference!
                                                .update(createUsersRecordData(
                                              createStripeAccountUrl:
                                                  StripeGroup
                                                      .createAccountLinkCall
                                                      .url(
                                                (_model.createdAccountLink3
                                                        ?.jsonBody ??
                                                    ''),
                                              ),
                                            ));
                                            await launchURL(StripeGroup
                                                .createAccountLinkCall
                                                .url(
                                              (_model.createdAccountLink3
                                                      ?.jsonBody ??
                                                  ''),
                                            )!);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Erreur lors du lien avec votre compte Stripe',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                            );
                                          }
                                        }
                                      }

                                      setState(() {});
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'jleahain' /* Valider mon compte */,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 56.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 8.0, 0.0),
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
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            if ((valueOrDefault(
                                            currentUserDocument
                                                ?.stripeAccountID,
                                            '') !=
                                        '') &&
                                valueOrDefault<bool>(
                                    currentUserDocument?.stripChargesEnabled,
                                    false))
                              Align(
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      context.goNamed('Profilpage');
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'c4cuy1n3' /* Continuer */,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 56.0,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 8.0, 0.0),
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
                                      borderSide: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                ),
                              ),
                            if ((valueOrDefault(
                                            currentUserDocument
                                                ?.stripeAccountID,
                                            '') ==
                                        '') ||
                                !valueOrDefault<bool>(
                                    currentUserDocument?.stripChargesEnabled,
                                    false))
                              AuthUserStreamWidget(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      stripChargesEnabled: false,
                                    ));

                                    context.pushNamed('Accueil');
                                  },
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'z4d7ne6t' /* Plus tard */,
                                    ),
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
                                ),
                              ),
                          ].divide(const SizedBox(height: 24.0)),
                        ),
                      ].divide(const SizedBox(height: 24.0)),
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
