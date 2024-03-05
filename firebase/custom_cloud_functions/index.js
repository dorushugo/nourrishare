const admin = require("firebase-admin/app");
admin.initializeApp();

const stripeWebhook = require("./stripe_webhook.js");
exports.stripeWebhook = stripeWebhook.stripeWebhook;
const removePlatReferences = require("./remove_plat_references.js");
exports.removePlatReferences = removePlatReferences.removePlatReferences;
const removeUserReferences = require("./remove_user_references.js");
exports.removeUserReferences = removeUserReferences.removeUserReferences;
