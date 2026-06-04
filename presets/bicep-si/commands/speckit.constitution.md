---
description: "[bicep-si] Ensure the constitution records the Azure-best-practice-first + Bicep technical policy."
---

## Bicep-SI 追加指示 (constitution)

> 以下は `bicep-si` プリセットが追記する指示。上記コア手順の完了後に必ず反映すること。

このプロジェクトの constitution には、**技術方針として次を必ず明記**すること（テンプレートの
「技術方針: Azure ベストプラクティス & Bicep」セクションに対応）:

- **まず Azure のベストプラクティス（WAF / CAF）に従って Azure を設計・構築し、その IaC 化手段として Bicep を用いる。** Azure 設計が上位、Bicep は実装手段。
- **Bicep 自体もベストプラクティスに準拠**（モジュール化、デコレータ、`.bicepparam`、シークレット非ハードコード／Key Vault 参照、命名規則・必須タグ、`bicep build`/`lint` 無警告）。
- 成果物は番号フォルダ（`100_`〜`700_`）＋ `000_index.md` で管理し、Bicep ソースは各フィーチャの `600_build/` に置く（`infra/` は作らない）。

### WAF 5本柱を統治原則に

constitution の原則として、**Well-Architected Framework の 5本柱**を明記すること。これらは全工程の
背骨となり、基本設計の節・テスト観点・analyze のカバレッジ検査に対応する:

1. **信頼性 (Reliability)** — 可用性ゾーン/冗長、バックアップ、DR(RTO/RPO)
2. **セキュリティ (Security)** — MCSB ベースライン、最小権限 RBAC、ネットワーク分離、暗号化、Key Vault
3. **コスト最適化 (Cost Optimization)** — SKU 最適化、コスト配賦タグ、ガードレール
4. **運用上の優秀性 (Operational Excellence)** — 診断/Log Analytics、アラート、IaC 運用
5. **性能効率 (Performance Efficiency)** — 適切な SKU/階層、オートスケール、キャパシティ計画

あわせて **Constitution Check（設計ゲート）** の合否基準として「5本柱の充足」「MCSB ベースライン」
「必須タグ・Azure Policy 準拠」を含めるよう促す（plan の Constitution Check と連動）。

ユーザの入力でこれらに反する指示が無い限り、上記方針を constitution に含めること。含めた旨を完了報告に記載する。
