import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'no_chats_model.dart';
export 'no_chats_model.dart';

class NoChatsWidget extends StatefulWidget {
  const NoChatsWidget({super.key});

  @override
  State<NoChatsWidget> createState() => _NoChatsWidgetState();
}

class _NoChatsWidgetState extends State<NoChatsWidget> {
  late NoChatsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoChatsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.asset(
              'assets/images/Woman_making_a_video_call.svg',
              height: 170.0,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
            child: Text(
              'Vous n\'avez pas encore de conversation active !',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).bodyMediumFamily),
                  ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
          child: FFButtonWidget(
            onPressed: () async {
              context.pushNamed('rechercheMessage');
            },
            text: 'Démarrer une conversation',
            options: FFButtonOptions(
              width: double.infinity,
              height: 56.0,
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              color: FlutterFlowTheme.of(context).secondary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                    color: Colors.white,
                    useGoogleFonts: GoogleFonts.asMap().containsKey(
                        FlutterFlowTheme.of(context).titleSmallFamily),
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
      ],
    );
  }
}
