---
description: "[bicep-si] After spec creation, scaffold the numbered SI phase folders (100-700) and 000_index.md."
---

## Bicep-SI 追加指示 (specify: 番号フォルダの足場作り)

> 以下は `bicep-si` プリセットが追記する指示。上記コア手順で `SPEC_FILE` を
> `FEATURE_DIR/spec.md` に作成し終えた **後** に実行すること。

`FEATURE_DIR`（= `.specify/feature.json` の `feature_directory`）配下に、SI 工程の番号フォルダ
一式と工程インデックスを作成する。**コアが直下固定で要求するファイル（spec.md / plan.md /
tasks.md 等）は移動しない。** 番号 `100_` と `500_` の箱には実体ではなくポインタ README を置く（A2方式）。

### 1. 番号フォルダを作成

```
FEATURE_DIR/100_requirements/
FEATURE_DIR/200_basic-design/
FEATURE_DIR/300_detail-design/
FEATURE_DIR/400_test-design/
FEATURE_DIR/500_tasks/
FEATURE_DIR/600_build/
FEATURE_DIR/700_unit-test/
```

### 2. ポインタ README を作成（実体が直下にある工程）

- `100_requirements/README.md`:
  > 要件定義の実体は `../spec.md` です（spec-kit のスクリプトが feature 直下固定で要求するため）。要件明確化（clarify）の記録も同ファイル内に追記されます。
- `500_tasks/README.md`:
  > タスク一覧の実体は `../tasks.md` です（同上）。整合性チェック結果は本フォルダの `analysis-report.md` に出力されます。
- `300_detail-design/README.md`（任意）:
  > 詳細設計書は本フォルダの `detail-design.md`。連動する機械可読な `plan.md` は `../plan.md`（直下）にあります。

### 3. 工程インデックス `FEATURE_DIR/000_index.md` を作成

既に存在する場合は上書きせず、無い行のみ補う。書式:

```markdown
# 工程インデックス: <FEATURE NAME>
**Feature**: <feature-dir-name> ｜ **最終更新**: <YYYY-MM-DD>

| # | 工程 | 成果物 | 場所 | コマンド | 状態 |
|---|------|--------|------|----------|------|
| 100 | 要件定義 | spec.md | `./spec.md` | `/speckit.specify` | ✅ |
| 100+ | 要件明確化 | spec.md 内 Clarifications | `./spec.md` | `/speckit.clarify` | ⬜ |
| 200 | 基本設計 | 基本設計書 | `./200_basic-design/basic-design.md` | `/speckit.bicep.basic-design` | ⬜ |
| 300 | 詳細設計 | 詳細設計書 / plan.md | `./300_detail-design/detail-design.md` / `./plan.md` | `/speckit.bicep.detail-design` | ⬜ |
| 400 | 単体テスト設計 | 単体テスト仕様書 | `./400_test-design/unit-test-spec.md` | `/speckit.bicep.test-design` | ⬜ |
| 500 | タスク分解 | tasks.md | `./tasks.md` | `/speckit.tasks` | ⬜ |
| 500+ | 整合性チェック | 分析レポート | `./500_tasks/analysis-report.md` | `/speckit.analyze` | ⬜ |
| 600 | 構築 | Bicep ソース | `./600_build/` | `/speckit.implement` | ⬜ |
| 700 | 単体テスト | テスト結果 | `./700_unit-test/test-results.md` | `/speckit.bicep.test` | ⬜ |
```

### 4. 完了報告に追記

作成した番号フォルダと `000_index.md` のパスを報告し、次工程 `/speckit.clarify`（任意）または
`/speckit.bicep.basic-design` を案内する。
