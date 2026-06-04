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

ユーザの入力でこれらに反する指示が無い限り、上記方針を constitution に含めること。含めた旨を完了報告に記載する。
