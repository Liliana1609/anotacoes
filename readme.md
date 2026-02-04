# (NOME_DO_APP) — App Premium de Currículos

Este repositório entrega um projeto completo em Flutter + NestJS para criação de currículos premium, com exportação PDF/DOCX, planos pagos, limites por assinatura, idiomas, processamento de foto por IA e geração assistida de texto.

---

## 1) Arquitetura geral

**Visão macro**
- **Flutter (Mobile + Web/PWA)**: interface do usuário, edição do currículo, pagamentos e upload de foto. Integração com Firebase Auth e API REST.
- **NestJS (API REST)**: validação de autenticação, regras de negócio (limites, planos), geração de exportações, processamento de imagem e integração de pagamentos.
- **PostgreSQL + Prisma**: persistência dos currículos, downloads, limites e assinaturas.
- **Firebase**: autenticação e storage (PDF/DOCX/Imagens), tokens usados para autorização nas APIs.
- **Pagamentos**: Stripe (Web) e Google Play Billing (Android). Backend valida recibos e registra entitlement.
- **IA**: processamento de imagem (crop, ajustes) e geração de texto via OpenAI.

**Fluxo principal**
1. Usuário autentica via Firebase.
2. Flutter envia ID Token para `POST /auth/session`.
3. Backend sincroniza/atualiza usuário no PostgreSQL.
4. Usuário cria currículo, escolhe template e exporta.
5. Backend aplica regras do plano, gera exportação e grava download.
6. Pagamentos registram entitlements e liberam limites.

---

## 2) Estrutura completa de pastas

```
/src
  /flutter_app
    /lib
      /app
      /core
      /features
  /backend
    /src
      /modules
      /services
    /prisma
```

---

## 3) Modelagem do banco (Prisma)

Confira o schema completo em: `src/backend/prisma/schema.prisma`.

Modelos principais: `User`, `Resume`, `ResumeVersion`, `Download`, `Subscription`, `Payment`, `PhotoProcess`.

---

## 4) APIs documentadas (REST)

Base URL: `https://<backend-url>`

### Auth
- `POST /auth/session`
  - Headers: `Authorization: Bearer <firebaseIdToken>`
  - Retorno: dados do usuário sincronizado.

### Usuário
- `GET /users/me` (Auth)
- `DELETE /users/me` (Auth) — exclusão de conta e dados (LGPD).

### Currículos
- `GET /resumes` (Auth)
- `POST /resumes` (Auth)
  - Body: `{ title, summary?, content }`
- `PUT /resumes/:id` (Auth)

### Downloads
- `GET /downloads` (Auth)
- `POST /downloads` (Auth)
  - Body: `{ resumeId, format, storageUrl }`

### Pagamentos
- `POST /billing/stripe/checkout` (Auth)
  - Body: `{ priceId, successUrl, cancelUrl, mode }`
- `POST /billing/stripe/subscribe` (Auth)
  - Body: `{ tier, providerRef, status, periodEnd }`
- `POST /billing/google-play/receipt` (Auth)
  - Body: `{ tier, receipt }`

### IA
- `POST /ai/photo` (Auth, multipart)
  - Form-data: `file`, `crop` (`4:5` ou `1:1`)
  - Retorno: `imageBase64`
- `POST /ai/text`
  - Body: `{ prompt, locale, model? }`

---

## 5) Código Flutter por arquivos

Local: `src/flutter_app/lib`.

Principais arquivos:
- `main.dart` — inicialização do app e Firebase.
- `app/app.dart` — roteamento e tema.
- `core/env.dart` — variáveis de ambiente (dart-define).
- `features/*` — telas e fluxo completo.

---

## 6) Código Backend por arquivos

Local: `src/backend/src`.

Principais módulos:
- `modules/auth` — autenticação Firebase e sincronização de usuário.
- `modules/resume` — CRUD de currículos.
- `modules/downloads` — controle de limites e histórico.
- `modules/billing` — Stripe + Google Play.
- `modules/ai` — processamento de foto e geração de texto.

---

## 7) Guia passo a passo

### Instalação do Flutter
1. Baixe o SDK: https://docs.flutter.dev/get-started/install
2. Configure PATH.
3. Rode `flutter doctor`.

### Instalação do Node.js
1. Baixe o LTS: https://nodejs.org
2. Rode `node -v` e `npm -v`.

### Configuração do Firebase
1. Crie projeto no Firebase.
2. Ative Auth (Google + Email/Senha).
3. Configure Firebase Storage.
4. Gere credenciais Admin SDK e configure no backend.

### Configuração do Banco PostgreSQL
1. Crie DB (Railway/Supabase).
2. Configure `DATABASE_URL` no backend.
3. Rode `npm run prisma:generate` e `npm run prisma:migrate`.

### Execução local
**Backend**
```bash
cd src/backend
npm install
npm run prisma:generate
npm run prisma:migrate
npm run start:dev
```

**Flutter**
```bash
cd src/flutter_app
flutter pub get
flutter run -d chrome
```

### Build Android (AAB)
```bash
flutter build appbundle --dart-define=API_BASE_URL=... \
  --dart-define=FIREBASE_PROJECT_ID=... \
  --dart-define=FIREBASE_API_KEY=... \
  --dart-define=FIREBASE_APP_ID=... \
  --dart-define=FIREBASE_MESSAGING_SENDER_ID=...
```

### Deploy Web (PWA)
```bash
flutter build web --release --web-renderer html
```
Hospede a pasta `build/web` em Firebase Hosting, Vercel ou Netlify.

### Publicação na Play Store
1. Gere keystore e configure `key.properties`.
2. Rode `flutter build appbundle`.
3. Faça upload no Google Play Console.

---

## IDE e ferramentas (como usar)

**Android Studio**
- Instale plugin Flutter e Dart.
- Use device manager para emuladores.

**VS Code**
- Extensões: Flutter, Dart, Firebase.

**Prisma CLI**
- `npx prisma studio` para visualizar dados.

**Firebase Console**
- Configure Auth, Storage e Web App.

**Google Play Console**
- Crie app, defina preços e cadastre assinaturas.

**Stripe Dashboard**
- Crie produtos e preços para web.

---

## Variáveis de ambiente

### Backend (`src/backend/.env`)
```
DATABASE_URL=postgresql://user:pass@host:5432/db
FIREBASE_PROJECT_ID=...
FIREBASE_CLIENT_EMAIL=...
FIREBASE_PRIVATE_KEY=...
STRIPE_SECRET_KEY=...
OPENAI_API_KEY=...
```

### Flutter (via `--dart-define`)
```
API_BASE_URL=https://api.seudominio.com
FIREBASE_PROJECT_ID=...
FIREBASE_API_KEY=...
FIREBASE_APP_ID=...
FIREBASE_MESSAGING_SENDER_ID=...
FIREBASE_AUTH_DOMAIN=...
FIREBASE_STORAGE_BUCKET=...
```

---

## Padrão visual
Paleta aplicada no tema do app:
- #F7F3D5 (background)
- #FFDABF (cards)
- #FA9B9B / #E88087 (acentos)
- #635063 (texto)

---

## Observações de segurança
- Tokens do Firebase são validados no backend.
- Limites por plano controlados no servidor.
- Nenhuma chave sensível fica exposta no frontend.

---

## Estrutura de telas
- Splash
- Onboarding
- Login
- Home / Meus Currículos
- Editor (Stepper)
- Foto Profissional (IA)
- Templates
- Preview
- Exportação
- Planos
- Idiomas
- Conta

---

> Projeto executável com Flutter + NestJS. Customize `(NOME_DO_APP)` e ajuste endpoints conforme o ambiente.
