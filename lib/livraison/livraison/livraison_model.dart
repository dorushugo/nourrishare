import '/components_general/user_card/user_card_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'livraison_widget.dart' show LivraisonWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LivraisonModel extends FlutterFlowModel<LivraisonWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Model for UserCard component.
  late UserCardModel userCardModel1;
  // State field(s) for Carousel widget.
  CarouselController? carouselController1;

  int carouselCurrentIndex1 = 0;

  // State field(s) for Carousel widget.
  CarouselController? carouselController2;

  int carouselCurrentIndex2 = 0;

  // State field(s) for Carousel widget.
  CarouselController? carouselController3;

  int carouselCurrentIndex3 = 0;

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Model for UserCard component.
  late UserCardModel userCardModel2;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    userCardModel1 = createModel(context, () => UserCardModel());
    userCardModel2 = createModel(context, () => UserCardModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    userCardModel1.dispose();
    userCardModel2.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
