---
description: "[bicep-si] Write the consistency analysis report to 500_tasks/ and update the index."
---

## Bicep-SI 追加指示 (analyze: レポート出力先と索引)

> 以下は `bicep-si` プリセットが追記する指示。上記コア手順の整合性分析を実施した **後** に反映すること。

- 分析結果（成果物間の整合性・カバレッジ・矛盾）を **`FEATURE_DIR/500_tasks/analysis-report.md`** に
  Markdown で保存する（`500_tasks/` が無ければ作成）。最低限、次を含める:
  - 対象成果物（spec.md / 200・300 設計 / 400 テスト仕様 / tasks.md）の一覧と版
  - 検出した不整合・未カバー要件・重複の表（重大度付き）
  - 推奨アクション
- Bicep 観点の整合性も確認する: 詳細設計のモジュール一覧と tasks.md の構築タスクの対応、
  命名規則・必須タグ・シークレット方針が設計と矛盾しないか、400 のテスト観点が設計を網羅するか。
- `FEATURE_DIR/000_index.md` の **500+ 整合性チェック** 行を `✅` に更新する。
