# 入力テンプレート: 詳細設計 (/speckit.bicep.detail-design)

通常は引数なしで基本設計から自動生成できる。**Bicep 実装方針を指定したい場合**に以下を渡す。

## 記入ひな形

```text
AVM方針: <例: AVM を最優先 / 主要リソースのみAVM / 自作中心（理由）>
モジュール粒度: <例: ドメイン単位 / リソース単位>
パラメータ方針: <例: 環境別 .bicepparam を dev/stg/prod で用意>
targetScope: <resourceGroup / subscription / managementGroup / tenant>
命名/タグ実装: <例: 共通タグ変数 + uniqueString で命名>
```

## 良い入力例（Few-shot）

```text
AVM方針: Azure Verified Modules を最優先。無い場合のみ自作し理由を明記
モジュール粒度: ドメイン単位（network / security / monitoring）
パラメータ方針: 環境別 main.dev.bicepparam / main.prod.bicepparam
targetScope: subscription（複数RGをまたぐため）
命名/タグ実装: 共通タグを変数化し union() で各リソースへ適用
```
