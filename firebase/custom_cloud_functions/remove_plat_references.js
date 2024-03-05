const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.removePlatReferences = functions.firestore
  .document("Plats/{platId}")
  .onDelete(async (snap, context) => {
    const platId = context.params.platId;

    // Fonction pour mettre à jour les documents dans une collection spécifique
    const updateDocuments = async (collectionPath) => {
      const collectionRef = admin.firestore().collection(collectionPath);
      const querySnapshot = await collectionRef
        .where("plats", "array-contains", platId)
        .get();

      const updates = querySnapshot.docs.map((doc) => {
        // Retirer l'ID du plat du tableau 'plats'
        return doc.ref.update({
          plats: admin.firestore.FieldValue.arrayRemove(platId),
        });
      });

      return Promise.all(updates);
    };

    // Mise à jour des collections Users et Commandes
    return Promise.all([
      updateDocuments("Users"),
      updateDocuments("Commandes"),
    ]).catch((error) => {
      console.error("Error removing plat references:", error);
    });
  });
