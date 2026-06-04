---
description: "[bicep-si] Construction only: write Bicep into 600_build/ and skip test execution."
---

## Bicep-SI 追加指示 (implement: 構築のみ・600_build へ出力)

> 以下は `bicep-si` プリセットが追記する指示。**コア手順のうちテスト実行に関する記述よりも
> 本セクションが優先する。**

### 1. 出力先は `600_build/`

すべての Bicep ソース（`main.bicep`、`modules/*.bicep`、`*.bicepparam`）を
**`FEATURE_DIR/600_build/`** 配下に作成する。トップレベル `infra/` は作らない。
`plan.md` の Source Code 構成と詳細設計（`300_detail-design/`）に従うこと。

### 2. 構築（コンストラクション）のみ — テストは実施しない

- 本コマンドは **`.bicep` の実装まで**を担当する。タスク完了マーク（`tasks.md` の `[x]`）は通常どおり行う。
- **コアの「テストを先に実行」「テストが通ること」等の手順は本キットでは適用しない。** 単体テストの
  観点設計は `/speckit.bicep.test-design`、実施は `/speckit.bicep.test` に分離している。
- 構築中に行ってよい確認は、構文確認のための `bicep build`（コンパイルが通るか）程度に留める。
  PSRule / ARM-TTK / what-if などの**テスト実施は行わない**。
- 実環境への**デプロイは行わない**（`az deployment ... create` は禁止。差分確認も別工程）。

### 3. 索引と次工程

- 任意で `600_build/build-notes.md` に構築メモ（モジュール構成、留意点）を残す。
- `FEATURE_DIR/000_index.md` の **600 構築** 行を `✅` に更新する。
- 完了報告で、次工程 `/speckit.bicep.test`（単体テスト実施）を案内する。
