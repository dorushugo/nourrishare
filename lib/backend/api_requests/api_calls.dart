import 'dart:convert';
import '../cloud_functions/cloud_functions.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Stripe Group Code

class StripeGroup {
  static AccountsCall accountsCall = AccountsCall();
  static CreateAccountLinkCall createAccountLinkCall = CreateAccountLinkCall();
  static RetrieveAccountInformationCall retrieveAccountInformationCall =
      RetrieveAccountInformationCall();
  static IntentPaymentCall intentPaymentCall = IntentPaymentCall();
  static CreateCustomerCall createCustomerCall = CreateCustomerCall();
  static CreateEphemeralKeysCall createEphemeralKeysCall =
      CreateEphemeralKeysCall();
  static GetIntentedPaymentCall getIntentedPaymentCall =
      GetIntentedPaymentCall();
  static SessionsCall sessionsCall = SessionsCall();
}

class AccountsCall {
  Future<ApiCallResponse> call({
    String? businessType = '',
    String? country = '',
    String? email = '',
    String? type = '',
    String? firstName = '',
    String? lastName = '',
    String? phone = '',
    String? productDescription = '',
    String? currency = '',
    int? individualDobDay,
    int? individualDobMonth,
    int? individualDobYear,
    String? city = '',
    String? adressLine1 = '',
    String? postalCode = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'AccountsCall',
        'variables': {
          'businessType': businessType,
          'country': country,
          'email': email,
          'type': type,
          'firstName': firstName,
          'lastName': lastName,
          'phone': phone,
          'productDescription': productDescription,
          'currency': currency,
          'individualDobDay': individualDobDay,
          'individualDobMonth': individualDobMonth,
          'individualDobYear': individualDobYear,
          'city': city,
          'adressLine1': adressLine1,
          'postalCode': postalCode,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class CreateAccountLinkCall {
  Future<ApiCallResponse> call({
    String? account = '',
    String? type = '',
    String? refreshUrl = '',
    String? returnUrl = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateAccountLinkCall',
        'variables': {
          'account': account,
          'type': type,
          'refreshUrl': refreshUrl,
          'returnUrl': returnUrl,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
}

class RetrieveAccountInformationCall {
  Future<ApiCallResponse> call({
    String? accountID = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieveAccountInformationCall',
        'variables': {
          'accountID': accountID,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  bool? accountOnboardingFinish(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.charges_enabled''',
      ));
}

class IntentPaymentCall {
  Future<ApiCallResponse> call({
    String? connectedAccount = '',
    String? currency = '',
    int? amount,
    int? comission,
    String? customer = '',
    String? receiptEmail = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'IntentPaymentCall',
        'variables': {
          'connectedAccount': connectedAccount,
          'currency': currency,
          'amount': amount,
          'comission': comission,
          'customer': customer,
          'receiptEmail': receiptEmail,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? clientSecret(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.client_secret''',
      ));
  String? customerPayment(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.customer''',
      ));
}

class CreateCustomerCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? addressCity = '',
    String? addressLine1 = '',
    String? addressPostalCode = '',
    String? connectedAccount = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateCustomerCall',
        'variables': {
          'email': email,
          'addressCity': addressCity,
          'addressLine1': addressLine1,
          'addressPostalCode': addressPostalCode,
          'connectedAccount': connectedAccount,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? customerId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class CreateEphemeralKeysCall {
  Future<ApiCallResponse> call({
    String? customerID = '',
    String? connectedAccount = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateEphemeralKeysCall',
        'variables': {
          'customerID': customerID,
          'connectedAccount': connectedAccount,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? ephID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? secretKey(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.secret''',
      ));
}

class GetIntentedPaymentCall {
  Future<ApiCallResponse> call({
    String? piId = '',
    String? clientSecret = '',
    String? connectedAccount = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetIntentedPaymentCall',
        'variables': {
          'piId': piId,
          'clientSecret': clientSecret,
          'connectedAccount': connectedAccount,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class SessionsCall {
  Future<ApiCallResponse> call({
    String? connectedAccount = '',
    String? cancelurl = '',
    String? successurl = '',
    String? currency = '',
    String? productName = '',
    int? unitAmout,
    int? quantity,
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'SessionsCall',
        'variables': {
          'connectedAccount': connectedAccount,
          'cancelurl': cancelurl,
          'successurl': successurl,
          'currency': currency,
          'productName': productName,
          'unitAmout': unitAmout,
          'quantity': quantity,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? cancelUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.cancel_url''',
      ));
  String? paymentIntendID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.payment_intent''',
      ));
  String? successUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.success_url''',
      ));
  String? paymentUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
  String? idSessions(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

/// End Stripe Group Code

/// Start OpenAI API Group Code

class OpenAIAPIGroup {
  static CreateChatCompletionTextCall createChatCompletionTextCall =
      CreateChatCompletionTextCall();
  static CreateChatCompletionImageCall createChatCompletionImageCall =
      CreateChatCompletionImageCall();
  static CreateCompletionCall createCompletionCall = CreateCompletionCall();
  static CreateImageCall createImageCall = CreateImageCall();
  static CreateImageEditCall createImageEditCall = CreateImageEditCall();
  static CreateImageVariationCall createImageVariationCall =
      CreateImageVariationCall();
  static CreateEmbeddingCall createEmbeddingCall = CreateEmbeddingCall();
  static CreateSpeechCall createSpeechCall = CreateSpeechCall();
  static CreateTranscriptionCall createTranscriptionCall =
      CreateTranscriptionCall();
  static CreateTranslationCall createTranslationCall = CreateTranslationCall();
  static ListFilesCall listFilesCall = ListFilesCall();
  static CreateFileCall createFileCall = CreateFileCall();
  static DeleteFileCall deleteFileCall = DeleteFileCall();
  static RetrieveFileCall retrieveFileCall = RetrieveFileCall();
  static DownloadFileCall downloadFileCall = DownloadFileCall();
  static CreateFineTuningJobCall createFineTuningJobCall =
      CreateFineTuningJobCall();
  static ListPaginatedFineTuningJobsCall listPaginatedFineTuningJobsCall =
      ListPaginatedFineTuningJobsCall();
  static RetrieveFineTuningJobCall retrieveFineTuningJobCall =
      RetrieveFineTuningJobCall();
  static ListFineTuningEventsCall listFineTuningEventsCall =
      ListFineTuningEventsCall();
  static CancelFineTuningJobCall cancelFineTuningJobCall =
      CancelFineTuningJobCall();
  static ListModelsCall listModelsCall = ListModelsCall();
  static RetrieveModelCall retrieveModelCall = RetrieveModelCall();
  static DeleteModelCall deleteModelCall = DeleteModelCall();
  static CreateModerationCall createModerationCall = CreateModerationCall();
  static ListAssistantsCall listAssistantsCall = ListAssistantsCall();
  static CreateAssistantCall createAssistantCall = CreateAssistantCall();
  static GetAssistantCall getAssistantCall = GetAssistantCall();
  static ModifyAssistantCall modifyAssistantCall = ModifyAssistantCall();
  static DeleteAssistantCall deleteAssistantCall = DeleteAssistantCall();
  static CreateThreadCall createThreadCall = CreateThreadCall();
  static GetThreadCall getThreadCall = GetThreadCall();
  static ModifyThreadCall modifyThreadCall = ModifyThreadCall();
  static DeleteThreadCall deleteThreadCall = DeleteThreadCall();
  static ListMessagesCall listMessagesCall = ListMessagesCall();
  static CreateMessageCall createMessageCall = CreateMessageCall();
  static GetMessageCall getMessageCall = GetMessageCall();
  static ModifyMessageCall modifyMessageCall = ModifyMessageCall();
  static CreateThreadAndRunCall createThreadAndRunCall =
      CreateThreadAndRunCall();
  static ListRunsCall listRunsCall = ListRunsCall();
  static CreateRunCall createRunCall = CreateRunCall();
  static GetRunCall getRunCall = GetRunCall();
  static ModifyRunCall modifyRunCall = ModifyRunCall();
  static SubmitToolOuputsToRunCall submitToolOuputsToRunCall =
      SubmitToolOuputsToRunCall();
  static CancelRunCall cancelRunCall = CancelRunCall();
  static ListRunStepsCall listRunStepsCall = ListRunStepsCall();
  static GetRunStepCall getRunStepCall = GetRunStepCall();
  static ListAssistantFilesCall listAssistantFilesCall =
      ListAssistantFilesCall();
  static CreateAssistantFileCall createAssistantFileCall =
      CreateAssistantFileCall();
  static GetAssistantFileCall getAssistantFileCall = GetAssistantFileCall();
  static DeleteAssistantFileCall deleteAssistantFileCall =
      DeleteAssistantFileCall();
  static ListMessageFilesCall listMessageFilesCall = ListMessageFilesCall();
  static GetMessageFileCall getMessageFileCall = GetMessageFileCall();
}

class CreateChatCompletionTextCall {
  Future<ApiCallResponse> call({
    String? descriptionPlat = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateChatCompletionTextCall',
        'variables': {
          'descriptionPlat': descriptionPlat,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic messageJson(dynamic response) => getJsonField(
        response,
        r'''$.choices[:].message.content''',
      );
}

class CreateChatCompletionImageCall {
  Future<ApiCallResponse> call({
    String? imageUrl = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateChatCompletionImageCall',
        'variables': {
          'imageUrl': imageUrl,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? descriptionPlat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.choices[:].message.content''',
      ));
}

class CreateCompletionCall {
  Future<ApiCallResponse> call({
    String? image = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateCompletionCall',
        'variables': {
          'image': image,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateImageCall {
  Future<ApiCallResponse> call() async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateImageCall',
        'variables': {},
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateImageEditCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateImageEditCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateImageVariationCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateImageVariationCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateEmbeddingCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateEmbeddingCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateSpeechCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateSpeechCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateTranscriptionCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateTranscriptionCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateTranslationCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateTranslationCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListFilesCall {
  Future<ApiCallResponse> call({
    String? purpose = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListFilesCall',
        'variables': {
          'purpose': purpose,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateFileCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateFileCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DeleteFileCall {
  Future<ApiCallResponse> call({
    String? fileId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DeleteFileCall',
        'variables': {
          'fileId': fileId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class RetrieveFileCall {
  Future<ApiCallResponse> call({
    String? fileId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieveFileCall',
        'variables': {
          'fileId': fileId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DownloadFileCall {
  Future<ApiCallResponse> call({
    String? fileId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DownloadFileCall',
        'variables': {
          'fileId': fileId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateFineTuningJobCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateFineTuningJobCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListPaginatedFineTuningJobsCall {
  Future<ApiCallResponse> call({
    String? after = '',
    int? limit,
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListPaginatedFineTuningJobsCall',
        'variables': {
          'after': after,
          'limit': limit,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class RetrieveFineTuningJobCall {
  Future<ApiCallResponse> call({
    String? fineTuningJobId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieveFineTuningJobCall',
        'variables': {
          'fineTuningJobId': fineTuningJobId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListFineTuningEventsCall {
  Future<ApiCallResponse> call({
    String? fineTuningJobId = '',
    String? after = '',
    int? limit,
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListFineTuningEventsCall',
        'variables': {
          'fineTuningJobId': fineTuningJobId,
          'after': after,
          'limit': limit,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CancelFineTuningJobCall {
  Future<ApiCallResponse> call({
    String? fineTuningJobId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CancelFineTuningJobCall',
        'variables': {
          'fineTuningJobId': fineTuningJobId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListModelsCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListModelsCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class RetrieveModelCall {
  Future<ApiCallResponse> call({
    String? model = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieveModelCall',
        'variables': {
          'model': model,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DeleteModelCall {
  Future<ApiCallResponse> call({
    String? model = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DeleteModelCall',
        'variables': {
          'model': model,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateModerationCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateModerationCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListAssistantsCall {
  Future<ApiCallResponse> call({
    int? limit,
    String? order = '',
    String? after = '',
    String? before = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListAssistantsCall',
        'variables': {
          'limit': limit,
          'order': order,
          'after': after,
          'before': before,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateAssistantCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateAssistantCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetAssistantCall {
  Future<ApiCallResponse> call({
    String? assistantId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetAssistantCall',
        'variables': {
          'assistantId': assistantId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ModifyAssistantCall {
  Future<ApiCallResponse> call({
    String? assistantId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ModifyAssistantCall',
        'variables': {
          'assistantId': assistantId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DeleteAssistantCall {
  Future<ApiCallResponse> call({
    String? assistantId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DeleteAssistantCall',
        'variables': {
          'assistantId': assistantId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateThreadCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateThreadCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetThreadCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetThreadCall',
        'variables': {
          'threadId': threadId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ModifyThreadCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ModifyThreadCall',
        'variables': {
          'threadId': threadId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DeleteThreadCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DeleteThreadCall',
        'variables': {
          'threadId': threadId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListMessagesCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    int? limit,
    String? order = '',
    String? after = '',
    String? before = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListMessagesCall',
        'variables': {
          'threadId': threadId,
          'limit': limit,
          'order': order,
          'after': after,
          'before': before,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateMessageCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateMessageCall',
        'variables': {
          'threadId': threadId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetMessageCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? messageId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetMessageCall',
        'variables': {
          'threadId': threadId,
          'messageId': messageId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ModifyMessageCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? messageId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ModifyMessageCall',
        'variables': {
          'threadId': threadId,
          'messageId': messageId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateThreadAndRunCall {
  Future<ApiCallResponse> call({
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateThreadAndRunCall',
        'variables': {
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListRunsCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    int? limit,
    String? order = '',
    String? after = '',
    String? before = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListRunsCall',
        'variables': {
          'threadId': threadId,
          'limit': limit,
          'order': order,
          'after': after,
          'before': before,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateRunCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateRunCall',
        'variables': {
          'threadId': threadId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetRunCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? runId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetRunCall',
        'variables': {
          'threadId': threadId,
          'runId': runId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ModifyRunCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? runId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ModifyRunCall',
        'variables': {
          'threadId': threadId,
          'runId': runId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class SubmitToolOuputsToRunCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? runId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'SubmitToolOuputsToRunCall',
        'variables': {
          'threadId': threadId,
          'runId': runId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CancelRunCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? runId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CancelRunCall',
        'variables': {
          'threadId': threadId,
          'runId': runId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListRunStepsCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? runId = '',
    int? limit,
    String? order = '',
    String? after = '',
    String? before = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListRunStepsCall',
        'variables': {
          'threadId': threadId,
          'runId': runId,
          'limit': limit,
          'order': order,
          'after': after,
          'before': before,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetRunStepCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? runId = '',
    String? stepId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetRunStepCall',
        'variables': {
          'threadId': threadId,
          'runId': runId,
          'stepId': stepId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListAssistantFilesCall {
  Future<ApiCallResponse> call({
    String? assistantId = '',
    int? limit,
    String? order = '',
    String? after = '',
    String? before = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListAssistantFilesCall',
        'variables': {
          'assistantId': assistantId,
          'limit': limit,
          'order': order,
          'after': after,
          'before': before,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CreateAssistantFileCall {
  Future<ApiCallResponse> call({
    String? assistantId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateAssistantFileCall',
        'variables': {
          'assistantId': assistantId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetAssistantFileCall {
  Future<ApiCallResponse> call({
    String? assistantId = '',
    String? fileId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetAssistantFileCall',
        'variables': {
          'assistantId': assistantId,
          'fileId': fileId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class DeleteAssistantFileCall {
  Future<ApiCallResponse> call({
    String? assistantId = '',
    String? fileId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'DeleteAssistantFileCall',
        'variables': {
          'assistantId': assistantId,
          'fileId': fileId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ListMessageFilesCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? messageId = '',
    int? limit,
    String? order = '',
    String? after = '',
    String? before = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ListMessageFilesCall',
        'variables': {
          'threadId': threadId,
          'messageId': messageId,
          'limit': limit,
          'order': order,
          'after': after,
          'before': before,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class GetMessageFileCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
    String? messageId = '',
    String? fileId = '',
    String? apiKeyAuth = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'GetMessageFileCall',
        'variables': {
          'threadId': threadId,
          'messageId': messageId,
          'fileId': fileId,
          'apiKeyAuth': apiKeyAuth,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

/// End OpenAI API Group Code

/// Start Google Maps Group Code

class GoogleMapsGroup {
  static String baseUrl = 'https://maps.googleapis.com/maps/api/';
  static Map<String, String> headers = {};
  static AutocompleteAdressCall autocompleteAdressCall =
      AutocompleteAdressCall();
  static SearchCityAndPostalCodeCall searchCityAndPostalCodeCall =
      SearchCityAndPostalCodeCall();
}

class AutocompleteAdressCall {
  Future<ApiCallResponse> call({
    String? input = '',
    String? components = 'country:FR',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Autocomplete Adress',
      apiUrl: '${GoogleMapsGroup.baseUrl}place/autocomplete/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'key': "AIzaSyC9lduemygUWHmGX2Dr9qC2LoveDM_xxX8",
        'input': input,
        'components': components,
        'types': "address",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? proposistions(dynamic response) => (getJsonField(
        response,
        r'''$.predictions[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SearchCityAndPostalCodeCall {
  Future<ApiCallResponse> call({
    String? address = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'SearchCityAndPostalCode',
      apiUrl: '${GoogleMapsGroup.baseUrl}geocode/json',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'key': "AIzaSyC9lduemygUWHmGX2Dr9qC2LoveDM_xxX8",
        'address': address,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  dynamic location(dynamic response) => getJsonField(
        response,
        r'''$.results[:].geometry.location''',
      );
  String? ville(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[0].address_components[2].long_name''',
      ));
  String? codePostal(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[0].address_components[6].long_name''',
      ));
  double? lat(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.results[:].geometry.location.lat''',
      ));
  double? lng(dynamic response) => castToType<double>(getJsonField(
        response,
        r'''$.results[:].geometry.location.lng''',
      ));
}

/// End Google Maps Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
