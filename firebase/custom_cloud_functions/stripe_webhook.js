const functions = require("firebase-functions");
const admin = require("firebase-admin");

const stripe = require("stripe")(
  "sk_test_51JQyT3CmEcxfXHvzOl4lfImZTqXR4WI8giP49pDxcFYVVNIc1UF8kSOKpF1pBHvwpxM8WnVskgwjjkTe7xmz0Wt900sNeq0Bqn",
);

exports.stripeWebhook = functions
  .region("europe-west1")
  .runWith({
    memory: "512MB",
  })
  .https.onRequest(async (req, res) => {
    try {
      const sig = req.headers["stripe-signature"];
      const endpointSecret = "whsec_vYhHGdeIdnMtixIPn6H0UIr16GuKnfVu";
      const event = stripe.webhooks.constructEvent(
        req.rawBody,
        sig,
        endpointSecret,
      );

      const dataObject = event.data.object;

      if (event.type === "checkout.session.completed") {
        const paymentIntentId = dataObject.payment_intent;

        // Trouver la commande correspondant au PaymentIntent
        const ordersRef = admin.firestore().collection("Commandes");
        const snapshot = await ordersRef
          .where("stripe_session_id", "==", paymentIntentId)
          .get();

        if (snapshot.empty) {
          console.log(
            "Aucune commande trouvée avec le PaymentIntentId:",
            paymentIntentId,
          );
          return res.status(404).send("Commande non trouvée");
        }

        const orderDoc = snapshot.docs[0];
        const orderId = orderDoc.id;

        await ordersRef.doc(orderId).update({
          status_number: 2, // Paiement réussi
        });

        // Vous pouvez également enregistrer les détails du paiement si nécessaire
        await admin.firestore().collection("payments").doc().set({
          checkoutSessionId: dataObject.id,
          paymentStatus: dataObject.payment_status,
          amountTotal: dataObject.amount_total,
          amountCurrency: dataObject.currency,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });
      } else if (event.type === "payment_intent.payment_failed") {
        // Mettre à jour le statut de la commande pour un paiement échoué
        // Ajouter une logique similaire à celle ci-dessus pour trouver et mettre à jour la commande
        const paymentIntentId = dataObject.payment_intent;

        // Trouver la commande correspondant au PaymentIntent
        const ordersRef = admin.firestore().collection("Commandes");
        const snapshot = await ordersRef
          .where("stripe_session_id", "==", paymentIntentId)
          .get();

        if (snapshot.empty) {
          console.log(
            "Aucune commande trouvée avec le PaymentIntentId:",
            paymentIntentId,
          );
          return res.status(404).send("Commande non trouvée");
        }

        const orderDoc = snapshot.docs[0];
        const orderId = orderDoc.id;

        await ordersRef.doc(orderId).update({
          status_number: 0, // Paiement échoué
        });
      }

      return res.status(200).send();
    } catch (err) {
      console.error("Error handling Stripe webhook", err);
      return res.status(400).send(`Webhook Error: ${err.message}`);
    }
  });
