# CLAUDE.md — Mémoire du projet Chez Framboise

> Fichier de contexte pour Claude. Lu automatiquement à chaque nouvelle session.
> **À mettre à jour à la fin de chaque session de travail importante.**

---

## 🏡 Le projet

Site vitrine pour **Chez Framboise**, une chambre d'hôtes située à **Salazie** (Cirque de Salazie, La Réunion — microrégion est, végétation tropicale humide).

- **Propriétaires-hôtes** : Françoise et Fred
- **Origine** : **Madagascar** (à exploiter discrètement dans le design — voir "En attente" plus bas)
- **Note Booking.com** : 9,4/10 · +200 voyageurs accueillis · +5 ans d'activité
- **Coordonnées GPS** : −21,047374, 55,529125
- **Réservation** : via Booking.com (lien direct dans le site)

## 👤 Propriétaire du projet

- **Utilisateur** : Devenherbe974
- **GitHub** : https://github.com/Devenherbe974
- **OS** : Windows 11, FR
- **Connaissance technique** : débutant (premier compte GitHub créé pendant la session V1)
- **Préférence de communication** : français, ton naturel, explications pédagogiques quand nécessaire

## 🔗 Liens importants

| Quoi | Où |
|---|---|
| Dossier local (main) | `D:\KABARY_AI\Projets\Chez-Framboise-main` |
| Worktree V2 | `D:\KABARY_AI\Projets\Chez-Framboise-v2` (branche `v2-direction`) |
| Dépôt GitHub | https://github.com/Kabary-ai/Chez-Framboise |
| **Site en production** | **https://chezframboise.re** (Hostinger, FTP auto via GitHub Actions) |
| Ancien dépôt (à archiver) | https://github.com/Devenherbe974/Chez-Framboise (plus utilisé) |
| Réservation Booking | https://www.booking.com/hotel/re/chez-framboise.fr.html |

### 🚀 Déploiement (chezframboise.re)

- **Méthode** : GitHub Actions → FTP vers Hostinger (hébergement mutualisé LiteSpeed). Chaque `git push` sur `main` déploie le site en ~15 s.
- **Workflow** : `.github/workflows/deploy.yml` (action `SamKirkland/FTP-Deploy-Action`, pas de build — HTML statique pur).
- **Secrets GitHub** (repo Kabary-ai/Chez-Framboise) : `FTP_SERVER` (72.60.93.193), `FTP_USERNAME` (u415647617.chezframboise.re), `FTP_PASSWORD`.
- **Compte FTP** scopé sur le dossier web → `server-dir: ./` atterrit directement dans la racine web. SSL gratuit + Force HTTPS actifs côté Hostinger.
- **`.htaccess`** : no-cache HTML, cache long images/assets, gzip.
- Déploiement manuel possible : `gh workflow run deploy.yml --repo Kabary-ai/Chez-Framboise`.

---

## 🛠 Stack & environnement

- **Aucun framework** : HTML5 + CSS3 + JS vanilla
- **Tout est dans `index.html`** : CSS inline dans `<style>`, JS inline dans `<script>` (les fichiers `style.css` et `script.js` séparés existent mais sont des reliquats, non utilisés)
- **Dev local** : serveur HTTP via `py -m http.server 8080` (config dans `.claude/launch.json`, ignorée par git)
- **Runtimes installés** : Git 2.54, Python 3.11 (via `py`). PAS de Node, npm, php
- **Preview Claude Code** : utiliser `mcp__Claude_Preview__preview_start` avec le nom "Chez Framboise — site statique"

## 📁 Structure des fichiers

