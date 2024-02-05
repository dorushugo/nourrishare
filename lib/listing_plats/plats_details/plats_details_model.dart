import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'plats_details_widget.dart' show PlatsDetailsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PlatsDetailsModel extends FlutterFlowModel<PlatsDetailsWidget> {
  ///  Local state fields for this page.

  bool favoris = false;

  bool selecteur = false;

  int commanderState = 1;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for UserCard component.
  late UserCardModel userCardModel;
  // Stores action output result for [Custom Action - prixStripe] action in Button widget.
  int? prixStripeValueCopy;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CommandesRecord? commandeCreeCopy;
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
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  CommandesRecord? commandeCree;
  // Stores action output result for [Backend Call - API (Sessions)] action in Button widget.
  ApiCallResponse? sessionCree;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    userCardModel = createModel(context, () => UserCardModel());
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  void dispose() {
    unfocusNode.dispose();
    userCardModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
