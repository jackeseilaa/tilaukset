#!/bin/bash
set -e
echo "🚀 J Sailing — Firebase Functions asennus"
echo ""

# Fix npm permissions & use npx (no sudo needed)
FB="npx -y firebase-tools"

# Login
echo "🔑 Kirjautuminen Firebaseen..."
$FB login

# Install function dependencies
echo "📦 Asennetaan npm-paketit..."
cd functions && npm install && cd ..

# Set secrets
echo ""
read -p "Gmail [jacke.seilaa@gmail.com]: " GMAIL
GMAIL=${GMAIL:-jacke.seilaa@gmail.com}
echo "$GMAIL" | $FB functions:secrets:set GMAIL_USER

echo ""
echo "🔐 Luo Gmail App Password:"
echo "   myaccount.google.com/security → 2-Step → App passwords → Create"
echo ""
read -s -p "App Password (16 merkkiä): " APPPASS
echo ""
echo "$APPPASS" | $FB functions:secrets:set GMAIL_PASS

# Deploy
echo ""
echo "🚀 Deployataan..."
$FB deploy --only functions --project jsailing-f716c

echo ""
echo "✅ VALMIS! Lähetä sähköpostilla -nappi toimii nyt PDF-liitteellä."
