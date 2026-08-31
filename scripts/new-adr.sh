#!/usr/bin/env bash
# Şablondan numaralandırılmış yeni bir ADR kaydı oluşturur.
set -euo pipefail
cd "$(dirname "$0")/.." || exit 1

TITLE="${1:-}"
if [ -z "$TITLE" ]; then
  printf 'Karar başlığı: '; read -r TITLE
fi
[ -z "$TITLE" ] && { echo "Başlık zorunludur." >&2; exit 1; }

SLUG=$(printf '%s' "$TITLE" | tr '[:upper:]' '[:lower:]' \
  | sed 'y/çğıöşü/cgiosu/' | sed -E 's/[^a-z0-9]+/-/g; s/^-|-$//g')
LAST=$(find docs/adr -name '[0-9][0-9][0-9][0-9]-*.md' 2>/dev/null | sed -E 's|.*/([0-9]{4})-.*|\1|' | sort -n | tail -1)
NEXT=$(printf '%04d' $(( 10#${LAST:-0} + 1 )))
OUT="docs/adr/${NEXT}-${SLUG}.md"

sed -e "s|^# Mimari Karar Kayıtları (Architecture Decision Record - ADR) Şablonu|# ADR-${NEXT}: ${TITLE}|" \
    -e "s|^## 1\. Başlık \[Kısa ve Açıklayıcı Karar Başlığı\]|## 1. Künye|" \
    -e "s|\*\*Tarih:\*\* YYYY-AA-GG|**Tarih:** $(date +%Y-%m-%d)|" \
    docs/process/adr-template.md > "$OUT"

echo "✅ Oluşturuldu: $OUT"
echo "   Sonraki adım: kaydı doldurun ve docs/adr/README.md indeksine satır ekleyin."
