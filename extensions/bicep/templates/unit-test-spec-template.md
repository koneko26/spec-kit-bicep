# 単体テスト仕様書: [FEATURE NAME]

**Feature**: `[###-feature-name]` | **作成日**: [DATE] | **元設計**: [link to 300_detail-design/detail-design.md]

> この仕様書は **構築前** に作成し、レビューゲートで承認を得る。結果列は `/speckit.bicep.test` が後から埋める。

## 1. テスト方針

- 対象範囲: [本フィーチャの Bicep モジュール群]
- 有効ツール: bicep build / bicep lint / what-if / PSRule for Azure / ARM-TTK（`bicep-config.yml` に従う）
- 環境前提: what-if は `az login` と対象スコープが必要。未整備時は SKIPPED 扱い。

## 2. テスト観点一覧

| ID | 観点 | 対象(module/resource) | 手法(tool) | 合格条件 | 結果 |
|------|------|----------------------|-----------|----------|------|
| UT-001 | コンパイル成功 | main.bicep | bicep build | エラー0 | |
| UT-002 | リンタ警告なし | 全 .bicep | bicep lint | 警告0（許容例外を明記） | |
| UT-003 | シークレット非ハードコード | params | bicep lint / 目視 | secure/KeyVault参照 | |
| UT-004 | 命名規則準拠 | 全リソース | PSRule / 目視 | 規則一致 | |
| UT-005 | 必須タグ付与 | 全リソース | PSRule | 必須タグ存在 | |
| UT-006 | デプロイ差分が設計通り | デプロイ全体 | what-if | 想定リソースのみ・削除なし | |
| UT-007 | ベストプラクティス準拠 | 全体 | PSRule for Azure | 対象ルールPass | |
| UT-008 | テンプレート品質 | 生成ARM | ARM-TTK | 必須テストPass | |
| UT-009 | パラメータ境界値 | params | 目視/what-if | allowed/min/max 妥当 | |
| UT-010 | 依存順序 | modules | 目視/what-if | 依存解決OK | |

[設計に応じて観点を追加・具体化すること。]

## 3. トレーサビリティ

| テストID | 対応する詳細設計項目 / 要件 |
|----------|------------------------------|
| | |

## 4. レビュー記録

| レビュア | 日付 | 承認状態 | コメント |
|----------|------|----------|----------|
| | | 未承認 | |
