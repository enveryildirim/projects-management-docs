#!/usr/bin/env bash
# Playbook tutarlılık denetimi (Policy-as-Code).
# Kullanım: ./scripts/check-docs.sh [links|index|meta|layers|all]
# Çıkış kodu 0 = tüm denetimler başarılı, 1 = en az bir ihlal.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

FAIL=0
fail() { printf '  \033[31m✗\033[0m %s\n' "$1"; FAIL=1; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
head_() { printf '\n\033[1m▸ %s\033[0m\n' "$1"; }

# Denetlenen dokümanlar. .github/ altındaki dosyalar doküman değil form/şablondur;
# doküman standardı (amaç bloğu, sahiplik footer'ı, indeks kaydı) onlar için geçerli değildir.
md_files() {
  find . \( -path ./.git -o -path ./.github -o -path ./node_modules \) -prune \
       -o -name '*.md' -print | sort
}

# ── 1. Kırık iç bağlantılar ───────────────────────────────────────────────
check_links() {
  head_ "Kırık iç bağlantı denetimi"
  local n=0
  while IFS= read -r src; do
    local dir; dir=$(dirname "$src")
    while IFS= read -r link; do
      [ -z "$link" ] && continue
      case "$link" in http*|mailto:*|'#'*) continue;; esac
      local target="${link%%#*}"
      [ -z "$target" ] && continue
      if [ ! -e "$dir/$target" ]; then
        fail "$src → $link"; n=$((n+1))
      fi
    done < <(grep -oE '\]\([^)]+\)' "$src" 2>/dev/null | sed -E 's/^\]\(//; s/\)$//')
  done < <(md_files)
  [ "$n" -eq 0 ] && ok "tüm iç bağlantılar geçerli"
}

# ── 2. Sahte arama bağlantıları ───────────────────────────────────────────
check_fakelinks() {
  head_ "Sahte arama bağlantısı denetimi"
  local hits; hits=$(grep -rnE '\]\(https?://[^)]*(google\.com/search|bing\.com/search)' --include='*.md' . 2>/dev/null)
  if [ -n "$hits" ]; then
    printf '%s\n' "$hits" | while IFS= read -r l; do fail "arama bağlantısı: ${l%%:*}"; done
    FAIL=1
  else
    ok "arama motoruna yönlenen sahte bağlantı yok"
  fi
}

# ── 3. İndeks tutarlılığı ─────────────────────────────────────────────────
check_index() {
  head_ "İndeks tutarlılığı denetimi (README kapsaması)"
  local n=0
  while IFS= read -r f; do
    local base; base=$(basename "$f")
    case "$base" in README.md) continue;; esac
    case "$f" in ./plans/*) continue;; esac
    if ! grep -qF "$base" README.md 2>/dev/null; then
      local dirindex="$(dirname "$f")/README.md"
      if [ ! -f "$dirindex" ] || ! grep -qF "$base" "$dirindex" 2>/dev/null; then
        fail "hiçbir indekste yer almıyor: $f"; n=$((n+1))
      fi
    fi
  done < <(md_files)
  [ "$n" -eq 0 ] && ok "tüm dokümanlar bir indeksten erişilebilir"
}

# ── 4. Sahiplik / versiyon (footer) denetimi ───────────────────────────────
check_meta() {
  head_ "Sahiplik ve versiyon bilgisi denetimi"
  local n=0
  while IFS= read -r f; do
    case "$f" in ./TODO.md|./CODEOWNERS) continue;; esac
    if ! grep -qiE 'son g(ü|u)ncelleme' "$f"; then
      fail "footer eksik (Son Güncelleme / Versiyon / Doküman Sahibi): $f"; n=$((n+1))
    fi
  done < <(md_files)
  [ "$n" -eq 0 ] && ok "tüm dokümanlarda sahiplik bilgisi mevcut"
}

# ── 5. Amaç bloğu denetimi ────────────────────────────────────────────────
check_purpose() {
  head_ "Amaç ve kapsam bloğu denetimi"
  local n=0
  while IFS= read -r f; do
    case "$f" in ./TODO.md|./README.md) continue;; esac
    # ADR kayıtları farklı şablon kullanır: amaç bloğu yerine künye (Durum) zorunludur.
    case "$f" in
      ./docs/adr/[0-9]*)
        if ! head -8 "$f" | grep -qE '^\* \*\*Durum:\*\*'; then
          fail "ADR künyesinde Durum satırı eksik: $f"; n=$((n+1))
        fi
        continue;;
    esac
    if ! head -12 "$f" | grep -qE '^> \*\*'; then
      fail "amaç bloğu (> **...**) eksik: $f"; n=$((n+1))
    fi
  done < <(md_files)
  [ "$n" -eq 0 ] && ok "tüm dokümanlarda amaç bloğu mevcut"
}

# ── 6. Katman kuralı: core teknoloji bağımsız olmalı ──────────────────────
check_layers() {
  head_ "Katman kuralı denetimi (core teknoloji bağımsızlığı)"
  local pattern='ESLint|Prettier|pnpm|npm run|Next\.js|Tailwind|Drizzle|console\.log|husky|faker\.js|\.cursorrules|TruffleHog|git-secrets|PostgreSQL|Vitest|Playwright'
  local hits; hits=$(grep -rnoE "$pattern" docs/core/ 2>/dev/null)
  if [ -n "$hits" ]; then
    printf '%s\n' "$hits" | while IFS= read -r l; do fail "docs/core/ içinde yığın-spesifik terim: $l"; done
    FAIL=1
  else
    ok "docs/core/ teknoloji bağımsız"
  fi
}

# ── 7. Boş dosya denetimi ─────────────────────────────────────────────────
check_empty() {
  head_ "Boş dosya denetimi"
  local n=0
  while IFS= read -r f; do
    fail "boş veya anlamsız kısa dosya: $f"; n=$((n+1))
  done < <(find . -path ./.git -prune -o -type f \( -name '*.md' -o -name 'Makefile' -o -name 'CODEOWNERS' \) -size -32c -print)
  [ "$n" -eq 0 ] && ok "boş dosya yok"
}

# ── 8. Tek H1 kuralı (kod blokları hariç) ─────────────────────────────────
check_h1() {
  head_ "Tek H1 başlık kuralı denetimi"
  local n=0
  while IFS= read -r f; do
    local c
    c=$(awk '
      /^```/ { fence = !fence; next }
      !fence && /^# / { count++ }
      END { print count+0 }
    ' "$f")
    if [ "$c" -gt 1 ]; then
      fail "$c adet H1 başlığı var (tek konu = tek H1): $f"; n=$((n+1))
    elif [ "$c" -eq 0 ]; then
      fail "H1 başlığı yok: $f"; n=$((n+1))
    fi
  done < <(md_files)
  [ "$n" -eq 0 ] && ok "her doküman tek bir H1 başlığı taşıyor"
}

case "${1:-all}" in
  links)  check_links; check_fakelinks;;
  index)  check_index;;
  meta)   check_meta; check_purpose; check_h1;;
  layers) check_layers;;
  all)    check_links; check_fakelinks; check_index; check_meta; check_purpose; check_h1; check_layers; check_empty;;
  *) echo "Kullanım: $0 [links|index|meta|layers|all]"; exit 2;;
esac

echo
if [ "$FAIL" -eq 0 ]; then
  printf '\033[32m✅ Tüm doküman denetimleri başarılı.\033[0m\n'
else
  printf '\033[31m❌ Denetim başarısız. Yukarıdaki ihlaller giderilmelidir.\033[0m\n'
  printf '   Gerekçe: docs/process/documentation-standards.md\n'
fi
exit "$FAIL"