```
Chez Framboise/
├── index.html              ← LE fichier principal (tout est dedans)
├── style.css               ← reliquat (CSS dupliqué inline dans index.html)
├── script.js               ← reliquat (JS dupliqué inline dans index.html)
├── images/                 ← 9 photos, optimisées 1600px / qualité 82%
│   ├── 1.jpg               panorama montagnes (hero)
│   ├── 21.jpg              portrait Françoise & Fred (section hôtes)
│   ├── 22.jpg              cascade verticale (galerie)
│   ├── chambre 1.jpg       chambre carrelée, vue jardin (galerie)
│   ├── chambre 2.jpg       chambre lambris bois (galerie)
│   ├── ext 1.jpg           jardin avec banc (galerie)
│   ├── ext 2.jpg           jardin avec palmier (section "Le lieu")
│   ├── salon.jpg           salon-véranda (galerie)
│   └── serre.jpg           serre aux orchidées (galerie)
├── embed-images.ps1        injecte les images en base64 dans index.html (dev portable)
├── unembed-images.ps1      inverse — restaure les références externes
├── optimize-images.ps1     redimensionne + recompresse les JPG
├── CLAUDE.md               ← ce fichier
├── .gitignore              ignore .claude/, .vscode/, etc.
└── .claude/launch.json     config dev server (gitignored)
```

---

## 🎨 Identité visuelle (à respecter)

### Palette exacte

| Token CSS | Hex | Usage |
|---|---|---|
| `--cream` | `#FAF7F2` | Fond principal |
| `--sand` | `#E8DFD0` | Cards, séparateurs |
| `--ink` | `#1A2420` | Texte principal |
| `--forest` | `#2D4A3E` | Vert dominant désaturé (palmes !) |
| `--moss` | `#5A7361` | Texte secondaire |
| `--bark` | `#8A8479` | Légendes, méta |
| `--emerald` | `#3FA66B` | Accent vif |
| `--framboise` | `#C0395B` | **Signature de marque** |
| `--coral` | `#E87356` | Accent secondaire |

**Règle :** ~75 % crème + verts désaturés. Framboise et corail = ponctuations chromatiques uniquement (jamais en aplat large).

### Typographies (actuelles)

- **Titres** : `Palatino Linotype, Palatino, Book Antiqua, Georgia, serif` (polices système)
- **Corps** : `system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif`
- **Note** : Google Fonts (Cormorant Garamond + Inter) ont été retirés car bloqués par le sandbox de preview. Pour la V2 sur vrai serveur, on peut les rétablir.

### Principes graphiques

- Formes organiques, courbes douces, motifs végétaux SVG
- Animations subtiles (reveal au scroll, hover states, palmes en fond)
- Mobile-first strict, breakpoints à 640 / 900 / 1100 px

---

## 🏗 Structure du site (sections dans l'ordre)

