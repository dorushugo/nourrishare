
class StripeWebhookCloudFunctionCallResponse {
  StripeWebhookCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}

class RemovePlatReferencesCloudFunctionCallResponse {
  RemovePlatReferencesCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}

class RemoveUserReferencesCloudFunctionCallResponse {
  RemoveUserReferencesCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
