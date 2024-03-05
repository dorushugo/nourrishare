const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.removeUserReferences = functions.firestore
  .document("Users/{userId}")
  .onDelete(async (snap, context) => {
    const userId = context.params.userId;
    const userRef = admin.firestore().doc(`Users/${userId}`);

    // Fonction pour mettre à jour les documents dans une collection spécifique
    const updateDocuments = async (collectionPath, field, isList = false) => {
      const collectionRef = admin.firestore().collection(collectionPath);
      let querySnapshot;
      if (isList) {
        // Pour les champs de type List Reference
        querySnapshot = await collectionRef
          .where(field, "array-contains", userRef)
          .get();
      } else {
        // Pour les champs de type Reference
        querySnapshot = await collectionRef.where(field, "==", userRef).get();
      }

      const updates = querySnapshot.docs.map((doc) => {
        if (isList) {
          // Retirer la référence de l'utilisateur du champ de type List Reference
          return doc.ref.update({
            [field]: admin.firestore.FieldValue.arrayRemove(userRef),
          });
        } else {
          // Mettre à jour ou supprimer le champ de type Reference selon les besoins
          // Par exemple, mettre à null le champ de référence
          return doc.ref.update({
            [field]: null,
          });
        }
      });

      return Promise.all(updates);
    };

    // Mise à jour des collections spécifiques avec la méthode appropriée
    await updateDocuments("Plats", "Seller");
    await updateDocuments("Plats", "Buyer");
    await updateDocuments("Groupes", "Users", true);
    await updateDocuments("Groupes", "Administrateurs", true);
    await updateDocuments("Commandes", "vendor_ref");
    await updateDocuments("Commandes", "buyer");
  });
