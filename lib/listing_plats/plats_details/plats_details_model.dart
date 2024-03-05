import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'plats_details_widget.dart' show PlatsDetailsWidget;
import 'package:flutter/material.dart';

class PlatsDetailsModel extends FlutterFlowModel<PlatsDetailsWidget> {
  ///  Local state fields for this page.

  bool favoris = false;

  bool selecteur = false;

  int commanderState = 1;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for UserCard component.
  late UserCardModel userCardModel;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for momentLivraison widget.
  String? momentLivraisonValue;
  FormFieldController<String>? momentLivraisonValueController;
  // Stores action output result for [Custom Action - prixStripe] action in Button widget.
  int? prixStripeValue;
  // Stores action output result for [Custom Action - calculateComission] action in Button widget.
  int? comission;
  // Stores action output result for [Custom Action - calculateTotal] action in Button widget.
  int? prixTotalResult;
  // Stores action output result for [Backend Call - API (Sessions)] action in Button widget.
  ApiCallResponse? sessionCree;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CommandesRecord? commandeCree;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    userCardModel = createModel(context, () => UserCardModel());
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    userCardModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
