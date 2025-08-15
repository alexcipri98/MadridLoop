const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

/**
 * Función HTTP para validar la versión mínima requerida de la app.
 */
exports.checkAppVersion = functions.https.onRequest(async (req, res) => {
  try {
    const clientVersion = req.query.version || req.body.version;

    const docRef = admin.firestore().collection("appConfig").doc("version");
    const doc = await docRef.get();

    if (!doc.exists) {
      res.status(500).json({error: "Version info not found"});
      return;
    }

    const minimumVersion = doc.data().minimumVersion;

    const url = doc.data().url;

    const updateRequired =
      clientVersion && compareVersions(clientVersion, minimumVersion) < 0;

    res.json({
      minimumVersion: minimumVersion,
      url: url,
      updateRequired: updateRequired ?? true,
    });
  } catch (error) {
    res.status(500).json({error: error.message});
  }
});

/**
 * Compara dos versiones semánticas.
 * @param {string} v1 - Versión 1.
 * @param {string} v2 - Versión 2.
 * @return {number} 1 si v1 > v2, -1 si v1 < v2, 0 si iguales.
 */
function compareVersions(v1, v2) {
  const v1parts = v1.split(".").map(Number);
  const v2parts = v2.split(".").map(Number);
  for (let i = 0; i < Math.max(v1parts.length, v2parts.length); i++) {
    const num1 = v1parts[i] || 0;
    const num2 = v2parts[i] || 0;
    if (num1 > num2) return 1;
    if (num1 < num2) return -1;
  }
  return 0;
}
