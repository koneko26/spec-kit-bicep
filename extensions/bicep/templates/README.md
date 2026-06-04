# I/O テンプレート索引 (bicep extension)

このディレクトリは Bicep SI キットの **Input / Output テンプレート格納場所**です。各コマンドが
どのテンプレートを入力の手本／出力の雛形として使うかを示します。テンプレートは Spec Kit の
解決スタック（overrides → presets → extensions → core）で参照されます。

## コマンド × Input / Output 対応表

| コマンド / 工程 | Input テンプレ（手本） | Output テンプレ（成果物の雛形） |
|---|---|---|
| `/speckit.specify`（要件定義） | [inputs/specify-input.md](inputs/specify-input.md) | `spec-template`（preset の append） |
| `/speckit.bicep.basic-design`（基本設計） | [inputs/basic-design-input.md](inputs/basic-design-input.md) | [basic-design-template.md](basic-design-template.md) |
| `/speckit.bicep.detail-design`（詳細設計） | [inputs/detail-design-input.md](inputs/detail-design-input.md) | [detail-design-template.md](detail-design-template.md) ＋ Bicep 雛形 [bicep-module-template.bicep](bicep-module-template.bicep) |
| `/speckit.bicep.test-design`（単体テスト設計） | （設計から導出） | [unit-test-spec-template.md](unit-test-spec-template.md) |
| `/speckit.implement`（構築） | （tasks.md / 詳細設計） | Bicep 雛形 [bicep-module-template.bicep](bicep-module-template.bicep) |
| `/speckit.bicep.test`（単体テスト実施） | unit-test-spec（観点） | テスト結果（700_unit-test/） |

## 格納場所

```text
extensions/bicep/templates/
├── inputs/                       # Input テンプレ（入力の手本・Few-shot 例）
│   ├── specify-input.md
│   ├── basic-design-input.md
│   └── detail-design-input.md
├── basic-design-template.md      # Output: 基本設計書
├── detail-design-template.md     # Output: 詳細設計書
├── unit-test-spec-template.md    # Output: 単体テスト仕様書
└── bicep-module-template.bicep   # Output: Bicep モジュール雛形（best-practice skeleton）
```

> 要件定義の Output テンプレ（`spec-template`）は preset `bicep-si` 側で append 合成されます
> （[presets/bicep-si/templates/spec-template.md](../../../presets/bicep-si/templates/spec-template.md)）。

## 作成方針（Claude ベストプラクティス）

各コマンドのプロンプトは Claude の prompt-engineering ベストプラクティスに沿って構成しています:
**役割の明示** / **出力前に要点を計画（think-first）** / **Input テンプレを Few-shot 例として参照** /
**出力フォーマットの固定（本テンプレ）** / **完了前の自己検証チェック**。
