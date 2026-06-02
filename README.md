# Chez Framboise 🌺

Site vitrine de **Chez Framboise**, chambre d'hôtes nichée dans le Cirque de
**Salazie** (La Réunion, microrégion est). Tenue par Françoise et Fred.
Note Booking.com **9,4/10** · +200 voyageurs accueillis · +5 ans d'activité.

🔗 **En ligne** : https://chezframboise.re
📅 **Réservation** : [Booking.com](https://www.booking.com/hotel/re/chez-framboise.fr.html)

---

## 🛠 Stack

Site **statique**, sans framework ni build :

- **HTML5 + CSS3 + JavaScript vanilla**
- Tout est dans **`index.html`** (CSS inline dans `<style>`, JS inline dans `<script>`)
- Aucune dépendance externe (polices système, pas de Google Fonts)
- Les fichiers `style.css` / `script.js` à la racine sont des **reliquats** non utilisés

## 📁 Structure

```
Chez-Framboise/
├── index.html              ← LE fichier principal (tout est dedans)
├── .htaccess               ← cache + gzip (Hostinger / LiteSpeed)
├── images/                 ← 9 photos optimisées (1600px / qualité 82%)
├── .github/workflows/
│   └── deploy.yml          ← déploiement FTP automatique
├── *.ps1                   ← scripts utilitaires images (dev local)
├── CLAUDE.md               ← mémoire de projet (contexte, décisions, historique)
└── README.md               ← ce fichier
```

## 💻 Développement local

Le site étant 100% statique, il suffit d'un serveur HTTP simple :

```powershell
# Python (recommandé)
py -m http.server 8080

# ou Node
npx serve -l 8080 .
```

Puis ouvrir http://localhost:8080. Éditer `index.html` et recharger le navigateur.

## 🚀 Déploiement

**Automatique** : chaque `git push` sur la branche `main` déploie le site sur
`chezframboise.re` en ~15 secondes.

```
git push                          # → GitHub Actions → FTP → Hostinger → en ligne
```

- **Workflow** : `.github/workflows/deploy.yml`
  ([SamKirkland/FTP-Deploy-Action](https://github.com/SamKirkland/FTP-Deploy-Action),
  upload incrémental, pas de build)
- **Hébergement** : Hostinger (mutualisé LiteSpeed), SSL gratuit + Force HTTPS
- **Secrets requis** (Settings → Secrets → Actions) : `FTP_SERVER`,
  `FTP_USERNAME`, `FTP_PASSWORD`

Déploiement manuel possible depuis l'onglet **Actions** (bouton « Run workflow »)
ou en ligne de commande :

```bash
gh workflow run deploy.yml --repo Kabary-ai/Chez-Framboise
```

## 🎨 Identité visuelle

| Token | Hex | Usage |
|---|---|---|
| `--cream` | `#FAF7F2` | Fond principal |
| `--forest` | `#2D4A3E` | Vert dominant (palmes) |
| `--framboise` | `#C0395B` | Signature de marque |
| `--emerald` | `#3FA66B` | Accent vif |
| `--coral` | `#E87356` | Accent secondaire |

Règle : ~75% crème + verts désaturés. Framboise et corail = ponctuations
chromatiques uniquement. Titres en serif (Palatino), corps en sans-serif système.

## 🌿 Branches

- **`main`** — version publiée sur chezframboise.re (V1.2)
- **`v2-direction`** — direction alternative archivée (non publiée)

---

*Pour le contexte complet du projet, les décisions de design et l'historique
des versions, voir [`CLAUDE.md`](./CLAUDE.md).*
