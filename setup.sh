#!/bin/bash
set -e
echo "🚀 J Sailing — Firebase Functions asennus"
echo ""

# Install Firebase CLI if needed
if ! command -v firebase &> /dev/null; then
  echo "📦 Asennetaan Firebase CLI..."
  npm install -g firebase-tools
fi

# Login
echo "🔑 Kirjautuminen Firebaseen (avaa selain)..."
firebase login --no-localhost 2>/dev/null || firebase login

# Install function dependencies
echo "📦 Asennetaan npm-paketit..."
cd functions && npm install && cd ..

# Set secrets
echo ""
echo "📧 Gmail-tunnus: jacke.seilaa@gmail.com"
echo "   (Paina Enter vahvistaaksesi tai kirjoita toinen)"
read -p "Gmail: " GMAIL
GMAIL=${GMAIL:-jacke.seilaa@gmail.com}
echo "$GMAIL" | firebase functions:secrets:set GMAIL_USER

echo ""
echo "🔐 Luo Gmail App Password:"
echo "   1. Mene: myaccount.google.com/security"
echo "   2. 2-vaiheinen todennus → App passwords"
echo "   3. Luo uusi → kopioi 16-merkkinen salasana"
echo ""
read -s -p "App Password: " APPPASS
echo ""
echo "$APPPASS" | firebase functions:secrets:set GMAIL_PASS

# Deploy
echo ""
echo "🚀 Deployataan..."
firebase deploy --only functions

echo ""
echo "✅ VALMIS! Lähetä sähköpostilla -nappi toimii nyt PDF-liitteellä."
