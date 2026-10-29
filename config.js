// Inställningar för Nisses vintips.
// Fyll i Supabase-uppgifterna (Project Settings → API) för att slå på inloggning.
// Lämnas de tomma körs sidan i demoläge: markeringar sparas bara i den egna webbläsaren.
window.NVT_CONFIG = {
  SUPABASE_URL: "https://oqoaykxuohckzbfpqjqx.supabase.co",
  SUPABASE_ANON_KEY: "sb_publishable_7l2rHoXj2tYt3NzvkYUcRg_yTalHH8t",

  // Var vinlistorna hämtas. Den första som svarar används.
  // Winewines releases.json uppdateras varje vecka, så sidan följer med automatiskt.
  DATA_URLS: [
    "https://raw.githubusercontent.com/p12ftw/vinofino/main/releases.json",
    "releases.json"
  ]
};
