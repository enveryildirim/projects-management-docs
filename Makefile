# Mühendislik Yönetişim Çerçevesi — depo bakım hedefleri
# Bu Makefile, Playbook deposunun kendi tutarlılığını denetler (Policy-as-Code).
# Ürün depolarındaki `make setup` / `make dev` hedefleri için bkz:
#   docs/process/onboarding-and-setup.md

.DEFAULT_GOAL := help
.PHONY: help check check-links check-index check-meta check-layers new-adr stats

help: ## Kullanılabilir hedefleri listeler
	@grep -hE '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-16s\033[0m %s\n", $$1, $$2}'

check: ## Tüm doküman denetimlerini çalıştırır (CI ile aynı)
	@./scripts/check-docs.sh all

check-links: ## Kırık iç bağlantıları ve sahte arama bağlantılarını tespit eder
	@./scripts/check-docs.sh links

check-index: ## README/klasör indeksleri ile dosya sistemi tutarlılığını denetler
	@./scripts/check-docs.sh index

check-meta: ## Sahiplik, versiyon ve amaç bloğu eksiklerini listeler
	@./scripts/check-docs.sh meta

check-layers: ## docs/core/ teknoloji bağımsızlığını denetler (katman kuralı)
	@./scripts/check-docs.sh layers

new-adr: ## Şablondan numaralandırılmış yeni bir ADR oluşturur
	@./scripts/new-adr.sh $(TITLE)

stats: ## Doküman sayısı ve hacim istatistiklerini gösterir
	@printf 'Doküman sayısı : %s\n' "$$(find . -path ./.git -prune -o -name '*.md' -print | wc -l | tr -d ' ')"
	@printf 'Toplam satır   : %s\n' "$$(find . -path ./.git -prune -o -name '*.md' -print0 | xargs -0 cat | wc -l | tr -d ' ')"
	@printf 'Taslak doküman : %s\n' "$$(grep -rl 'DOKÜMAN DURUMU: TASLAK' --include='*.md' . 2>/dev/null | wc -l | tr -d ' ')"
