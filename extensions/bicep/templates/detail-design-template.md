# 詳細設計書: [FEATURE NAME]

**Feature**: `[###-feature-name]` | **作成日**: [DATE] | **元設計**: [link to 200_basic-design/basic-design.md]
**前提方針**: Bicep ベストプラクティスに準拠（モジュール化、デコレータ、`.bicepparam`、シークレットの非ハードコード）。

## 1. モジュール分割方針

[`main.bicep`（オーケストレーション）＋ `modules/` 配下の責務分割。Azure Verified Modules (AVM) の採否と理由。]

## 2. モジュール一覧と責務

| モジュール | 責務 | 主なリソース | 入力(params) | 出力(outputs) |
|------------|------|--------------|--------------|---------------|
| main.bicep | オーケストレーション | - | | |
| modules/... | | | | |

## 3. パラメータ設計

[`@description` / `@allowed` / `@secure` / `@minLength` 等のデコレータ方針。環境別 `.bicepparam`。シークレットは Key Vault 参照（`getSecret` / existing keyVault）。ハードコード禁止。]

| パラメータ | 型 | デコレータ | 既定値 | 環境差分 |
|------------|----|-----------|--------|---------|
| | | | | |

## 4. 変数・命名・タグ実装

[基本設計の命名規則・必須タグを Bicep でどう実装するか（`uniqueString`、共通タグ変数、`union()` 等）。]

## 5. リソース個別設定

| リソース | SKU/階層 | ネットワーク | ID | 診断設定 |
|----------|----------|--------------|----|---------|
| | | | | |

## 6. 依存関係

[暗黙依存と明示 `dependsOn` の方針、モジュール適用順序。]

## 7. デプロイスコープ

**targetScope**: [resourceGroup / subscription / managementGroup / tenant] — 理由: [..]

## 8. ソース配置（規約）

本フィーチャの Bicep ソースは **`600_build/`** 配下に置く（トップレベル `infra/` は作らない）。

```text
600_build/
├── main.bicep
├── main.bicepparam            # または環境別 main.<env>.bicepparam
└── modules/
    ├── <domain>-<resource>.bicep
    └── ...
```

## トレーサビリティ

| 詳細設計項目 | 対応する基本設計 / 要件 |
|--------------|--------------------------|
| | |
