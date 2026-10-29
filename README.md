# Nisses vintips

Publik sida med varje släpp i Systembolagets tillfälliga sortiment: alla viner med pris och länk till Systembolaget, plus Nisses markeringar (Bra köp), kommentarer och inledning per släpp. Nisse loggar in med en e-postlänk och kan exportera ett släpp till Word (öppnas direkt i Google Docs).

## Filer

- `index.html` – hela sidan
- `config.js` – Supabase-nycklar och var vinlistan hämtas
- `supabase.sql` – databas och behörigheter, körs en gång i Supabase
- `releases.json` – reservkopia av vinlistan om Winewine inte svarar
- `CNAME` – domänen för GitHub Pages

## Vinlistan

Sidan läser `releases.json` från Winewine-repot (`p12ftw/vinofino`) vid varje besök. När Winewine uppdateras med ett nytt släpp dyker det upp här också. Inget extra att göra.

## Sätta upp (ca 20 minuter)

### 1. Supabase (databas och inloggning)

1. Skapa ett gratis konto på supabase.com och ett nytt projekt (region: Stockholm eller Frankfurt).
2. **SQL Editor** → klistra in `supabase.sql`. Byt `nisse@exempel.se` mot Nisses riktiga adress (gemener). Lägg till din egen på en rad till om du också vill redigera. Kör.
3. **Authentication → Sign In / Providers**: se till att *Email* är på och slå **av** *Allow new users to sign up*.
4. **Authentication → Users → Add user → Send invitation**: bjud in Nisse med samma e-post.
5. **Authentication → URL Configuration**: sätt *Site URL* till `https://nissesvintips.se` och lägg till samma adress under *Redirect URLs* (lägg även till `https://<ditt-github-namn>.github.io/nissesvintips/` medan du väntar på domänen).
6. **Project Settings → API**: kopiera *Project URL* och *anon public key* in i `config.js`.

Anon-nyckeln är gjord för att ligga publikt. Skrivrättigheten styrs av tabellen `editors` i databasen.

### 2. GitHub Pages

1. Skapa ett nytt publikt repo, t.ex. `nissesvintips`, och ladda upp alla filer.
2. **Settings → Pages**: Source *Deploy from a branch*, branch `main`, mapp `/ (root)`.
3. När domänen är köpt: låt `CNAME` ligga kvar och peka domänen mot GitHub hos registraren:
   - fyra A-poster för `@`: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - CNAME för `www` → `<ditt-github-namn>.github.io`
   Bocka sedan i *Enforce HTTPS* under Settings → Pages.

Innan domänen är klar: ta bort `CNAME`, så nås sidan på `https://<ditt-github-namn>.github.io/nissesvintips/`.

## För Nisse

- Klicka **Logga in**, skriv in din e-post och klicka på länken i mejlet.
- Välj släpp överst. Klicka **Markera bra köp** och skriv kommentarer direkt under varje vin. Allt sparas av sig självt.
- Rutan överst är inledningen till släppet.
- **Exportera till Word** laddar ner hela släppet med dina bra köp först och alla viner i tabeller med dina kommentarer. Öppna filen i Google Drive så blir den ett Google-dokument.