1. **Header** sticky (transparent → solide au scroll)
2. **Hero** plein écran (image `1.jpg`, titre poétique, CTA Booking)
3. **Le lieu** (`#lieu`) — présentation + stats (note, voyageurs, années) + image `ext 2.jpg`
4. **Hôtes** — portrait Françoise & Fred + citation Booking
5. **Galerie** (`#galerie`) — 6 images en grille asymétrique (lightbox au clic)
6. **Services** (`#services`) — 8 cards icônes SVG (Wi-Fi, parking, petit-déj, PMR, terrasse, non-fumeur, conseils, randonnée)
7. **Avis** — 3 témoignages (Jean, Valérie, Céline)
8. **Séjour** (`#sejour`) — fond vert sombre, CTA réservation
9. **Contact** (`#contact`) — bloc carte statique (PAS d'iframe Google : bloqué en preview)
10. **Outro** — phrase de clôture : *"Au plaisir de vous accueillir bientôt chez nous."*
11. **Footer** sombre

### Animation de fond (présente partout sauf sections opaques)

- 4 palmes SVG line-art en `position: fixed`, opacité ~13%
- Balancement désynchronisé (3-4° d'amplitude, 6,5 à 7,5 s/cycle)
- Visibles uniquement sur les sections claires/transparentes (lieu, galerie, contact, outro)
- L'animation **n'est PAS désactivée** par `prefers-reduced-motion` (amplitude sous le seuil WCAG)

---

## 📋 Décisions prises & rationale

| Décision | Pourquoi |
|---|---|
| Tout inline dans `index.html` | Le sandbox de preview Claude ne sert qu'un seul fichier |
| Polices système (Palatino/system-ui) | Google Fonts bloqué par le sandbox |
| Carte statique au lieu d'iframe Google Maps | `maps.google.com` bloqué par le sandbox |
| Images URL-encodées (`chambre%201.jpg`) | Espaces dans les noms de fichiers |
| Images redimensionnées 1600 px / 82 % qualité | Réduction 96 % du poids (56 Mo → 2,5 Mo) |
| `.outro` rendue transparente | Pour laisser voir les palmes en fond |
| Légendes de galerie retirées | Demande utilisateur (V1) |
| Phrase poétique d'introduction du hero retirée | Demande utilisateur (V1) — titre seul plus percutant |
| Feuille `.leaf-deco` au-dessus de la photo "Le lieu" retirée | Demande utilisateur (V1) |

---

## ⏳ En attente / pour la V2

### Clin d'œil Madagascar (à trancher)

J'ai proposé 5 idées, l'utilisateur a dit "nous verrons ça plus tard" :

1. **Salutation "Tonga soa"** (bienvenue en malgache) — narratif, ultra subtil
2. **Une palme transformée en Ravinala** (l'arbre du voyageur, emblème national) — subtil et symbolique
3. **Micro-bande tricolore blanc/rouge/vert** comme séparateur récurrent (dans le logo, sous les eyebrows, footer)
4. **Phrase narrative** dans la section "Vos hôtes" mentionnant Madagascar
5. **Mini-drapeau SVG** sous le portrait des hôtes

**Mon coup de cœur :** combo 1 + 3. **Préférence intellectuelle :** option 2 (Ravinala).

### Autres axes V2 possibles (du rapport initial)

- Conversion JPG → WebP/AVIF pour gagner encore en poids
- Localisation EN/FR
- Page dédiée "Les environs" (Voile de la Mariée, Hell-Bourg, etc.)
- Système de témoignages dynamique (API Booking / Google Reviews)
- Carte interactive Leaflet (style aquarelle) en remplacement du bloc statique
- Mode sombre
- CMS léger pour que Françoise & Fred éditent eux-mêmes

---

## 🔄 Workflow git (sauvegarde sur GitHub)

L'utilisateur ne connaît pas git. **C'est moi qui fais.**

À chaque fin de modification importante :

```powershell
Set-Location "C:\Users\Utilisateur\Desktop\Chez Framboise"
git add .
git commit -m "Message clair en français"
git push
```

Après push, GitHub Pages reconstruit le site en 1-2 min.

**Convention de message de commit** : verbe d'action en début, ton naturel, explique le pourquoi.

---

## 📜 Historique des versions

### V1 — finalisée et en ligne (session 1)

- ✅ Refonte complète du site (CSS, JS, structure)
- ✅ Identité visuelle posée
- ✅ Images optimisées (-96 %)
- ✅ Push initial GitHub
- ✅ GitHub Pages activé par l'utilisateur
- ✅ Animation palmes en fond
- ✅ Suppression des éléments superflus (légendes galerie, lead hero, leaf-deco)

### V1.1 — en ligne (session 2)

- ✅ Sections réordonnées : Hôtes déplacés *après* les avis
- ✅ Section avis refondue en widget façon Booking.com (score 9,4 sur badge
  bleu Booking #003580, cards entièrement cliquables vers Booking, CTA #0071c2)

### V2 — branche `v2-direction` sur GitHub (session 3)

Suite à un retour "IA SLOP" (texte trop générique + visuel trop template),
réécriture complète sur **branche séparée** pour ne pas écraser la V1 en ligne.

Décisions du propriétaire pour cette V2 :
- ❌ Madagascar : **pas mentionné dans le texte** (peut-être plus tard)
- ✅ Signature visuelle malgache discrète :
  - Mark **Ravinala** (l'arbre du voyageur) en silhouette dans le logo
  - **Mini-tricolore** encodé dans la palette existante (ivoire / framboise /
    forest) — apparaît dans la sejour-card et dans le footer
- ✅ **Petit-déjeuner** : seul élément culinaire mis en avant (section dédiée)

Changements V2 vs V1 :
- Hero sans vague SVG, titre factuel
  *"Une maison à Salazie, à quatre kilomètres du Cirque"*
- Nouvelle section intro éditoriale (rupture du pattern eyebrow/titre/p)
- Layout "Le lieu" asymétrique (photo plein cadre + fiche identité magazine)
- Section petit-déjeuner dédiée (préparée par Françoise, horaires concrets)
- 8 cards services → paragraphe + liste compacte à tirets
- Outro template (feuille centrée + italique) supprimée
- 4 palmes en fond → 2, opacité réduite

### Workflow des branches (à savoir pour les prochaines sessions)

- **`main`** = ce qui est publié sur GitHub Pages (V1 + V1.1)
- **`v2-direction`** = la V2, jamais publiée tant qu'on ne fusionne pas
- Le dossier local `Chez Framboise` est UN seul dossier qui se métamorphose
  selon la branche active. Pour basculer :
  ```powershell
  git checkout main           # le dossier devient V1
  git checkout v2-direction   # le dossier devient V2
  ```
- L'ancien dossier `Chez Framboise V2` sur le bureau a été supprimé : la V2
  vit maintenant dans la branche.

**Pour publier la V2** (si décision finale) :
```powershell
git checkout main
git merge v2-direction
git push
```

### V1.2 — EN LIGNE sur chezframboise.re (session 4)

Décision du propriétaire : **on garde la V1 et on itère dessus** (la V2 reste
archivée sur `v2-direction`, non publiée). Mise en production sur le domaine
dédié **chezframboise.re** (Hostinger).

Modifications V1.2 (sur `main`) :
- Section "Bienvenue" : *"Une chambre lumineuse"* (au lieu du pluriel)
- Galerie : photo `chambre 1.jpg` retirée du site ; refonte du layout en
  placement explicite **sans trous** (cascade verticale en grand à gauche +
  4 carrés ; rectangle plein à tous les breakpoints) — fini l'effet quinconce
- Services : suppression des cases **Accès PMR** et **Conseils sur-mesure** ;
  grille passée en **3×2 parfaitement alignée** (était 4+2)
- Séjour & tarifs : mot *"continental"* retiré du petit-déjeuner
- Footer : **import du footer V2** (signature tricolore discrète ivoire/framboise/forest)
- Contact : carte statique → **iframe Google Maps interactif** (zoom, Street View,
  itinéraire), gratuit sans clé API, `output=embed` sur les coords GPS
- **Infra** : dépôt déplacé sous le compte `Kabary-ai`, déploiement FTP auto vers
  Hostinger (voir section Déploiement en haut)

### Idées en attente

- Madagascar plus explicite dans le texte (si Françoise et Fred changent d'avis)
- WebP/AVIF, page "Les environs", carte Leaflet, mode sombre, CMS léger
- Nettoyer `images/chambre 1.jpg` (asset désormais inutilisé) + reliquats `style.css`/`script.js`
- Archiver/supprimer l'ancien dépôt `Devenherbe974/Chez-Framboise`

---

## 💬 Pour la prochaine session

**Reprends ici** : **V1.2 EN LIGNE sur https://chezframboise.re** (branche `main`,
dépôt `Kabary-ai/Chez-Framboise`). Déploiement auto par push. V2 toujours archivée
sur `v2-direction` (non publiée, décision = on itère sur la V1).

**Vérifier d'abord** :
- `git status` et `git branch` (toujours)
- Le remote doit pointer sur `Kabary-ai/Chez-Framboise` (`git remote -v`)
- Tester le site live : `curl.exe -I https://chezframboise.re/`

**Pour déployer une modif** : éditer → `git push` sur `main` → en ligne en ~15 s.
Suivi : `gh run list --repo Kabary-ai/Chez-Framboise`.

**Ne pas oublier** : mettre à jour ce CLAUDE.md à la fin de la session.
