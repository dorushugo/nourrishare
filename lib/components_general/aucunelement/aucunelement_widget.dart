import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'aucunelement_model.dart';
export 'aucunelement_model.dart';

class AucunelementWidget extends StatefulWidget {
  const AucunelementWidget({Key? key}) : super(key: key);

  @override
  _AucunelementWidgetState createState() => _AucunelementWidgetState();
}

class _AucunelementWidgetState extends State<AucunelementWidget> {
  late AucunelementModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AucunelementModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Text(
      'Aucun élément',
      style: FlutterFlowTheme.of(context).bodyMedium,
    );
  }
}
