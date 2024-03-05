const axios = require("axios").default;
const qs = require("qs");

/// Start Stripe Group Code

const stripeGroup = {
  baseUrl: "https://api.stripe.com/v1",
  headers: {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
  },
};

async function _accountsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var businessType = ffVariables["businessType"];
  var country = ffVariables["country"];
  var email = ffVariables["email"];
  var type = ffVariables["type"];
  var firstName = ffVariables["firstName"];
  var lastName = ffVariables["lastName"];
  var phone = ffVariables["phone"];
  var productDescription = ffVariables["productDescription"];
  var currency = ffVariables["currency"];
  var individualDobDay = ffVariables["individualDobDay"];
  var individualDobMonth = ffVariables["individualDobMonth"];
  var individualDobYear = ffVariables["individualDobYear"];
  var city = ffVariables["city"];
  var adressLine1 = ffVariables["adressLine1"];
  var postalCode = ffVariables["postalCode"];

  var url = `${stripeGroup.baseUrl}/accounts`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
  };
  var params = {
    business_type: businessType,
    type: `express`,
    country: country,
    email: email,
    "individual[dob][day]": individualDobDay,
    "individual[email]": email,
    "individual[first_name]": firstName,
    "individual[last_name]": lastName,
    "business_profile[product_description]": productDescription,
    default_currency: currency,
    "individual[dob][month]": individualDobMonth,
    "individual[dob][year]": individualDobYear,
    "individual[registered_address][city]": city,
    "individual[registered_address][country]": country,
    "individual[registered_address][line1]": adressLine1,
    "individual[registered_address][postal_code]": postalCode,
    "individual[address][city]": city,
    "individual[address][country]": country,
    "individual[address][line1]": adressLine1,
    "individual[address][postal_code]": postalCode,
    "business_profile[mcc]": 5499,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
  });
}

async function _createAccountLinkCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var account = ffVariables["account"];
  var type = ffVariables["type"];
  var refreshUrl = ffVariables["refreshUrl"];
  var returnUrl = ffVariables["returnUrl"];

  var url = `${stripeGroup.baseUrl}/account_links`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
  };
  var params = {
    account: account,
    type: type,
    refresh_url: refreshUrl,
    return_url: returnUrl,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
  });
}

async function _retrieveAccountInformationCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var accountID = ffVariables["accountID"];

  var url = `${stripeGroup.baseUrl}/accounts/${accountID}`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _intentPaymentCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var connectedAccount = ffVariables["connectedAccount"];
  var currency = ffVariables["currency"];
  var amount = ffVariables["amount"];
  var comission = ffVariables["comission"];
  var customer = ffVariables["customer"];
  var receiptEmail = ffVariables["receiptEmail"];

  var url = `${stripeGroup.baseUrl}/payment_intents`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
    "Stripe-Account": `${connectedAccount}`,
  };
  var params = {
    currency: currency,
    amount: amount,
    application_fee_amount: comission,
    customer: customer,
    "automatic_payment_methods[enabled]": true,
    receipt_email: receiptEmail,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
  });
}

async function _createCustomerCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var email = ffVariables["email"];
  var addressCity = ffVariables["addressCity"];
  var addressLine1 = ffVariables["addressLine1"];
  var addressPostalCode = ffVariables["addressPostalCode"];
  var connectedAccount = ffVariables["connectedAccount"];

  var url = `${stripeGroup.baseUrl}/customers`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
    "Stripe-Account": `${connectedAccount}`,
  };
  var params = {
    "address[city]": addressCity,
    email: email,
    "address[line1]": addressLine1,
    "address[postal_code]": addressPostalCode,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
  });
}

async function _createEphemeralKeysCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var customerID = ffVariables["customerID"];
  var connectedAccount = ffVariables["connectedAccount"];

  var url = `${stripeGroup.baseUrl}/ephemeral_keys`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
    "Stripe-Account": `${connectedAccount}`,
  };
  var params = { customer: customerID };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
  });
}

