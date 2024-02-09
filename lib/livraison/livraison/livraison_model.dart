import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'livraison_widget.dart' show LivraisonWidget;
import 'package:flutter/material.dart';

class LivraisonModel extends FlutterFlowModel<LivraisonWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Model for UserCard component.
  late UserCardModel userCardModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    userCardModel = createModel(context, () => UserCardModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    userCardModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
