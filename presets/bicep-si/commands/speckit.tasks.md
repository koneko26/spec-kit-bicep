---
description: "[bicep-si] Bicep-oriented WBS (construction only) and index update."
---

## Bicep-SI 追加指示 (tasks: Bicep観点のWBS)

> 以下は `bicep-si` プリセットが追記する指示。上記コア手順で `tasks.md` を生成する際・
> 生成後に反映すること。`tasks.md` の場所は変更しない（feature 直下のまま）。

### WBS 生成の観点（Bicep / 構築フェーズ）

- 構成は **`600_build/` 配下の Bicep 構築作業**に対応させる。典型的な並び:
  1. Setup: `600_build/` 雛形、`main.bicep` の `targetScope`、共通変数・タグ、`.bicepparam`
  2. Foundational: 共有モジュール（ネットワーク、ID/RBAC、Key Vault、Log Analytics 等）
  3. ユーザストーリー/ドメインごと: 各 `modules/<domain>-<resource>.bicep` の実装 → `main.bicep` への結線
  4. Polish: パラメータ整理、`@description` 補完、ドキュメント更新
- 各タスクの**ファイルパスは `600_build/...` を明記**する。
- **単体テスト実施タスクは tasks.md に含めない。** テストは別工程（`/speckit.bicep.test-design` で観点設計、`/speckit.bicep.test` で実施）に分離する。tasks.md は構築タスクに集中させる。
- 詳細設計（`300_detail-design/detail-design.md`）のモジュール一覧・依存関係を直接の入力として用いる。

### index 更新

`FEATURE_DIR/000_index.md` の **500 タスク分解** 行を `✅` に更新する（存在しなければスキップ）。
