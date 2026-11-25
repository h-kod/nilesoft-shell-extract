# Nilesoft Shell — Arşiv Klasöre Çıkart

Windows sağ tık menüsünde sıkıştırılmış/arşiv dosyaları (`.zip`, `.rar`, `.7z`, `.tar`, `.gz`, `.bz2`, `.xz`, `.zst`, `.iso`, `.cab` vb.) için **Aç** seçeneğinin hemen altına (2. sıraya) **Klasöre çıkart** komutu ekler. Arşivi aynı dizinde kendi adıyla bir klasöre çıkarır (`dosya.rar` → `dosya\`).

## Gereksinimler

- [Nilesoft Shell](https://nilesoft.org/) (kurulu ve kayıtlı / `register` edilmiş)
- [7-Zip](https://www.7-zip.org/) (`7zG.exe`)

## Kurulum

### Otomatik (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### Manuel

1. [extract-zip.nss](extract-zip.nss) içeriğini `shell.nss` dosyanıza ekleyin (`import 'imports/modify.nss'` satırının altına).
2. Explorer'ı yenileyin:

```cmd
shell.exe -restart
```

## Dosyalar

- `extract-zip.nss` — Nilesoft Shell menü tanımı
- `install.ps1` — Nilesoft Shell ve 7-Zip yolunu otomatik bulup kuran script
- `README.md` — Kullanım dokümanı
- `LICENSE` — MIT lisansı

## Notlar

- Daha önce `7-Zip.zip` veya `CompressedFolder` kayıt defteri anahtarlarına elle eklediğiniz eski çıkartma komutları ya da `imports/modify.nss` içinde `pos="bottom"` kuralı varsa kaldırın; aksi halde menüde çift veya en altta görünebilir.