async function _getIntentedPaymentCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var piId = ffVariables["piId"];
  var clientSecret = ffVariables["clientSecret"];
  var connectedAccount = ffVariables["connectedAccount"];

  var url = `${stripeGroup.baseUrl}/payment_intents/${piId}`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
    "Stripe-Account": `${connectedAccount}`,
  };
  var params = { client_secret: clientSecret };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _sessionsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var connectedAccount = ffVariables["connectedAccount"];
  var cancelurl = ffVariables["cancelurl"];
  var successurl = ffVariables["successurl"];
  var currency = ffVariables["currency"];
  var productName = ffVariables["productName"];
  var unitAmout = ffVariables["unitAmout"];
  var quantity = ffVariables["quantity"];
  var fee = ffVariables["fee"];

  var url = `${stripeGroup.baseUrl}/checkout/sessions`;
  var headers = {
    "Content-Type": `application/x-www-form-urlencoded`,
    "Stripe-Version": `2020-03-02`,
    Authorization: `Bearer sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn`,
    "Stripe-Account": `${connectedAccount}`,
  };
  var params = {
    cancel_url: cancelurl,
    success_url: successurl,
    "line_items[0][price_data][currency]": currency,
    "line_items[0][price_data][product_data][name]": productName,
    "line_items[0][price_data][unit_amount]": unitAmout,
    "line_items[0][quantity]": quantity,
    mode: `payment`,
    "payment_intent_data[application_fee_amount]": fee,
  };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "X_WWW_FORM_URL_ENCODED",
    }),
    returnBody: true,
  });
}

/// End Stripe Group Code

/// Start OpenAI API Group Code

const openAIAPIGroup = {
  baseUrl: "https://api.openai.com/v1",
  headers: {
    Authorization: `Bearer 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`,
  },
};

