import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components_general/item_commandes/item_commandes_widget.dart';
import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'livraison_widget.dart' show LivraisonWidget;
import 'package:map_launcher/map_launcher.dart' as $ml;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

class LivraisonModel extends FlutterFlowModel<LivraisonWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Model for UserCard component.
  late UserCardModel userCardModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    userCardModel = createModel(context, () => UserCardModel());
  }

  void dispose() {
    unfocusNode.dispose();
    userCardModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