async function _createChatCompletionTextCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var descriptionPlat = ffVariables["descriptionPlat"];

  var url = `${openAIAPIGroup.baseUrl}/chat/completions`;
  var headers = {
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "gpt-3.5-turbo-0125",
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant. Please respond in JSON format."
    },
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "Reply in json object with key are Ingredients, Allergenes and Name. Utilise le format suivant: Ingrédients: 'Ingrédient 1, Ingrédient 2, Ingrédient 3'... Allergènes: 'Allergène 1, Allergène 2, Allergène 3'... Name: 'Name'. Le nom doit correspondre à la description qui t'es donné. Voici la description du plat en question : ${descriptionPlat}."
        }
      ]
    }
  ],
  "temperature": 0.2,
  "max_tokens": 500
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _jsonIngredientsCompletionTexteCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var listIngredients1 = ffVariables["listIngredients1"];
  var listIngredients2 = ffVariables["listIngredients2"];

  var url = `${openAIAPIGroup.baseUrl}/chat/completions`;
  var headers = {
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "gpt-3.5-turbo-0125",
  "response_format": {
    "type": "json_object"
  },
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant. Please respond in JSON format in french."
    },
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "Reply in json object with key are Ingredients. Utilise le format suivant: Ingrédients: 'Ingrédient 1, Ingrédient 2, Ingrédient 3'... Voici la liste de tout les ingrédients que tu dois mettre en format json  <descriptionPlat>."
        }
      ]
    }
  ],
  "temperature": 0,
  "max_tokens": 500
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createChatCompletionImageCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var imageUrl = ffVariables["imageUrl"];

  var url = `${openAIAPIGroup.baseUrl}/chat/completions`;
  var headers = {
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "gpt-4-vision-preview",
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant for NourriShare an app where user sell dish and ingredient to their neighboors and work colleague."
    },
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "Describe the dish with a list of it's Ingredients, Allergenes and propose a Name for the Dish. Utilise le format suivant. Si il n'y a pas d'allergènes, dit simplement 'Aucun allegènes détecté, assurez vous de bien renseigner les allergènes nécessaires.'"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "${imageUrl}"
          }
        }
      ]
    }
  ],
  "temperature": 0,
  "max_tokens": 3000
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createChatCompletionImageFridgeCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var imageUrl = ffVariables["imageUrl"];

  var url = `${openAIAPIGroup.baseUrl}/chat/completions`;
  var headers = {
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "gpt-4-vision-preview",
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant for NourriShare, your job is to make a list of every ingredient on the image."
    },
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "Make a list of every Ingredients in the picture. Answer in French and in Json format like that Ingredients: Ingredients 1, Ingredients 2, Ingredients 3, etc."
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "${imageUrl}"
          }
        }
      ]
    }
  ],
  "temperature": 0.2,
  "max_tokens": 3000
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createCompletionCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var image = ffVariables["image"];

  var url = `${openAIAPIGroup.baseUrl}/completions`;
  var headers = {
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "gpt-4-vision-preview",
  "messages": [
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "Liste les ingrédients et allergènes de ce plat. Réponds avec deux listes séparées, une pour les ingrédients et une pour les allergènes. Utilise le format suivant: 'Ingrédients: Ingrédient 1, Ingrédient 2, Ingrédient 3... Allergènes: Allergène 1, Allergène 2, Allergène 3...'"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": ""
            // Remplacez "URL_DE_VOTRE_IMAGE" par le lien vers votre image
          }
        }
      ]
    }
  ],
  "max_tokens": 300
}
`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createImageCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }

  var url = `${openAIAPIGroup.baseUrl}/images/generations`;
  var headers = {
    Authorization: `Bearer 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`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "prompt": "A cute baby sea otter",
  "model": "dall-e-3",
  "n": 1,
  "quality": "standard",
  "response_format": "url",
  "size": "1024x1024",
  "style": "vivid",
  "user": "user-1234"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createImageEditCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/images/edits`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createImageVariationCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/images/variations`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createEmbeddingCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/embeddings`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "input": "The quick brown fox jumped over the lazy dog",
  "model": "text-embedding-3-small",
  "encoding_format": "float",
  "dimensions": 0,
  "user": "user-1234"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createSpeechCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/audio/speech`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "",
  "input": "",
  "voice": "alloy",
  "response_format": "mp3",
  "speed": 0
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createTranscriptionCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/audio/transcriptions`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createTranslationCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/audio/translations`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _listFilesCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var purpose = ffVariables["purpose"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/files`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { purpose: purpose };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/files`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _deleteFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var fileId = ffVariables["fileId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/files/${fileId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "delete",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _retrieveFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var fileId = ffVariables["fileId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/files/${fileId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _downloadFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var fileId = ffVariables["fileId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/files/${fileId}/content`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createFineTuningJobCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/fine_tuning/jobs`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "gpt-3.5-turbo",
  "training_file": "file-abc123",
  "hyperparameters": {
    "batch_size": "",
    "learning_rate_multiplier": "",
    "n_epochs": ""
  },
  "suffix": "",
  "validation_file": "file-abc123"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _listPaginatedFineTuningJobsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var after = ffVariables["after"];
  var limit = ffVariables["limit"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/fine_tuning/jobs`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { after: after, limit: limit };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _retrieveFineTuningJobCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var fineTuningJobId = ffVariables["fineTuningJobId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/fine_tuning/jobs/${fineTuningJobId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _listFineTuningEventsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var fineTuningJobId = ffVariables["fineTuningJobId"];
  var after = ffVariables["after"];
  var limit = ffVariables["limit"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/fine_tuning/jobs/${fineTuningJobId}/events`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { after: after, limit: limit };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _cancelFineTuningJobCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var fineTuningJobId = ffVariables["fineTuningJobId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/fine_tuning/jobs/${fineTuningJobId}/cancel`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _listModelsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/models`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _retrieveModelCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var model = ffVariables["model"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/models/${model}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _deleteModelCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var model = ffVariables["model"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/models/${model}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "delete",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createModerationCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/moderations`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "input": "",
  "model": "text-moderation-stable"
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _listAssistantsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var limit = ffVariables["limit"];
  var order = ffVariables["order"];
  var after = ffVariables["after"];
  var before = ffVariables["before"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { limit: limit, order: order, after: after, before: before };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createAssistantCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "",
  "name": "",
  "description": "",
  "instructions": "",
  "tools": [
    ""
  ],
  "file_ids": [
    ""
  ],
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _getAssistantCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var assistantId = ffVariables["assistantId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants/${assistantId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _modifyAssistantCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var assistantId = ffVariables["assistantId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants/${assistantId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "model": "",
  "name": "",
  "description": "",
  "instructions": "",
  "tools": [
    ""
  ],
  "file_ids": [
    ""
  ],
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _deleteAssistantCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var assistantId = ffVariables["assistantId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants/${assistantId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "delete",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createThreadCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "messages": [
    {
      "role": "user",
      "content": "",
      "file_ids": [
        ""
      ],
      "metadata": {}
    }
  ],
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _getThreadCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _modifyThreadCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _deleteThreadCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "delete",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _listMessagesCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var limit = ffVariables["limit"];
  var order = ffVariables["order"];
  var after = ffVariables["after"];
  var before = ffVariables["before"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/messages`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { limit: limit, order: order, after: after, before: before };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createMessageCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/messages`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "role": "user",
  "content": "",
  "file_ids": [
    ""
  ],
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _getMessageCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var messageId = ffVariables["messageId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/messages/${messageId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _modifyMessageCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var messageId = ffVariables["messageId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/messages/${messageId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _createThreadAndRunCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/runs`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "assistant_id": "",
  "thread": {
    "messages": [
      {
        "role": "user",
        "content": "",
        "file_ids": [
          ""
        ],
        "metadata": {}
      }
    ],
    "metadata": {}
  },
  "model": "",
  "instructions": "",
  "tools": [
    ""
  ],
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _listRunsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var limit = ffVariables["limit"];
  var order = ffVariables["order"];
  var after = ffVariables["after"];
  var before = ffVariables["before"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { limit: limit, order: order, after: after, before: before };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createRunCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "assistant_id": "",
  "model": "",
  "instructions": "",
  "additional_instructions": "",
  "tools": [
    ""
  ],
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _getRunCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var runId = ffVariables["runId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs/${runId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _modifyRunCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var runId = ffVariables["runId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs/${runId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "metadata": {}
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _submitToolOuputsToRunCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var runId = ffVariables["runId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs/${runId}/submit_tool_outputs`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "tool_outputs": [
    {
      "tool_call_id": "",
      "output": ""
    }
  ]
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _cancelRunCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var runId = ffVariables["runId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs/${runId}/cancel`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _listRunStepsCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var runId = ffVariables["runId"];
  var limit = ffVariables["limit"];
  var order = ffVariables["order"];
  var after = ffVariables["after"];
  var before = ffVariables["before"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs/${runId}/steps`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { limit: limit, order: order, after: after, before: before };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _getRunStepCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var runId = ffVariables["runId"];
  var stepId = ffVariables["stepId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/runs/${runId}/steps/${stepId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _listAssistantFilesCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var assistantId = ffVariables["assistantId"];
  var limit = ffVariables["limit"];
  var order = ffVariables["order"];
  var after = ffVariables["after"];
  var before = ffVariables["before"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants/${assistantId}/files`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { limit: limit, order: order, after: after, before: before };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _createAssistantFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var assistantId = ffVariables["assistantId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants/${assistantId}/files`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = `
{
  "file_id": ""
}`;

  return makeApiRequest({
    method: "post",
    url,
    headers,
    params,
    body: createBody({
      headers,
      params,
      body: ffApiRequestBody,
      bodyType: "JSON",
    }),
    returnBody: true,
  });
}

async function _getAssistantFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var assistantId = ffVariables["assistantId"];
  var fileId = ffVariables["fileId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants/${assistantId}/files/${fileId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _deleteAssistantFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var assistantId = ffVariables["assistantId"];
  var fileId = ffVariables["fileId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/assistants/${assistantId}/files/${fileId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "delete",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _listMessageFilesCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var messageId = ffVariables["messageId"];
  var limit = ffVariables["limit"];
  var order = ffVariables["order"];
  var after = ffVariables["after"];
  var before = ffVariables["before"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/messages/${messageId}/files`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = { limit: limit, order: order, after: after, before: before };
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

async function _getMessageFileCall(context, ffVariables) {
  if (!context.auth) {
    return _unauthenticatedResponse;
  }
  var threadId = ffVariables["threadId"];
  var messageId = ffVariables["messageId"];
  var fileId = ffVariables["fileId"];
  var apiKeyAuth = ffVariables["apiKeyAuth"];

  var url = `${openAIAPIGroup.baseUrl}/threads/${threadId}/messages/${messageId}/files/${fileId}`;
  var headers = {
    Authorization: `Bearer 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`,
    Authorization: `Bearer ${apiKeyAuth}`,
  };
  var params = {};
  var ffApiRequestBody = undefined;

  return makeApiRequest({
    method: "get",
    url,
    headers,
    params,
    returnBody: true,
  });
}

/// End OpenAI API Group Code

/// Helper functions to route to the appropriate API Call.

async function makeApiCall(context, data) {
  var callName = data["callName"] || "";
  var variables = data["variables"] || {};

  const callMap = {
    AccountsCall: _accountsCall,
    CreateAccountLinkCall: _createAccountLinkCall,
    RetrieveAccountInformationCall: _retrieveAccountInformationCall,
    IntentPaymentCall: _intentPaymentCall,
    CreateCustomerCall: _createCustomerCall,
    CreateEphemeralKeysCall: _createEphemeralKeysCall,
    GetIntentedPaymentCall: _getIntentedPaymentCall,
    SessionsCall: _sessionsCall,
    CreateChatCompletionTextCall: _createChatCompletionTextCall,
    JsonIngredientsCompletionTexteCall: _jsonIngredientsCompletionTexteCall,
    CreateChatCompletionImageCall: _createChatCompletionImageCall,
    CreateChatCompletionImageFridgeCall: _createChatCompletionImageFridgeCall,
    CreateCompletionCall: _createCompletionCall,
    CreateImageCall: _createImageCall,
    CreateImageEditCall: _createImageEditCall,
    CreateImageVariationCall: _createImageVariationCall,
    CreateEmbeddingCall: _createEmbeddingCall,
    CreateSpeechCall: _createSpeechCall,
    CreateTranscriptionCall: _createTranscriptionCall,
    CreateTranslationCall: _createTranslationCall,
    ListFilesCall: _listFilesCall,
    CreateFileCall: _createFileCall,
    DeleteFileCall: _deleteFileCall,
    RetrieveFileCall: _retrieveFileCall,
    DownloadFileCall: _downloadFileCall,
    CreateFineTuningJobCall: _createFineTuningJobCall,
    ListPaginatedFineTuningJobsCall: _listPaginatedFineTuningJobsCall,
    RetrieveFineTuningJobCall: _retrieveFineTuningJobCall,
    ListFineTuningEventsCall: _listFineTuningEventsCall,
    CancelFineTuningJobCall: _cancelFineTuningJobCall,
    ListModelsCall: _listModelsCall,
    RetrieveModelCall: _retrieveModelCall,
    DeleteModelCall: _deleteModelCall,
    CreateModerationCall: _createModerationCall,
    ListAssistantsCall: _listAssistantsCall,
    CreateAssistantCall: _createAssistantCall,
    GetAssistantCall: _getAssistantCall,
    ModifyAssistantCall: _modifyAssistantCall,
    DeleteAssistantCall: _deleteAssistantCall,
    CreateThreadCall: _createThreadCall,
    GetThreadCall: _getThreadCall,
    ModifyThreadCall: _modifyThreadCall,
    DeleteThreadCall: _deleteThreadCall,
    ListMessagesCall: _listMessagesCall,
    CreateMessageCall: _createMessageCall,
    GetMessageCall: _getMessageCall,
    ModifyMessageCall: _modifyMessageCall,
    CreateThreadAndRunCall: _createThreadAndRunCall,
    ListRunsCall: _listRunsCall,
    CreateRunCall: _createRunCall,
    GetRunCall: _getRunCall,
    ModifyRunCall: _modifyRunCall,
    SubmitToolOuputsToRunCall: _submitToolOuputsToRunCall,
    CancelRunCall: _cancelRunCall,
    ListRunStepsCall: _listRunStepsCall,
    GetRunStepCall: _getRunStepCall,
    ListAssistantFilesCall: _listAssistantFilesCall,
    CreateAssistantFileCall: _createAssistantFileCall,
    GetAssistantFileCall: _getAssistantFileCall,
    DeleteAssistantFileCall: _deleteAssistantFileCall,
    ListMessageFilesCall: _listMessageFilesCall,
    GetMessageFileCall: _getMessageFileCall,
  };

  if (!(callName in callMap)) {
    return {
      statusCode: 400,
      error: `API Call "${callName}" not defined as private API.`,
    };
  }

  var apiCall = callMap[callName];
  var response = await apiCall(context, variables);
  return response;
}

async function makeApiRequest({
  method,
  url,
  headers,
  params,
  body,
  returnBody,
}) {
  return axios
    .request({
      method: method,
      url: url,
      headers: headers,
      params: params,
      ...(body && { data: body }),
    })
    .then((response) => {
      return {
        statusCode: response.status,
        headers: response.headers,
        ...(returnBody && { body: response.data }),
      };
    })
    .catch(function (error) {
      return {
        statusCode: error.response.status,
        headers: error.response.headers,
        ...(returnBody && { body: error.response.data }),
        error: error.message,
      };
    });
}

const _unauthenticatedResponse = {
  statusCode: 401,
  headers: {},
  error: "API call requires authentication",
};

function createBody({ headers, params, body, bodyType }) {
  switch (bodyType) {
    case "JSON":
      headers["Content-Type"] = "application/json";
      return body;
    case "TEXT":
      headers["Content-Type"] = "text/plain";
      return body;
    case "X_WWW_FORM_URL_ENCODED":
      headers["Content-Type"] = "application/x-www-form-urlencoded";
      return qs.stringify(params);
  }
}

module.exports = { makeApiCall };
